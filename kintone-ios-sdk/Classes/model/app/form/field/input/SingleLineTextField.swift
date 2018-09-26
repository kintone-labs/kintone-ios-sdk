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
    
    enum CodingKeys: CodingKey {
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
    
    required public init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.setDefaultValue(try container.decodeIfPresent(String.self, forKey: .defaultValue))
    }
}
