//
//  SingleLineTextField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

import UIKit

public class SingleLineTextField: AbstractInputField {
    private var expression: String?
    private var hideExpression: Bool?
    private var minLength: Int?
    private var maxLength: Int?
    private var defaultValue: String?
    private var unique: Bool?
    

    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.SINGLE_LINE_TEXT
    }
    
    public required init(from decoder: Decoder) throws {
        super.init()
    }
    
    public func getMinLength() -> Int? {
        return self.minLength
    }
    
    public func setMinLength(_ minLength: Int?) {
        self.minLength = minLength
    }
    
    public func getMaxLength() -> Int? {
        return self.maxLength
    }
    
    public func setMaxLength(_ maxLength: Int?) {
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
}
