// Copyright (c) 2018 Cybozu, Inc.

open class GetFormLayoutRequest: NSObject, Codable {
    private var app: Int?
    
    open func getApp() -> Int? {
        return self.app
    }
    open func setApp(_ app: Int) {
        self.app = app
    }
    
    public init(_ app: Int) {
        self.app = app
    }
}
