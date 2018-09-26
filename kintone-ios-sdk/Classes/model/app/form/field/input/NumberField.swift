//
//  NumberField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class NumberField: AbstractInputField {
    private var displayScale: String?
    private var unit: String?
    private var unitPosition: UnitPosition?
    private var digit: Bool?
    private var maxValue: String?
    private var minValue: String?
    private var defaultValue: String?
    private var unique: Bool?
    
    enum NumberCodingKeys: CodingKey {
        case displayScale
        case unit
        case unitPosition
        case digit
        case maxValue
        case minValue
        case defaultValue
        case unique
    }
    
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.NUMBER
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: NumberCodingKeys.self)
        self.displayScale = try container.decode(String.self, forKey: NumberCodingKeys.displayScale)
        self.unit = try container.decode(String.self, forKey: NumberCodingKeys.unit)
        self.unitPosition = try container.decode(UnitPosition.self, forKey: NumberCodingKeys.unitPosition)
        self.digit = try container.decode(Bool.self, forKey: NumberCodingKeys.digit)
        self.maxValue = try container.decode(String.self, forKey: NumberCodingKeys.maxValue)
        self.minValue = try container.decode(String.self, forKey: NumberCodingKeys.minValue)
        self.defaultValue = try container.decode(String.self, forKey: NumberCodingKeys.defaultValue)
        self.unique = try container.decode(Bool.self, forKey: NumberCodingKeys.unique)
        try super.init(from: decoder)
    }
    
    public func getDisplayScale() -> Int? {
        return Int(self.displayScale!)
    }
    
    public func setDisplayScale(_ displayScale: String?) {
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
        return Int(self.maxValue!)
    }
    
    /**
     * @param maxValue the maxValue to set
     */
    public func setMaxValue(_ maxValue: String?) {
        self.maxValue = maxValue
    }
    
    /**
     * @return the minValue
     */
    public func getMinValue() -> Int? {
        return Int(self.minValue!)
    }
    
    /**
     * @param minValue the minValue to set
     */
    public func setMinValue(_ minValue: String?) {
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
