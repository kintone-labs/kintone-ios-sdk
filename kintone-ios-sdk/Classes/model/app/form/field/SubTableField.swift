//
//  SubTableField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/18/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class SubTableField: Field {
    internal var fields: [String: AbstractInputField] = [String: AbstractInputField]();
   
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
        super.init()
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

