//
//  ItemLayout.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

import Foundation



public class ItemLayout: NSObject, Codable {
    internal var type: LayoutType?
    /**
     * @return the type
     */
    public func getType() -> LayoutType? {
        return self.type
    }
}
