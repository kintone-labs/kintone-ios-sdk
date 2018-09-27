//
//  DropDownField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class DropDownField: AbstractSelectionField {
    internal var defaultValue: String?
    
    enum DropDownCodingKeys: CodingKey {
        case defaultValue
    }
    /**
     * @param code
     */
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.DROP_DOWN
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DropDownCodingKeys.self)
        self.defaultValue = try container.decode(String.self, forKey: DropDownCodingKeys.defaultValue)
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DropDownCodingKeys.self)
        if(self.defaultValue != nil){
            try container.encode(self.defaultValue, forKey: DropDownCodingKeys.defaultValue)
        }
        try super.encode(to: encoder)
    }
    
    /**
     * @return the defaultValue
     */
    public func getDefaultValue() -> String? {
        return self.defaultValue
    }
    
    /**
     * @param defaultValue
     *            the defaultValue to set
     */
    public func setDefaultValue(_ defaultValue: String?) {
        self.defaultValue = defaultValue
    }
}
