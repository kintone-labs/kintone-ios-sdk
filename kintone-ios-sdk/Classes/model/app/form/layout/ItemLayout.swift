// Copyright (c) 2018 Cybozu, Inc.

open class ItemLayout: NSObject, Codable {
    open var type: LayoutType?
  
    open func getType() -> LayoutType? {
        return self.type
    }
}
