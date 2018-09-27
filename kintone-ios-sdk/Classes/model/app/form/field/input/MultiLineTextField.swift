//
//  MultiLineTextField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class MultiLineTextField: AbstractInputField {
    private var defaultValue: String?
    
    enum MultiLineTextCodingKeys: CodingKey {
        case defaultValue
    }
    /**
     * @param code
     */
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.MULTI_LINE_TEXT
    }
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MultiLineTextCodingKeys.self)
        self.defaultValue = try container.decode(String.self, forKey: MultiLineTextCodingKeys.defaultValue)
        try super.init(from: decoder)
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
