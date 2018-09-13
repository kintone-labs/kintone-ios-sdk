//
//  SubTableValueItem.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/10.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

import UIKit

class SubTableValueItem: NSObject, Codable {
    private var id: Int?
    private var value: [String:FieldValue]?
    
    public func getID() -> Int? {
        return self.id
    }
    public func setID(_ id: Int) {
        self.id = id
    }
    public func getValue() -> [String:FieldValue]? {
        return self.value
    }
    func setValue(_ value: [String:FieldValue]) {
        self.value = value
    }

}
