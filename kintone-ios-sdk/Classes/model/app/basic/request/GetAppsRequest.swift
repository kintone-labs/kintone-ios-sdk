// Copyright (c) 2018 Cybozu, Inc.

open class GetAppsRequest: NSObject, Codable {
    private var ids: [Int]?
    private var codes: [String]?
    private var name: String?
    private var spaceIds: [Int]?
    private var offset: Int?
    private var limit: Int?
    
    open func getIds() -> [Int]? {
        return self.ids
    }
    open func setId(_ ids: [Int]) {
        self.ids = ids
    }
    open func getCodes() -> [String]? {
        return self.codes
    }
    open func setCodes(_ codes: [String]) {
        self.codes = codes
    }
    open func getName() -> String? {
        return self.name
    }
    open func setName(_ name: String) {
        self.name = name
    }
    open func getSpaceIds() -> [Int]? {
        return self.spaceIds
    }
    open func setSpaceIds(_ spaceIds: [Int]) {
        self.spaceIds = spaceIds
    }
    open func getOffset() -> Int? {
        return self.offset
    }
    open func setOffset(_ offset: Int) {
        self.offset = offset
    }
    open func getLimit() -> Int? {
        return self.limit
    }
    open func setLimit(_ limit: Int) {
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
