// Copyright (c) 2018 Cybozu, Inc.

public class ItemLayout: NSObject, Codable {
    internal var type: LayoutType?
  
    public func getType() -> LayoutType? {
        return self.type
    }
}
