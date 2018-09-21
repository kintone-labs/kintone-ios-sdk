//
//  NumberField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

import Foundation


public class NumberField: AbstractInputField {
    private var displayScale: Int?
    private var unit: String?
    private var unitPosition: UnitPosition?
    private var digit: Bool?
    private var maxValue: Int?
    private var minValue: Int?
    private var defaultValue: String?
    private var unique: Bool?
    
    public init(_ code: String) {
        super.init()
        self.code = code;
        self.type = FieldType.NUMBER
    }
    
    public required init(from decoder: Decoder) throws {
        super.init()
    }
    
    public func getDisplayScale() -> Int? {
        return self.displayScale
    }
    
    public func setDisplayScale(_ displayScale: Int?) {
        self.displayScale = displayScale
    }
    
    public func getUnit() -> String? {
        return self.unit
    }
    
    public func setUnit(_ unit: String?) {
        self.unit = unit
    }
    
    public func getUnitPosition() -> UnitPosition? {
        return self.unitPosition
    }
    
    public func setUnitPosition(_ unitPosition: UnitPosition?) {
        self.unitPosition = unitPosition;
    }
    

    public func getDigit() -> Bool? {
        return self.digit
    }
    
    public func setDigit(_ digit: Bool?) {
        self.digit = digit
    }
    
    /**
     * @return the maxValue
     */
    public func getMaxValue() -> Int? {
        return self.maxValue
    }
    
    /**
     * @param maxValue the maxValue to set
     */
    public func setMaxValue(_ maxValue: Int?) {
        self.maxValue = maxValue
    }
    
    /**
     * @return the minValue
     */
    public func getMinValue() -> Int? {
        return self.minValue
    }
    
    /**
     * @param minValue the minValue to set
     */
    public func setMinValue(_ minValue: Int?) {
        self.minValue = minValue
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
    
    /**
     * @return
     */
    public func getUnique() -> Bool? {
        return self.unique
    }
    
    /**
     * @param unique
     */
    public func setUnique(_ unique: Bool?) {
        self.unique = unique
    }
}
