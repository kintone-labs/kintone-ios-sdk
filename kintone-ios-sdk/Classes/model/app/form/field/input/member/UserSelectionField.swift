//
//  UserSelectionField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

import Foundation

public class UserSelectionField: AbstractMemberSelectField {
    /**
     * @param code
     */
    public init (_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.USER_SELECT
    }
}
