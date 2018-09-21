//
//  RadioButtonField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

import Foundation


public class RadioButtonField: AbstractSelectionField {
    internal var defaultValue: String?
    internal var align: AlignLayout?
    
    /**
     * @param code
     */
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.RADIO_BUTTON
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