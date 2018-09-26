//
//  TimeField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class TimeField: AbstractInputField {
    internal var defaultValue: String?
    internal var defaultNowValue: Bool?
    
    enum TimeCodingKeys: CodingKey {
        case defaultValue
        case defaultNowValue
    }
    /**
     * @param code
     */
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.TIME
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TimeCodingKeys.self)
        self.defaultValue = try container.decode(String.self, forKey: TimeCodingKeys.defaultValue)
        self.defaultNowValue = try container.decode(Bool.self, forKey: TimeCodingKeys.defaultNowValue)
        try super.init(from: decoder)
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
