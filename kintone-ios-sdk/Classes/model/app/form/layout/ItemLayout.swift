//
//  ItemLayout.swift
//  kintone-ios-sdk
//

public class ItemLayout: NSObject, Codable {
    internal var type: LayoutType?
  
    public func getType() -> LayoutType? {
        return self.type
    }
}
