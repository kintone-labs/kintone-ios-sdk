//
//  App.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

class AppModel: NSObject {
    private var appId: Int?
    private var code: String?
    private var name: String?
    private var appDescription: String?
    private var spaceId: Int?
    private var threadId: Int?
    private var createdAt: Date?
    private var creator: UserBase?
    private var updatedAt: Date?
    private var modifier: UserBase?
    
    public func getAppId() -> Int? {
        return self.appId
    }
    public func setAppId(_ appId: Int) {
        self.appId = appId
    }
    public func getCode() -> String? {
        return self.code
    }
    public func setCode(_ code: String) {
        self.code = code
    }
    public func getName() -> String? {
        return self.name
    }
    public func setName(_ name: String) {
        self.name = name
    }
}
