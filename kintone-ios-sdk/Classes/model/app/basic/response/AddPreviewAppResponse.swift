//
//  AddPreviewAppResponse.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

class AddPreviewAppResponse: NSObject {
    private var revision: Int?
    private var app: Int?
    
    public func getRevision() -> Int? {
        return self.revision
    }
    public func setRevision(_ revision: Int) {
        self.revision = revision
    }
    public func getApp() -> Int? {
        return self.app
    }
    public func setApp(_ app: Int) {
        self.app = app
    }
    
    public init(_ revision: Int, _ app: Int) {
        self.revision = revision
        self.app =  app
    }
}
