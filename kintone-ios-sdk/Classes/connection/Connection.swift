//
//  Connection.swift
//  kintone-ios-sdk
//
//  Created by h001218 on 2018/08/31.
//  Copyright © 2018年 h001218. All rights reserved.
//

import UIKit

class Connection: NSObject {
    
    /*
     * HTTP header content-type for getting json data from rest api.
     */
    private let JSON_CONTENT: String = "application/json"
    
    /*
     * User agent http header.
     */
    private var userAgent: String = ConnectionConstants.USER_AGENT_VALUE
    
    /*
     * Object contains user's credential.
     */
    private var auth: Auth
    
    /*
     * Kintone domain url.
     */
    private var domain: String?

    /*
     * Guest space number in kintone domain.
     * User describe it when connect data in guest space.
     */
    private var guestSpaceID: Int = -1
    
    /*
     * Contains addition headers user set.
     */
    private var headers: Array<HTTPHeader> = []
    
    /*
     * Contains information for bypass proxy.
     */
    private var proxyHost: String? = nil
    private var proxyPort: Int? = nil
    
    /**
     * Constructor for init a connection object to connect to guest space.
     *
     * @param domain Kintone domain url
     * @param auth Credential information
     * @param guestSpaceId Guest space number in kintone domain.
     */
    public init(_ domain: String?, _ auth: Auth, _ guestSpaceID: Int) {
        self.domain = domain
        self.auth = auth
        self.guestSpaceID = guestSpaceID
    }
    
    /**
     * Constructor for init a connection object to connect to normal space.
     *
     * @param domain Kintone domain url
     * @param auth Credential information
     */
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
    public func request(_ method: String, _ apiName: String, _ body: String) -> String {
        
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
        
        // use NSURLSessionDataTask
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let response = response {
                
                do {
                    try self.checkStatus(response, data, body)
                    //return response
                } catch {
                }
                
                //print(response)
                //let json = try? JSONDecoder().decode(AddRecordRequest.self, from: data)
                //json?.api
            }else{
                print("#error########################")
                print(error ?? "error")
                print("#########################")
                //return "error"
            }
        }
        task.resume()
        
        return "sasd"
    }
    
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
        
        return urlString
    }
    
    /**
     * Set HTTP headers for connections.
     *
     * @param connection
     */
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
    
    /**
     * Set addition header when connect.
     *
     * @param key
     * @param value
     * @return
     */
    public func setHeader(_ key: String, _ value: String) -> Connection {
        self.headers.append(HTTPHeader(key, value));
        return self
    }
    
    /**
     * Set authentication for connection
     *
     * @param auth
     * @return connection
     *            Connection object.
     */
    public func setAuth(_ auth: Auth) -> Connection {
        self.auth = auth;
        return self;
    }
    
    private func checkStatus(_ response: URLResponse, _ data: Data?, _ body: String) throws {
        let http_response = response as? HTTPURLResponse
        let statusCode: Int? = http_response?.statusCode
        
        if (statusCode == 404){
            if let unWrapResponse: ErrorResponse = self.getErrorResponse(data) {
                throw KintoneAPIException(statusCode, unWrapResponse)
            }else{
                throw KintoneAPIException("sssss")
            }
            
        }
    }
    
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
    
    
    public func getDomain() -> String? {
        return self.domain
    }
    
    public func getGuestSpaceId() -> Int {
        return self.guestSpaceID
    }
    
    public func getAuth() -> Auth {
        return self.auth
    }
    
    public func setProxy(_ host: String, _ port: Int) {
        self.proxyHost = host
        self.proxyPort = port
    }
}
