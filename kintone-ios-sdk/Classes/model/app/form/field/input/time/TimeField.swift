//
//  TimeField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

import Foundation


public class TimeField: AbstractInputField {
    internal var defaultValue: String?
    internal var defaultNowValue: Bool?
    
    /**
     * @param code
     */
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.TIME
    }
    
    public required init(from decoder: Decoder) throws {
        super.init()
    }
    
    /**
     * @return
     */
    public func getDefaultValue() -> String? {
        return self.defaultValue
    }
    
    /**
     * @param defaultValue
     */
    public func setDefaultValue(_ defaultValue: String?) {
        self.defaultValue = defaultValue
    }
    
    /**
     * @return
     */
    public func getDefaultNowValue() -> Bool? {
        return self.defaultNowValue
    }
    
    /**
     * @param defaultNowValue
     */
    public func setDefaultNowValue(_ defaultNowValue: Bool?) {
        self.defaultNowValue = defaultNowValue
    }
}
