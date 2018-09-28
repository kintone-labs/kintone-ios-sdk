// Copyright (c) 2018 Cybozu, Inc.

public class AppModel: NSObject, Codable {
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
    
    public func getAppId() -> Int? {
        return Int(self.appId!)
    }
    public func setAppId(_ appId: Int?) {
        self.appId = "\(String(describing: appId))"
    }
    public func getCode() -> String? {
        return self.code
    }
    public func setCode(_ code: String?) {
        self.code = code
    }
    public func getName() -> String? {
        return self.name
    }
    public func setName(_ name: String?) {
        self.name = name
    }
    public func getDescription() -> String? {
        return self.appDescription
    }
    public func setDescription(_ appDescription: String?) {
        return self.appDescription = appDescription
    }
    public func getSpaceId() -> Int? {
        return Int(self.spaceId!)
    }
    public func setSpaceId(_ spaceId: Int?) {
        self.spaceId = "\(String(describing: spaceId))"
    }
    public func getThreadId() -> Int? {
        return Int(self.threadId!)
    }
    public func setThreadId(_ threadId: String?) {
        self.threadId = "\(String(describing: threadId))"
    }
    public func getCreadtedAt() -> String? {
        return self.createdAt
    }
    public func setCreatedAt(_ createdAt: String?) {
        self.createdAt = createdAt
    }
    public func getCreator() -> Member? {
        return self.creator
    }
    public func setCreator(_ creator: Member?) {
        self.creator = creator
    }
    public func getModifiedAt() -> String? {
        return self.modifiedAt
    }
    public func setModifiedAt(_ modifiedAt: String?) {
        self.modifiedAt = modifiedAt
    }
    public func getModifier() -> Member? {
        return self.modifier
    }
    public func setModifier(_ modifier: Member?) {
        self.modifier = modifier
    }
}
