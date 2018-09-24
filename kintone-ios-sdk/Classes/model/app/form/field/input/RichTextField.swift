//
//  RichTextField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class RichTextField: AbstractInputField {
    private var defaultValue: String?
    
    /**
     * @param code
     */
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.RICH_TEXT
    }
    
    
    public required init(from decoder: Decoder) throws {
        super.init()
    }
    
    /**
     * @return the defaultValue
     */
    public func getDefaultValue() -> String? {
        return self.defaultValue
    }
    
    /**
     * @param defaultValue the defaultValue to set
     */
    public func setDefaultValue(_ defaultValue: String?) {
        self.defaultValue = defaultValue
    }
}
