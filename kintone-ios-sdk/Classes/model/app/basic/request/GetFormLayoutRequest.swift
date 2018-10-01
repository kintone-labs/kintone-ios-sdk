// Copyright (c) 2018 Cybozu, Inc.

public class GetFormLayoutRequest: NSObject, Codable {
    private var app: Int?
    
    public func getApp() -> Int? {
        return self.app
    }
    public func setApp(_ app: Int) {
        self.app = app
    }
    
    public init(_ app: Int) {
        self.app = app
    }
}
