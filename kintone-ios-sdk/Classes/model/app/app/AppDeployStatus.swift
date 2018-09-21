//
//  AppDeployStatus.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

class AppDeployStatus: NSObject, Codable {
    private var app: Int?
    private var status: Status?
    
    public enum Status: String {
        case PROCESSING
        case SUCCESS
        case FAIL
        case CANCEL
    }
    
    public func getApp() -> Int? {
        return self.app
    }
    public func setApp(_ app: Int) {
        self.app = app
    }
    public func getStatus() -> Status? {
        return self.status
    }
    public func setStatus(_ status: Status) {
        self.status = status
    }
    
    public required init(from decoder: Decoder) throws {
    }
    
    public func encode(to encoder: Encoder) throws {
    }
}
