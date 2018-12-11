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
    
    public init(_ domain: String?, _ certData: Data?, _ password: String?) {
        self.domain = domain
        self.password = password
        self.certData = certData!
    }
    
    func didReceive(serverTrustChallenge challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // We override server trust evaluation (`NSURLAuthenticationMethodServerTrust`) to allow the
        // server to use a custom root certificate (`MouseCA.cer`).
        let customRoot = Bundle.main.certificate(named: "MouseCA")
        let trust = challenge.protectionSpace.serverTrust!
        if trust.evaluateAllowing(rootCertificates: [customRoot]) {
            completionHandler(.useCredential, URLCredential(trust: trust))
        } else {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
    
    func didReceive(clientIdentityChallenge challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // We handle the client identity authentication challenge (`NSURLAuthenticationMethodClientCertificate`)
        // to give the server our `Frankie.p12` client identity.
        var identity: SecIdentity
        identity = Bundle.main.identityData(certData: self.certData!, password: self.password!)
        completionHandler(.useCredential, URLCredential(identity: identity, certificates: nil, persistence: .forSession))
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        // Look for specific authentication challenges and dispatch those to various helper methods.
        //
        // IMPORTANT: It's critical that, if you get a challenge you weren't expecting,
        // you resolve that challenge with `.performDefaultHandling`.
        
        switch (challenge.protectionSpace.authenticationMethod, "https://" + challenge.protectionSpace.host) {
//        case (NSURLAuthenticationMethodServerTrust, self.domain!):
//            print(1)
//            self.didReceive(serverTrustChallenge: challenge, completionHandler: completionHandler)
        case (NSURLAuthenticationMethodClientCertificate, self.domain!):
            self.didReceive(clientIdentityChallenge: challenge, completionHandler: completionHandler)
        default:
            completionHandler(.performDefaultHandling, nil)
        }
    }
}
