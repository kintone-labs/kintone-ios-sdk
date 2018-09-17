//
//  Connection.swift
//  kintone-ios-sdk
//
//  Created by h001218 on 2018/08/31.
//  Copyright © 2018年 h001218. All rights reserved.
//

import UIKit

class Connection: NSObject {
    
    /// HTTP header content-type for getting json data from rest api.
    private let JSON_CONTENT: String = "application/json"
    
    /// User agent http header.
    private var userAgent: String = ConnectionConstants.USER_AGENT_VALUE
    
    /// Object contains user's credential.
    private var auth: Auth
    
    /// Kintone domain url.
    private var domain: String?

    /// Guest space number in kintone domain.
    /// User describe it when connect data in guest space.
    private var guestSpaceID: Int? = -1
    
    /// Contains addition headers user set.
    private var headers: Array<HTTPHeader> = []
    
    /// Contains information for bypass proxy.
    private var proxyHost: String? = nil
    private var proxyPort: Int? = nil
    
    /// Constructor for init a connection object to connect to guest space.
    ///
    /// - Parameters:
    ///   - domain: Kintone domain url
    ///   - auth: Credential information
    ///   - guestSpaceID: guestSpaceId Guest space number in kintone domain.
    public init(_ domain: String?, _ auth: Auth, _ guestSpaceID: Int) {
        self.domain = domain
        self.auth = auth
        self.guestSpaceID = guestSpaceID
    }
    
    /// Constructor for init a connection object to connect to normal space.
    ///
    /// - Parameters:
    ///   - domain: Kintone domain url
    ///   - auth: Credential information
    public convenience init(_ domain: String, _ auth: Auth) {
        self.init(domain, auth, -1)
    }
    
    /**
     * Rest http request.
     * This method is low level api, use the correspondence methods in module package instead.
     *
     * @param method rest http method. Only accept "GET", "POST", "PUT", "DELETE" value.
     * @param apiName
     * @param body body of http request. In case "GET" method, the parameters.
     * @return json object
     * @throws KintoneAPIException
     */
    
    /// Rest http request.
    /// This method is low level api, use the correspondence methods in module package instead.
    ///
    /// - Parameters:
    ///   - method: rest http method. Only accept "GET", "POST", "PUT", "DELETE" value.
    ///   - apiName: apiName
    ///   - body: json object
    /// - Returns: Any?
    /// - Throws: KintoneAPIException
    public func request(_ method: String, _ apiName: String, _ body: String) throws -> Any? {
        
        var isGet: Bool = false
        if (method == ConnectionConstants.GET_REQUEST){
            isGet = true
        }
        
        let urlString: String = self.getURL(apiName, nil)
        let url: URL = URL(string: urlString)!
        var request = URLRequest(url: url)
        
        request = self.setHTTPHeaders(request)
        request.httpMethod = ConnectionConstants.POST_REQUEST
        
        request.addValue(JSON_CONTENT, forHTTPHeaderField: ConnectionConstants.CONTENT_TYPE_HEADER)
        if (isGet) {
            request.addValue(ConnectionConstants.GET_REQUEST, forHTTPHeaderField: ConnectionConstants.METHOD_OVERRIDE_HEADER)
        }
        
        request.httpBody = body.data(using: String.Encoding.utf8)
        
        let session: URLSession = URLSession.shared
        
        let (data, response, error) = self.execute(session, request)
        
        if (error != nil){
            print(error!)
            return nil
        }
        if (data != nil || response != nil){
            do {
                try self.checkStatus(response, data, body)
                return try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            }
            //catch {
            //    throw KintoneAPIException("an error occurred while receiving data")
            //}
        }
        return nil
    }
 
    ///
    ///
    /// - Parameters:
    ///   - session: session
    ///   - request: request
    /// - Returns: Data?, URLResponse?, NSError?
    private func execute(_ session: URLSession, _ request: URLRequest) -> (Data?, URLResponse?, NSError?) {
        var tmpData: Data? = nil
        var tmpResponse: URLResponse? = nil
        var tmpError: NSError? = nil
        let semaphore = DispatchSemaphore(value: 0)
        session.dataTask(with: request) { (data, response, error) -> Void in
            tmpData = data as Data?
            tmpResponse = response
            tmpError = error as NSError?
            semaphore.signal()
        }.resume()
        _ = semaphore.wait(timeout: DispatchTime.now() + 100)
        return (tmpData, tmpResponse, tmpError)
    }
    
    /// Get url string from domain name, api name and parameters.
    ///
    /// - Parameters:
    ///   - apiName: api name
    ///   - parameters: parameters
    /// - Returns: String
    private func getURL(_ apiName: String?, _ parameters: String?) -> String {
        guard let unwrappedDomain = self.domain else {
            print("domain is empty")
            return ""
        }
        
        guard let unwrappedApiName = apiName else {
            print("api is empty")
            return ""
        }
        var sb: String = ""
        if (!unwrappedDomain.contains(ConnectionConstants.HTTPS_PREFIX)){
            sb.append(ConnectionConstants.HTTPS_PREFIX)
        }
        sb.append(unwrappedDomain)
        
        var urlString: String = ConnectionConstants.BASE_URL
        
        if let range: Range = urlString.range(of: "{API_NAME}"){
            urlString.replaceSubrange(range, with: unwrappedApiName)
        }
        sb.append(urlString)
        if (parameters != nil){
            sb.append(parameters!)
        }
        
        if let range2: Range = sb.range(of: "¥¥s") {
            sb.replaceSubrange(range2, with: "%20")
        }
        return sb
    }
    
    /// Set HTTP headers for connections.
    ///
    /// - Parameter connection: connection
    /// - Returns: URLRequest
    private func setHTTPHeaders(_ connection: URLRequest) -> URLRequest {
        var request: URLRequest = connection
        for header: HTTPHeader? in self.auth.createHeaderCredentials(){
            if let unwrapHeader = header {
                if let unwrap_getvalue = unwrapHeader.getValue() {
                    if let unwrap_getKey = unwrapHeader.getKey() {
                        request.addValue(unwrap_getvalue, forHTTPHeaderField: unwrap_getKey)
                    }
                }
            }
        }
        return request
    }
    
    /// Set addition header when connect.
    ///
    /// - Parameters:
    ///   - key: key
    ///   - value: value
    /// - Returns: Connection
    public func setHeader(_ key: String, _ value: String) -> Connection {
        self.headers.append(HTTPHeader(key, value));
        return self
    }
    
    /// Set authentication for connection
    ///
    /// - Parameter auth: auth
    /// - Returns: Connection
    public func setAuth(_ auth: Auth) -> Connection {
        self.auth = auth;
        return self;
    }
    
    /// Get kintone domain url of connection.
    ///
    /// - Returns: domain
    public func getDomain() -> String? {
        return self.domain
    }
    
    /// Get guest space id of connection.
    ///
    /// - Returns: guest space id
    public func getGuestSpaceId() -> Int? {
        return self.guestSpaceID
    }
    
    /// Get auth of connection.
    ///
    /// - Returns: Auth?
    public func getAuth() -> Auth? {
        return self.auth
    }
    
    /// Checks the status code of the response.
    ///
    /// - Parameters:
    ///   - response: response
    ///   - data: data
    ///   - body: body
    /// - Throws: KintoneIOSException
    private func checkStatus(_ response: URLResponse?, _ data: Data?, _ body: String?) throws {
        let http_response = response as? HTTPURLResponse
        let statusCode: Int? = http_response?.statusCode
        
        if (statusCode == 404) {
            if let unWrapResponse: ErrorResponse = self.getErrorResponse(data) {
                throw KintoneAPIException(statusCode, unWrapResponse)
            }else{
                throw KintoneAPIException("not found")
            }
        }
        
        if (statusCode == 401) {
            throw KintoneAPIException("401 Unauthorized")
        }
        
        if (statusCode != 200) {
            if let unWrapResponse: ErrorResponse = self.getErrorResponse(data) {
                throw KintoneAPIException(statusCode, unWrapResponse)
            }else{
                throw KintoneAPIException("http status error(" + String(statusCode!) + ")")
            }
        }
    }
    
    /// Creates an error response object.
    ///
    /// - Parameter data: data
    /// - Returns: ErrorResponse?
    private func getErrorResponse(_ data: Data?) -> ErrorResponse? {
        let decoder: JSONDecoder = JSONDecoder()
        
        if let unwrapData = data {
            do {
                let errorResponse: ErrorResponse  = try decoder.decode(ErrorResponse.self, from: unwrapData)
                return errorResponse
            } catch {
                print("json convert failed in JSONDecoder", error.localizedDescription)
            }
        }
        return nil
    }
    
    /// Sets the proxy host.
    ///
    /// - Parameters:
    ///   - host: proxy host
    ///   - port: proxy port
    public func setProxy(_ host: String, _ port: Int) {
        self.proxyHost = host
        self.proxyPort = port
    }
    
    /// Get uri string from api name.
    ///
    /// - Parameter apiName: apiName
    /// - Returns: String
    public func getPathURI(_ apiName: String) -> String {
        var pathURI: String = ""
        
        if (self.guestSpaceID != nil){
            if (self.guestSpaceID! >= 0) {
                pathURI = ConnectionConstants.BASE_GUEST_URL
                if let range: Range = pathURI.range(of: "{GUEST_SPACE_ID}") {
                    pathURI.replaceSubrange(range, with: String(self.guestSpaceID!) + "")
                }
            } else {
                pathURI = ConnectionConstants.BASE_URL
            }
        } else {
            pathURI = ConnectionConstants.BASE_URL
        }
        
        if let range: Range = pathURI.range(of: "{API_NAME}") {
            pathURI.replaceSubrange(range, with: apiName)
        }
        return pathURI
    }
}
