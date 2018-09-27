//
//  RichTextField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class RichTextField: AbstractInputField {
    private var defaultValue: String?
    
    enum RichTextCodingKeys: CodingKey {
        case defaultValue
    }
    
    /**
     * @param code
     */
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.RICH_TEXT
    }
    
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RichTextCodingKeys.self)
        self.defaultValue = try container.decode(String.self, forKey: RichTextCodingKeys.defaultValue)
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
