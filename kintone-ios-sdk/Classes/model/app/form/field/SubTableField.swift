//
//  SubTableField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/18/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class SubTableField: Field {
    internal var fields: [String: AbstractInputField] = [String: AbstractInputField]();
   
    enum SubTableFieldCodingKeys: CodingKey {
        case fields
    }
    
    struct DynamicKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        init?(intValue: Int) {
            self.intValue = intValue
            stringValue = "\(intValue)"
        }
        static func key(named name: String) -> DynamicKeys? {
            return DynamicKeys(stringValue: name)
        }
    }
    
    public override init() {
        super.init()
        self.type = FieldType.SUBTABLE;
    }
    
    public init(_ code: String?) {
        super.init()
        self.code = code!;
        self.type = FieldType.SUBTABLE;
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SubTableFieldCodingKeys.self)
         var properties = [String: AbstractInputField]()
        let fields = try container.decode([String: AbstractInputField].self, forKey: SubTableFieldCodingKeys.fields)
        let nestedContainer = try container.nestedContainer(keyedBy: DynamicKeys.self, forKey: SubTableFieldCodingKeys.fields)
        for (key, field) in fields {
            switch field.getType()! {
            case .SINGLE_LINE_TEXT:
                let dynamicKey = DynamicKeys.key(named: key)
                let singleLine = try nestedContainer.decodeIfPresent(SingleLineTextField.self, forKey: dynamicKey!)
                properties[key] = singleLine
                break
            default:
                break
            }
        }
        self.fields = properties
        try super.init(from: decoder)
    }
    
    public func getFields() -> [String: AbstractInputField] {
        return self.fields;
    }
    
    public func setFields(_ fields: [String: AbstractInputField]) {
        self.fields = fields;
    }
    
    public func addField(_ field: AbstractInputField?) {
        if (field == nil || field!.getCode() == "" || field!.getCode().count == 0) {
            return;
        }
        fields[field!.getCode()] = field!;
    }
    
    public func removeField(_ field: AbstractInputField?) {
        if (field == nil || field!.getCode() == "" || field!.getCode().count == 0) {
            return;
        }
        fields[field!.getCode()] = nil;
    }
}

