// Copyright (c) 2018 Cybozu, Inc.

public class GetAppsRequest: NSObject, Codable {
    private var ids: [Int]?
    private var codes: [String]?
    private var name: String?
    private var spaceIds: [Int]?
    private var offset: Int?
    private var limit: Int?
    
    public func getIds() -> [Int]? {
        return self.ids
    }
    public func setId(_ ids: [Int]) {
        self.ids = ids
    }
    public func getCodes() -> [String]? {
        return self.codes
    }
    public func setCodes(_ codes: [String]) {
        self.codes = codes
    }
    public func getName() -> String? {
        return self.name
    }
    public func setName(_ name: String) {
        self.name = name
    }
    public func getSpaceIds() -> [Int]? {
        return self.spaceIds
    }
    public func setSpaceIds(_ spaceIds: [Int]) {
        self.spaceIds = spaceIds
    }
    public func getOffset() -> Int? {
        return self.offset
    }
    public func setOffset(_ offset: Int) {
        self.offset = offset
    }
    public func getLimit() -> Int? {
        return self.limit
    }
    public func setLimit(_ limit: Int) {
        self.limit = limit
    }
    
    public init(ids idsOpt: [Int]? = nil, codes codesOpt: [String]? = nil, name nameOpt: String? = "", spaceIds spaceIdsOpt: [Int]? = nil, offset offsetOpt: Int? = 0, limit limitOpt: Int? = 100) {
        self.ids = idsOpt
        self.codes = codesOpt
        self.name = nameOpt
        self.spaceIds = spaceIdsOpt
        self.offset = offsetOpt
        self.limit = limitOpt
    }
}
