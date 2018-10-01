// Copyright (c) 2018 Cybozu, Inc.

public class GetAppRequest: NSObject, Codable {
    private var id: Int?
    
    public func getId() -> Int? {
        return self.id
    }
    public func setId(id: Int) {
        self.id = id
    }
    
    public init(_ id: Int?) {
        self.id = id
    }
}
