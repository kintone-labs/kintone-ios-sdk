// Copyright (c) 2018 Cybozu, Inc.

open class GetAppRequest: NSObject, Codable {
    private var id: Int
    
    open func getId() -> Int {
        return self.id
    }
    open func setId(id: Int) {
        self.id = id
    }
    
    public init(_ id: Int) {
        self.id = id
    }
}
