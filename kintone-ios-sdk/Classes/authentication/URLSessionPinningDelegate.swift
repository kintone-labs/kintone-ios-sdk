//
//  URLSessionPinningDelegate.swift
//  kintone-ios-sdk
//
//  Created by Nguyen Phong Nhat on 11/30/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

import Foundation
import Security

class URLSessionPinningDelegate: NSObject, URLSessionDelegate
{
    private var domain: String?
    private var password: String?
    private var certData: Data?
    private var usePath: Bool?
    private var certPath: String?
    
    public init(_ domain: String?) {
        self.domain = domain
    }
    
    public func setCertByData( _ certData: Data?, _ password: String?) {
        self.password = password
        self.certData = certData!
        self.usePath = false
    }
    
    public func setCertByPath(_ certPath: String?, _ password: String?) {
        self.password = password
        self.certPath = certPath!
        self.usePath = true
    }
    
    func didReceive(serverTrustChallenge challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let customRoot = Bundle.main.certificate(named: "MouseCA")
        let trust = challenge.protectionSpace.serverTrust!
        if trust.evaluateAllowing(rootCertificates: [customRoot]) {
            completionHandler(.useCredential, URLCredential(trust: trust))
        } else {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
    
    func didReceive(clientIdentityChallenge challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        var identity: SecIdentity
        if self.usePath ?? false {
            identity = Bundle.main.identity(filepath: self.certPath!, password: self.password!)
        }
        else {
            identity = Bundle.main.identityData(certData: self.certData!, password: self.password!)
        }
        completionHandler(.useCredential, URLCredential(identity: identity, certificates: nil, persistence: .forSession))
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        switch (challenge.protectionSpace.authenticationMethod, "https://" + challenge.protectionSpace.host) {
        case (NSURLAuthenticationMethodClientCertificate, self.domain!):
            self.didReceive(clientIdentityChallenge: challenge, completionHandler: completionHandler)
        default:
            completionHandler(.performDefaultHandling, nil)
        }
    }
}
