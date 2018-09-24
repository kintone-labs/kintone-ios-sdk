//
//  CalculatedField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class CalculatedField: AbstractInputField {
    private var expression: String?
    private var hideExpression: Bool?
    private var displayScale: Int?
    private var unit: String?
    private var unitPosition: UnitPosition?
    private var format: NumberFormat?
    
    /**
     * default constructor
     */
    public override init() {
        super.init()
        self.type = FieldType.CALC
    }
    
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.CALC
    }
    
    
    public required init(from decoder: Decoder) throws {
        super.init()
    }
    
    /**
     * @return the expression
     */
    public func getExpression() -> String? {
        return self.expression
    }
    
    /**
     * @param expression
     *            the expression to set
     */
    public func setExpression(_ expression: String?) {
        self.expression = expression
    }
    
    /**
     * @return the hideExpression
     */
    public func getHideExpression() -> Bool? {
        return self.hideExpression
    }
    
    /**
     * @param hideExpression
     *            the hideExpression to set
     */
    public func setHideExpression(_ hideExpression: Bool?) {
        self.hideExpression = hideExpression
    }
    
    /**
     * @return the displayScale
     */
    public func getDisplayScale() -> Int? {
        return self.displayScale
    }
    
    /**
     * @param displayScale
     *            the displayScale to set
     */
    public func setDisplayScale(_ displayScale: Int?) {
        self.displayScale = displayScale
    }
    
    /**
     * @return the unit
     */
    public func getUnit() -> String? {
        return self.unit
    }
    
    /**
     * @param unit
     *            the unit to set
     */
    public func setUnit(_ unit: String?) {
        self.unit = unit
    }
    
    /**
     * @return the unitPosition
     */
    public func getUnitPosition() -> UnitPosition? {
        return self.unitPosition
    }
    
    /**
     * @param unitPosition
     *            the unitPosition to set
     */
    public func setUnitPosition(_ unitPosition: UnitPosition?) {
        self.unitPosition = unitPosition;
    }
    
    /**
     * @return the format
     */
    public func getFormat() -> NumberFormat? {
        return self.format;
    }
    
    /**
     * @param format
     *            the format to set
     */
    public func setFormat(_ format: NumberFormat?) {
        self.format = format;
    }
}
