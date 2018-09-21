//
//  CategoryField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

import Foundation


public class CategoryField: AbstractSystemField {
    internal var enabled: Bool?
    
    /**
     * @param code
     */
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.CATEGORY
    }
    
    public required init(from decoder: Decoder) throws {
        super.init()
    }
    
    /**
     * @return
     */
    public func getEnabled() -> Bool? {
        return self.enabled;
    }
    
    /**
     * @param enabled
     */
    public func setEnabled(_ enabled: Bool?) {
        self.enabled = enabled
    }
}
