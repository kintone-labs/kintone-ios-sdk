//
//  CheckboxField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class CheckboxField: AbstractSelectionField {
    internal var defaultValue: [String]?
    internal var align: AlignLayout?
    
    enum CheckboxCodingKeys: CodingKey {
        case defaultValue
        case align
    }
    /**
     * default constructor
     */
    public override init() {
        super.init()
        self.type = FieldType.CHECK_BOX;
    }
    
    /**
     * @param code
     */
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.CHECK_BOX
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CheckboxCodingKeys.self)
        self.defaultValue = try container.decode([String].self, forKey: CheckboxCodingKeys.defaultValue)
        self.align = try container.decode(AlignLayout.self, forKey: CheckboxCodingKeys.align)
        try super.init(from: decoder)
    }
    /**
     * @return the align
     */
    public func getAlign() -> AlignLayout? {
        return self.align
    }
    
    /**
     * @param align
     * the align to set
     */
    public func setAlign(_ align: AlignLayout?) {
        self.align = align
    }
    
    /**
     * @return
     */
    public func getDefaultValue() -> [String]? {
        return self.defaultValue
    }
    
    /**
     * @param defaultValue
     */
    public func setDefaultValue(_ defaultValue: [String]?) {
        self.defaultValue = defaultValue
    }
}
