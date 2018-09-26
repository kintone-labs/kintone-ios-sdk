//
//  RecordNumberField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class RecordNumberField: AbstractSystemInfoField {
    /**
     * @param code
     */
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.RECORD_NUMBER
    }
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
}
