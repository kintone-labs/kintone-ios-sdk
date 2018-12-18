//
//  Auth.swift
//  kintone-ios-sdk
//
//  Created by t000572 on 2018/09/05.
//  Copyright © 2018年 y001112. All rights reserved.
//

open class Auth: NSObject {

    private var basicAuth: Credential?
    private var passwordAuth: Credential?
    private var apiToken: String?
    
    /// Connection with cert file or not
    var withCert = false
    var password = ""
    var certData: Data?
    var certPath: String?
    var useCertPath = false
    
    open func setClientCert(_ certData: Data?, _ password: String?) {
        self.withCert = true
        self.password = password ?? ""
        self.certData = certData!
    }
    
    open func setClientCertByPath(_ certPath: String?, _ password: String?) {
        self.withCert = true
        self.useCertPath = true
        self.certPath = certPath
        self.password = password ?? ""
    }

    /// set basic authentication
    ///
    /// - Parameters:
    ///   - username: Basic login name
    ///   - password: Basic login password
    /// - Returns: basic authentication
    open func setBasicAuth(_ username: String, _ password: String) -> Auth {
        self.basicAuth = Credential(username, password)
        return self
    }

    /// get basic authentication
    ///
    /// - Returns: basic authentication
    open func getBasicAuth() -> Credential? {
        return self.basicAuth
    }

    /// set password authentication
    ///
    /// - Parameters:
    ///   - username: login name
    ///   - password: login password
    /// - Returns: password authentication
    open func setPasswordAuth(_ username: String, _ password: String) -> Auth {
        self.passwordAuth = Credential(username, password)
        return self
    }

    /// get password authentication
    ///
    /// - Returns: password authentication
    open func getPasswordAuth() -> Credential? {
        return self.passwordAuth
    }

    /// set token authentication
    ///
    /// - Parameter apiToken: it was generated in each kintone app
    /// - Returns: token authentication
    open func setApiToken(_ apiToken: String) -> Auth {
        self.apiToken = apiToken
        return self
    }

    /// get token authentication
    ///
    /// - Returns: token authentication
    open func getApiToken() -> String? {
        return self.apiToken
    }

    /// return header credentials for user if tha value of specific Attributes has not empty
    ///
    /// - Returns: header credentials
    open func createHeaderCredentials() -> [HTTPHeader?] {
        var headers: [HTTPHeader?] = []

        if (self.passwordAuth != nil) {
            let passwordAuthString = (self.passwordAuth?.getUsername())! + ":" + (self.passwordAuth?.getPassword())!
            let passwordAuthData = passwordAuthString.data(using: .utf8)
            let httpHeader = HTTPHeader(AuthenticationConstants.HEADER_KEY_AUTH_PASSWORD, passwordAuthData?.base64EncodedString())
            headers.append(httpHeader)
        }

        if (self.apiToken != nil) {
            let httpHeader = HTTPHeader(AuthenticationConstants.HEADER_KEY_AUTH_APITOKEN, self.apiToken)
            headers.append(httpHeader)
        }

        if (self.basicAuth != nil) {
            let basicAuthString = (self.basicAuth?.getUsername())! + ":" + (self.basicAuth?.getPassword())!
            let basicAUthData = basicAuthString.data(using: .utf8)
            let httpHeader = HTTPHeader(AuthenticationConstants.HEADER_KEY_AUTH_BASIC, AuthenticationConstants.AUTH_BASIC_PREFIX + (basicAUthData?.base64EncodedString())!)
            headers.append(httpHeader)
        }
        return headers
    }
}
