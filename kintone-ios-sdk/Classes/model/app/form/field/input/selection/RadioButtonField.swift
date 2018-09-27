//
//  RadioButtonField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class RadioButtonField: AbstractSelectionField {
    internal var defaultValue: String?
    internal var align: AlignLayout?
    
    enum RadioButtonCodingKeys: CodingKey {
        case defaultValue
        case align
    }
    /**
     * @param code
     */
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.RADIO_BUTTON
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RadioButtonCodingKeys.self)
        self.defaultValue = try container.decode(String.self, forKey: RadioButtonCodingKeys.defaultValue)
         self.align = try container.decode(AlignLayout.self, forKey: RadioButtonCodingKeys.align)
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: RadioButtonCodingKeys.self)
        if(self.defaultValue != nil){
            try container.encode(self.defaultValue, forKey: RadioButtonCodingKeys.defaultValue)
        }
        if(self.align != nil){
            try container.encode(self.align, forKey: RadioButtonCodingKeys.align)
        }
        try super.encode(to: encoder)
    }
    
    /**
     * @return the align
     */
    public func getAlign() -> AlignLayout? {
        return self.align
    }
    
    /**
     * @param align
     *            the align to set
     */
    public func setAlign(_ align: AlignLayout?) {
        self.align = align
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
}
