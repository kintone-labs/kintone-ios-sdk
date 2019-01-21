//
//  ExtensionCommon.swift
//  kintone-ios-sdk
//
//  Copyright © 2018 Cybozu. All rights reserved.
//

import Security
import Foundation

extension Bundle {
    
    func certificate(named name: String) -> SecCertificate {
        let cerURL = self.url(forResource: name, withExtension: "cer")!
        let cerData = try! Data(contentsOf: cerURL)
        let cer = SecCertificateCreateWithData(nil, cerData as CFData)!
        return cer
    }
    
    func identityData(certData: Data, password: String) -> (status: OSStatus, data:SecIdentity?) {
        var importedCF: CFArray? = nil
        let options = [kSecImportExportPassphrase as String: password]
        let err = SecPKCS12Import(certData as CFData, options as CFDictionary, &importedCF)
        if err == errSecAuthFailed {
            return(status: err, data: nil)
        }
        precondition(err == errSecSuccess)
        let imported = importedCF! as Array as! [[String:AnyObject]]
        precondition(imported.count == 1)
        return(status: err, data: ((imported[0][kSecImportItemIdentity as String]!) as! SecIdentity))
    }
    
    func identity(filepath: String, password: String) -> (status: OSStatus, data:SecIdentity?) {
        let url = URL(string: filepath)
        let p12Data = try! Data(contentsOf: url!)
        var importedCF: CFArray? = nil
        let options = [kSecImportExportPassphrase as String: password]
        let err = SecPKCS12Import(p12Data as CFData, options as CFDictionary, &importedCF)
        if err == errSecAuthFailed {
            return(status: err, data: nil)
        }
        precondition(err == errSecSuccess)
        let imported = importedCF! as Array as! [[String:AnyObject]]
        precondition(imported.count == 1)
        return(status: err, data:((imported[0][kSecImportItemIdentity as String]!) as! SecIdentity))
    }
}

extension SecTrust {
    
    func evaluate() -> Bool {
        var trustResult: SecTrustResultType = .invalid
        let err = SecTrustEvaluate(self, &trustResult)
        guard err == errSecSuccess else { return false }
        return [.proceed, .unspecified].contains(trustResult)
    }
    
    func evaluateAllowing(rootCertificates: [SecCertificate]) -> Bool {
        // Apply our custom root to the trust object.
        var err = SecTrustSetAnchorCertificates(self, rootCertificates as CFArray)
        guard err == errSecSuccess else { return false }
        
        // Re-enable the system's built-in root certificates.
        err = SecTrustSetAnchorCertificatesOnly(self, false)
        guard err == errSecSuccess else { return false }
        
        // Run a trust evaluation and only allow the connection if it succeeds.
        return self.evaluate()
    }
}
