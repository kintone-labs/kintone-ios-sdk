//
//  SingleLineTextField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class SingleLineTextField: AbstractInputField {
    private var expression: String?
    private var hideExpression: Bool?
    private var minLength: String?
    private var maxLength: String?
    private var defaultValue: String?
    private var unique: Bool?
    
    enum SingleLineTextCodingKeys: CodingKey {
        case expression
        case hideExpression
        case minLength
        case maxLength
        case defaultValue
        case unique
    }
    
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.SINGLE_LINE_TEXT
    }
    
    public func getMinLength() -> String? {
        return self.minLength
    }
    
    public func setMinLength(_ minLength: String?) {
        self.minLength = minLength
    }
    
    public func getMaxLength() -> String? {
        return self.maxLength
    }
    
    public func setMaxLength(_ maxLength: String?) {
        self.maxLength = maxLength;
    }
    
    public func getExpression() -> String? {
        return self.expression
    }
    
    public func setExpression(_ expression: String?) {
        self.expression = expression
    }
  
    public func getHideExpression() -> Bool? {
        return self.hideExpression
    }
    
    public func setHideExpression(_ hideExpression: Bool?) {
        self.hideExpression = hideExpression
    }
    
    public func getDefaultValue() -> String? {
        return self.defaultValue
    }
    
    public func setDefaultValue(_ defaultValue: String?) {
        self.defaultValue = defaultValue
    }
  
    public func getUnique() -> Bool? {
        return self.unique
    }
    
    public func setUnique(_ isUnique: Bool?) {
        self.unique = isUnique
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SingleLineTextCodingKeys.self)
        self.expression = try container.decode(String.self, forKey: SingleLineTextCodingKeys.expression)
        self.hideExpression = try container.decode(Bool.self, forKey: SingleLineTextCodingKeys.hideExpression)
        self.minLength = try container.decode(String.self, forKey: SingleLineTextCodingKeys.minLength)
        self.maxLength = try container.decode(String.self, forKey: SingleLineTextCodingKeys.maxLength)
        self.defaultValue = try container.decode(String.self, forKey: SingleLineTextCodingKeys.defaultValue)
        self.unique = try container.decode(Bool.self, forKey: SingleLineTextCodingKeys.unique)
        try super.init(from: decoder)
    }
}
