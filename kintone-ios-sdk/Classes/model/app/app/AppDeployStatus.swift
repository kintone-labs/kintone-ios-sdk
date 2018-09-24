//
//  AppDeployStatus.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

class AppDeployStatus: NSObject, Codable {
    private var app: String?
    private var status: Status?
    
    public enum Status: String, Codable {
        case PROCESSING
        case SUCCESS
        case FAIL
        case CANCEL
    }
    
    public func getApp() -> String? {
        return self.app
    }
    public func setApp(_ app: String) {
        self.app = app
    }
    public func getStatus() -> Status? {
        return self.status
    }
    public func setStatus(_ status: Status) {
        self.status = status
    }
    
    init(_ app: String?, _ status: Status?) {
        self.app = app
        self.status = status
    }
}
