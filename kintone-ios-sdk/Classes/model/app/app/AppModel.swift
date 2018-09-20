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
    public func getDescription() -> String? {
        return self.appDescription
    }
    public func setDescription(_ appDescription: String ) {
        return self.appDescription = appDescription
    }
    public func getSpaceId() -> Int? {
        return self.spaceId
    }
    public func setSpaceId(_ spaceId: Int) {
        self.spaceId = spaceId
    }
    public func getThreadId() -> Int? {
        return self.threadId
    }
    public func setThreadId(_ threadId: Int) {
        self.threadId = threadId
    }
    public func getCreadtedAt() -> Date? {
        return self.createdAt
    }
    public func setCreatedAt(_ createdAt: Date) {
        self.createdAt = createdAt
    }
    public func getCreator() -> UserBase? {
        return self.creator
    }
    public func setCreator(_ creator: UserBase) {
        self.creator = creator
    }
    public func getUpdatedAt() -> Date? {
        return self.updatedAt
    }
    public func setUpdatedAt(_ updatedAt: Date) {
        self.updatedAt = updatedAt
    }
    public func getModifier() -> UserBase? {
        return self.modifier
    }
    public func setModifier(_ modifier: UserBase) {
        self.modifier = modifier
    }
}
