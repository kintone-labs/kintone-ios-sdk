//
//  AddPreviewAppResponse.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

class AddPreviewAppResponse: NSObject, Codable {
    private var app: String?
    private var revision: String?
    
    public func getApp() -> String? {
        return self.app
    }
    public func setApp(_ app: String) {
        self.app = app
    }
    public func getRevision() -> String? {
        return self.revision
    }
    public func setRevision(_ revision: String) {
        self.revision = revision
    }
    
    public init(_ app: String, _ revision: String) {
        self.app =  app
        self.revision = revision
    }
}
