//
//  Connection.swift
//  kintone-ios-sdk
//
//  Created by h001218 on 2018/08/31.
//  Copyright © 2018年 h001218. All rights reserved.
//
import Promises

open class Connection: NSObject {
    
    /// HTTP header content-type for getting json data from rest api.
    private let JSON_CONTENT = "application/json"
    
    /// HTTP header content-type for multipart/form-data
    private let MULTIPART_CONTENT = "multipart/form-data; boundary="
    
    /// User agent http header.
    private var userAgent = ConnectionConstants.USER_AGENT_VALUE
    
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
        
        if let version = Bundle(for: type(of: self)).object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            self.userAgent += "/" + version
        }
    }
    
    /// Constructor for init a connection object to connect to normal space.
    ///
    /// - Parameters:
    ///   - domain: Kintone domain url
    ///   - auth: Credential information
    public convenience init(_ domain: String, _ auth: Auth) {
        self.init(domain, auth, -1)
    }
    
    /// Asynchronous Rest http request.
    /// This method is execute file download
    ///
    /// - Parameter body: String
    /// - Returns: Data
    /// - Throws: KintoneAPIException
    open func downloadFile(_ body: String) -> Promise<Data> {
        return Promise { fullfill, reject in
            var urlString: String = ""
            do {
                urlString = try self.getURL(ConnectionConstants.FILE, nil)
            } catch {
                reject(KintoneAPIException("Invalid URL"))
            }
            
            let url = URL(string: urlString)!
            var request = URLRequest(url: url)
            
            request = self.setHTTPHeaders(request)
            request.httpMethod = ConnectionConstants.POST_REQUEST
            
            request.addValue(self.JSON_CONTENT, forHTTPHeaderField: ConnectionConstants.CONTENT_TYPE_HEADER)
            request.addValue(ConnectionConstants.GET_REQUEST, forHTTPHeaderField: ConnectionConstants.METHOD_OVERRIDE_HEADER)
            
            request.httpBody = body.data(using: String.Encoding.utf8)
            
            let config = self.setURLSessionConfiguration()
            config.requestCachePolicy = .reloadIgnoringLocalCacheData
            config.urlCache = nil
            
            let session = URLSession(configuration: config)
            
            self.execute(session, request).then { (data, response, error) in
                if (data != nil || response != nil){
                    do {
                        try self.checkStatus(response, data, body, nil)
                        fullfill(data!)
                    } catch let error as KintoneAPIException {
                        reject(error)
                    } catch {
                        reject(KintoneAPIException("an error occurred while receiving data"))
                    }
                }
            }.catch { error in
                reject(error)
            }
        }
    }
    
    /// Asynchronous Rest http request.
    /// This method is execute file upload.
    ///
    /// - Parameters:
    ///   - fileName: String
    ///   - binaryData: Data
    /// - Returns: Data
    /// - Throws: KintoneAPIException
    open func uploadFile(_ fileName: String, _ binaryData: Data) -> Promise<Data> {
        return Promise { fullfill, reject in
            var urlString = ""
            do {
                urlString = try self.getURL(ConnectionConstants.FILE, nil)
            } catch {
                reject(KintoneAPIException("Invalid URL"))
            }
            
            let url = URL(string: urlString)!
            var request = URLRequest(url: url)
            
            request = self.setHTTPHeaders(request)
            request.httpMethod = ConnectionConstants.POST_REQUEST
            
            request.addValue(self.MULTIPART_CONTENT + ConnectionConstants.BOUNDARY, forHTTPHeaderField: ConnectionConstants.CONTENT_TYPE_HEADER)
            
            var body = Data()
            var bodyText = ""
            
            bodyText += "--\(ConnectionConstants.BOUNDARY)\r\n"
            bodyText += "Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n"
            bodyText += "\(ConnectionConstants.CONTENT_TYPE_HEADER): \(ConnectionConstants.DEFAULT_CONTENT_TYPE)\r\n\r\n"
            
            body.append(bodyText.data(using: String.Encoding.utf8)!)
            body.append(binaryData)
            
            var footerText = ""
            footerText += "\r\n--\(ConnectionConstants.BOUNDARY)--\r\n"
            
            body.append(footerText.data(using: String.Encoding.utf8)!)
            
            request.httpBody = body
            
            let session = URLSession(configuration: self.setURLSessionConfiguration())
            
            self.execute(session, request).then { (data, response, error) in
                if (data != nil || response != nil){
                    do {
                        try self.checkStatus(response, data, nil, nil)
                        let jsonobject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                        let dataParse = try JSONSerialization.data(withJSONObject: jsonobject, options: [])
                        fullfill(dataParse)
                    } catch let error as KintoneAPIException {
                        reject(error)
                    } catch {
                        reject(KintoneAPIException("an error occurred while receiving data"))
                    }
                }
            }.catch { error in
                reject(error)
            }
        }
    }
    
    /// Asynchornous rest http request.
    /// This method is low level api, use the correspondence methods in module package instead.
    ///
    /// - Parameters:
    ///   - method: rest http method. Only accept "GET", "POST", "PUT", "DELETE" value.
    ///   - apiName: apiName
    ///   - body: json object
    /// - Returns: Promise
    /// - Throws: KintoneAPIException
    open func request(_ method: String, _ apiName: String, _ body: String) -> Promise<Data> {
        return Promise { fullfill, reject in
            var urlString = ""
            var isGet = false
            
            if (ConnectionConstants.GET_REQUEST == method){
                isGet = true
            }
            
            do {
                urlString = try self.getURL(apiName, nil)
            } catch {
                reject(KintoneAPIException("Invalid URL"))
            }
            
            let url = URL(string: urlString)!
            var request = URLRequest(url: url)
            
            request = self.setHTTPHeaders(request)
            if (isGet) {
                request.httpMethod = ConnectionConstants.POST_REQUEST
            } else {
                request.httpMethod = method
            }
            
            request.addValue(self.JSON_CONTENT, forHTTPHeaderField: ConnectionConstants.CONTENT_TYPE_HEADER)
            if (isGet) {
                request.addValue(method, forHTTPHeaderField: ConnectionConstants.METHOD_OVERRIDE_HEADER)
            }
            
            request.httpBody = body.data(using: String.Encoding.utf8)
            
            let session = URLSession(configuration: self.setURLSessionConfiguration())
            
            self.execute(session, request).then { (data, response, error) in
                if (data != nil || response != nil){
                    do {
                        try self.checkStatus(response, data, body, apiName)
                        let jsonobject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                        let dataParse = try JSONSerialization.data(withJSONObject: jsonobject, options: [])
                        fullfill(dataParse)
                    } catch let error as KintoneAPIException {
                        reject(error)
                    } catch {
                        reject(KintoneAPIException("an error occurred while receiving data"))
                    }
                }
            }.catch { error in
                reject(error)
            }
        }
    }
    
    /// Asynchronous HTTP communication execution processing
    ///
    /// - Parameters:
    ///   - session: session
    ///   - request: request
    /// - Returns: Data?, URLResponse?, NSError?
    private func execute(_ session: URLSession, _ request: URLRequest) -> Promise<(Data?, URLResponse?, NSError?)> {
        return Promise<(Data?, URLResponse?, NSError?)> { fulfill, reject in
            session.dataTask(with: request) { (data, response, error) -> Void in
                if error != nil {
                    reject(error!)
                }
                fulfill((data, response, error as NSError?))
            }.resume()
        }
    }
    
    /// Get url string from domain name, api name and parameters.
    ///
    /// - Parameters:
    ///   - apiName: api name
    ///   - parameters: parameters
    /// - Returns: String
    private func getURL(_ apiName: String?, _ parameters: String?) throws -> String {
        guard let unwrappedDomain = self.domain else {
            throw KintoneAPIException("domain is empty")
        }
        
        guard let unwrappedApiName = apiName else {
            throw KintoneAPIException("api is empty")
        }
        var sb = ""
        if (!unwrappedDomain.contains(ConnectionConstants.HTTPS_PREFIX)){
            sb.append(ConnectionConstants.HTTPS_PREFIX)
        }
        sb.append(unwrappedDomain)
        
        var urlString = ConnectionConstants.BASE_URL
        if (self.guestSpaceID != nil){
            if (self.guestSpaceID! >= 0) {
                urlString = ConnectionConstants.BASE_GUEST_URL.replacingOccurrences(of: "{GUEST_SPACE_ID}", with: String(self.guestSpaceID!) + "")
            }
        }
        urlString = urlString.replacingOccurrences(of: "{API_NAME}", with: unwrappedApiName)
        
        sb.append(urlString)
        if (parameters != nil){
            sb.append(parameters!)
        }
        
        sb = sb.replacingOccurrences(of: "¥¥s", with: "%20")
        return sb
    }
    
    /// Set HTTP headers for connections.
    ///
    /// - Parameter connection: connection
    /// - Returns: URLRequest
    private func setHTTPHeaders(_ connection: URLRequest) -> URLRequest {
        var request = connection
        for header: HTTPHeader? in self.auth.createHeaderCredentials(){
            if let unwrapHeader = header {
                if let unwrap_getvalue = unwrapHeader.getValue() {
                    if let unwrap_getKey = unwrapHeader.getKey() {
                        request.addValue(unwrap_getvalue, forHTTPHeaderField: unwrap_getKey)
                    }
                }
            }
        }
        
        request.addValue(self.userAgent, forHTTPHeaderField: ConnectionConstants.USER_AGENT_KEY)
        for header in self.headers {
            if let unwrap_getvalue = header.getValue() {
                if let unwrap_getKey = header.getKey() {
                    request.addValue(unwrap_getvalue, forHTTPHeaderField: unwrap_getKey)
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
    open func setHeader(_ key: String, _ value: String) -> Connection {
        self.headers.append(HTTPHeader(key, value));
        return self
    }
    
    /// Set authentication for connection
    ///
    /// - Parameter auth: auth
    /// - Returns: Connection
    open func setAuth(_ auth: Auth) -> Connection {
        self.auth = auth;
        return self;
    }
    
    /// Get kintone domain url of connection.
    ///
    /// - Returns: domain
    open func getDomain() -> String? {
        return self.domain
    }
    
    /// Get guest space id of connection.
    ///
    /// - Returns: guest space id
    open func getGuestSpaceId() -> Int? {
        return self.guestSpaceID
    }
    
    /// Get auth of connection.
    ///
    /// - Returns: Auth?
    open func getAuth() -> Auth? {
        return self.auth
    }
    
    /// Checks the status code of the response.
    ///
    /// - Parameters:
    ///   - response: response
    ///   - data: data
    ///   - body: body
    ///   - apiName: apiName
    /// - Throws: KintoneIOSException
    private func checkStatus(_ response: URLResponse?, _ data: Data?, _ body: String?, _ apiName: String?) throws {
        let http_response = response as? HTTPURLResponse
        let statusCode = http_response?.statusCode
        let decoder: JSONDecoder = JSONDecoder()
        
        if (statusCode == 401) {
            throw KintoneAPIException("401 Unauthorized")
        }
        
        if (statusCode != 200) {
            if (apiName == ConnectionConstants.BULK_REQUEST){
                do {
                    if let unWrapResponses: Array<ErrorResponse> = self.getErrorResponses(data) {
                        if let jsonBody = body?.data(using: String.Encoding.utf8) {
                            let jsonobject = try JSONSerialization.jsonObject(with: jsonBody, options: JSONSerialization.ReadingOptions.allowFragments)
                            
                            let jsonArray = (jsonobject as! NSDictionary)["requests"] as! NSArray
                            let jsonRequest = try JSONSerialization.data(withJSONObject: jsonArray, options: [])
                            let errorResponseList: Array<BulkRequestItem>  = try decoder.decode([BulkRequestItem].self, from: jsonRequest)
                            throw KintoneAPIException(statusCode, errorResponseList, unWrapResponses)
                        } else {
                            throw KintoneAPIException("http status error(\(String(describing: statusCode)))")
                        }
                    } else {
                        if let unWrapResponse = self.getErrorResponse(data) {
                            throw KintoneAPIException(statusCode, unWrapResponse)
                        } else {
                            throw KintoneAPIException("http status error(\(String(describing: statusCode)))")
                        }
                    }
                } catch {
                    throw error
                }
            } else {
                if let unWrapResponse = self.getErrorResponse(data) {
                    throw KintoneAPIException(statusCode, unWrapResponse)
                } else {
                    throw KintoneAPIException("http status error(\(String(statusCode!)))")
                }
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
                let errorResponse  = try decoder.decode(ErrorResponse.self, from: unwrapData)
                return errorResponse
            } catch {
                return nil
            }
        }
        return nil
    }
    
    
    /// Creates an error response list object.
    ///
    /// - Parameter data: <#data description#>
    /// - Returns: <#return value description#>
    private func getErrorResponses(_ data: Data?) -> Array<ErrorResponse>? {
    
        let decoder = JSONDecoder()
        
        if let unwrapData = data {
            do {
                let parsedData = try JSONSerialization.jsonObject(with: unwrapData, options: .allowFragments)
                if let unwrapJsonArray = (parsedData as! NSDictionary)["results"] {
                    let jsonArray = unwrapJsonArray as! NSArray
                    let target = try JSONSerialization.data(withJSONObject: jsonArray, options: [])
                    let errorResponseList: Array<ErrorResponse>  = try decoder.decode([ErrorResponse].self, from: target)
                    return errorResponseList
                } else {
                    return nil
                }
            } catch {
                return nil
            }
        }
        return nil
    }
    
    /// setting session configuration
    ///
    /// - Returns: URLSessionConfiguration
    private func setURLSessionConfiguration() -> URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        if (self.proxyHost != nil || self.proxyPort != nil) {
            config.requestCachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
            config.connectionProxyDictionary = [AnyHashable: Any]()
            config.connectionProxyDictionary?[kCFNetworkProxiesHTTPEnable as String] = 1
            config.connectionProxyDictionary?[kCFNetworkProxiesHTTPProxy as String] = self.proxyHost
            config.connectionProxyDictionary?[kCFNetworkProxiesHTTPPort as String] = self.proxyPort
            config.connectionProxyDictionary?[kCFStreamPropertyHTTPSProxyHost as String] = self.proxyHost
            config.connectionProxyDictionary?[kCFStreamPropertyHTTPSProxyPort as String] = self.proxyPort
        }
        return config
    }
    
    /// Sets the proxy host.
    ///
    /// - Parameters:
    ///   - host: proxy host
    ///   - port: proxy port
    open func setProxy(_ host: String, _ port: Int) {
        self.proxyHost = host
        self.proxyPort = port
    }
    
    /// Get uri string from api name.
    ///
    /// - Parameter apiName: apiName
    /// - Returns: String
    open func getPathURI(_ apiName: String) -> String {
        var pathURI = ""
        
        if (self.guestSpaceID != nil){
            if (self.guestSpaceID! >= 0) {
                pathURI = ConnectionConstants.BASE_GUEST_URL
                pathURI = pathURI.replacingOccurrences(of: "{GUEST_SPACE_ID}", with: String(self.guestSpaceID!) + "")
            } else {
                pathURI = ConnectionConstants.BASE_URL
            }
        } else {
            pathURI = ConnectionConstants.BASE_URL
        }
        
        pathURI = pathURI.replacingOccurrences(of: "{API_NAME}", with: apiName)
        return pathURI
    }
}
