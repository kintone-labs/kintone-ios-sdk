//
//  UpdateGeneralSettings.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

class UpdateGeneralSettings: NSObject {
    private var app: Int?
    private var revision: Int?
    
    public func getApp() -> Int? {
        return self.app
    }
    public func setApp(_ app: Int) {
        self.app = app
    }
    public func getRevision() -> Int? {
        return self.revision
    }
    public func setRevision(_ revision: Int) {
        self.revision = revision
    }
    
    public init(_ app: Int, _ revision: Int) {
        self.app =  app
        self.revision = revision
    }
}
