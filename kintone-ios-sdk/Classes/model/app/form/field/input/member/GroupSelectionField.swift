//
//  GroupSelectionField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class GroupSelectionField: AbstractMemberSelectField {
    /**
     * default constructor
     */
    public override init() {
        super.init()
        self.type = FieldType.GROUP_SELECT
    }
    
    /**
     * @param code
     */
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.GROUP_SELECT
    }
    
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}
