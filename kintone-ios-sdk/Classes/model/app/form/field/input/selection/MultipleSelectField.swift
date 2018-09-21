//
//  MultipleSelectField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

import Foundation


public class MultipleSelectField: AbstractSelectionField {
    internal var defaultValue: [String]?
    
    /**
     * @param code
     */
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.MULTI_SELECT
    }
    
    public required init(from decoder: Decoder) throws {
        super.init()
    }
    
    /**
     * @return the defaultValue
     */
    public func getDefaultValue() -> [String]? {
        return self.defaultValue
    }
    
    /**
     * @param defaultValue
     *            the defaultValue to set
     */
    public func setDefaultValue(_ defaultValue: [String]?) {
        self.defaultValue = defaultValue
    }
}
