//
//  App.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

class AppModel: NSObject, Codable {
    private var appId: String?
    private var code: String?
    private var name: String?
    private var appDescription: String?
    private var spaceId: String?
    private var threadId: String?
    private var createdAt: String?
    private var creator: Member?
    private var modifiedAt: String?
    private var modifier: Member?
    
    enum CodingKeys:String,CodingKey
    {
        //It will replace the respective properties name by assigned string
        //while encoding to Json or pList format.
        //Also, while decoding respective Json or pList, these new names are
        //expected in data rather that that defined in class declaration
        
        //will get renamed
        case appDescription = "description"
        case appId
        case code
        case name
        case spaceId
        case threadId
        case createdAt
        case creator
        case modifiedAt
        case modifier
    }
    
    public func getAppId() -> String? {
        return self.appId
    }
    public func setAppId(_ appId: String) {
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
    public func getSpaceId() -> String? {
        return self.spaceId
    }
    public func setSpaceId(_ spaceId: String) {
        self.spaceId = spaceId
    }
    public func getThreadId() -> String? {
        return self.threadId
    }
    public func setThreadId(_ threadId: String) {
        self.threadId = threadId
    }
    public func getCreadtedAt() -> String? {
        return self.createdAt
    }
    public func setCreatedAt(_ createdAt: String) {
        self.createdAt = createdAt
    }
    public func getCreator() -> Member? {
        return self.creator
    }
    public func setCreator(_ creator: Member) {
        self.creator = creator
    }
    public func getModifiedAt() -> String? {
        return self.modifiedAt
    }
    public func setModifiedAt(_ modifiedAt: String) {
        self.modifiedAt = modifiedAt
    }
    public func getModifier() -> Member? {
        return self.modifier
    }
    public func setModifier(_ modifier: Member) {
        self.modifier = modifier
    }
}
