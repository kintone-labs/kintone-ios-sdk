// Copyright (c) 2018 Cybozu, Inc.

open class AppModel: NSObject, Codable {
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
    
    open func getAppId() -> Int? {
        return Int(self.appId != nil ? self.appId! : "")
    }
    open func setAppId(_ appId: Int?) {
        self.appId = spaceId != nil ? "\(String(describing: appId!))" : nil
    }
    open func getCode() -> String? {
        return self.code
    }
    open func setCode(_ code: String?) {
        self.code = code
    }
    open func getName() -> String? {
        return self.name
    }
    open func setName(_ name: String?) {
        self.name = name
    }
    open func getDescription() -> String? {
        return self.appDescription
    }
    open func setDescription(_ appDescription: String?) {
        return self.appDescription = appDescription
    }
    open func getSpaceId() -> Int? {
        return Int(self.spaceId != nil ? self.spaceId! : "")
    }
    open func setSpaceId(_ spaceId: Int?) {
        self.spaceId = spaceId != nil ? "\(String(describing: spaceId!))" : nil
    }
    open func getThreadId() -> Int? {
        return Int(self.threadId != nil ? self.threadId! : "")
    }
    open func setThreadId(_ threadId: Int?) {
        self.threadId = threadId != nil ? "\(String(describing: threadId!))" : nil
    }
    open func getCreadtedAt() -> String? {
        return self.createdAt
    }
    open func setCreatedAt(_ createdAt: String?) {
        self.createdAt = createdAt
    }
    open func getCreator() -> Member? {
        return self.creator
    }
    open func setCreator(_ creator: Member?) {
        self.creator = creator
    }
    open func getModifiedAt() -> String? {
        return self.modifiedAt
    }
    open func setModifiedAt(_ modifiedAt: String?) {
        self.modifiedAt = modifiedAt
    }
    open func getModifier() -> Member? {
        return self.modifier
    }
    open func setModifier(_ modifier: Member?) {
        self.modifier = modifier
    }
}
