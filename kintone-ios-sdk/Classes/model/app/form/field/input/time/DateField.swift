//
//  DateField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class DateField: AbstractInputField {
    internal var unique: Bool?
    internal var defaultValue: String?
    internal var defaultNowValue: Bool?
    
    /**
     * @param code
     */
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.DATE
    }
    
    public required init(from decoder: Decoder) throws {
        super.init()
    }
    
    /**
     * @return the unique
     */
    public func getUnique() -> Bool? {
        return unique;
    }
    
    /**
     * @param unique the unique to set
     */
    public func setUnique(_ unique: Bool?) {
        self.unique = unique
    }
    
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
