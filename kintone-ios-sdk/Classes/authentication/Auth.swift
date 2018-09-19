//
//  Auth.swift
//  kintone-ios-sdk
//
//  Created by t000572 on 2018/09/05.
//  Copyright © 2018年 y001112. All rights reserved.
//

public class Auth: NSObject {

    private var basicAuth: Credential?
    private var passwordAuth: Credential?
    private var apiToken: String?

    /// set basic login name
    ///
    /// - Parameters:
    ///   - username: Basic login name
    ///   - password: Basic login password
    /// - Returns: basic authentication
    public func setBasicAuth(_ username: String?, _ password: String?) -> Auth {
        self.basicAuth = Credential(username, password)
        return self
    }

    /// get basic authentication
    ///
    /// - Returns: basic authentication
    public func getBasicAuth() -> Credential? {
        return self.basicAuth
    }

    /// set password authentication
    ///
    /// - Parameters:
    ///   - username: login name
    ///   - password: login password
    /// - Returns: password authentication
    public func setPasswordAuth(_ username: String?, _ password: String?) -> Auth? {
        self.passwordAuth = Credential(username, password)
        return self
    }

    /// get password authentication
    ///
    /// - Returns: password authentication
    public func getPasswordAuth() -> Credential? {
        return self.passwordAuth
    }

    /// set token authentication
    ///
    /// - Parameter apiToken: it was generated in each kintone app
    /// - Returns: token authentication
    public func setApiToken(_ apiToken: String?) -> Auth? {
        self.apiToken = apiToken
        return self
    }

    /// get token authentication
    ///
    /// - Returns: token authentication
    public func getApiToken() -> String? {
        return self.apiToken
    }

    /// return header credentials for user if tha value of specific Attributes has not empty
    ///
    /// - Returns: header credentials
    public func createHeaderCredentials() -> [HTTPHeader?] {
        var headers: [HTTPHeader?] = []

        if (self.passwordAuth != nil) {
            let passwordAuthString = (self.passwordAuth?.getUsername())! + ":" + (self.passwordAuth?.getPassword())!
            let passwordAuthData = passwordAuthString.data(using: .utf8)
            let httpHeader = HTTPHeader(AuthenticationConstants.HEADER_KEY_AUTH_PASSWORD, (passwordAuthData?.base64EncodedString())!)
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
