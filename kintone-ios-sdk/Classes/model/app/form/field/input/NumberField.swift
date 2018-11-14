// Copyright (c) 2018 Cybozu, Inc.

open class NumberField: AbstractInputField {
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
    
    override open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: NumberCodingKeys.self)
        if(self.displayScale != nil){
            try container.encode(self.displayScale, forKey: NumberCodingKeys.displayScale)
        }
        if(self.unit != nil){
            try container.encode(self.unit, forKey: NumberCodingKeys.unit)
        }
        if(self.unitPosition != nil){
            try container.encode(self.unitPosition, forKey: NumberCodingKeys.unitPosition)
        }
        if(self.digit != nil){
            try container.encode(self.digit, forKey: NumberCodingKeys.digit)
        }
        if(self.maxValue != nil){
            try container.encode(self.maxValue, forKey: NumberCodingKeys.maxValue)
        }
        if(self.minValue != nil){
            try container.encode(self.minValue, forKey: NumberCodingKeys.minValue)
        }
        if(self.unique != nil){
            try container.encode(self.unique, forKey: NumberCodingKeys.unique)
        }
        if(self.defaultValue != nil){
            try container.encode(self.defaultValue, forKey: NumberCodingKeys.defaultValue)
        }
        try super.encode(to: encoder)
    }
    
    open func getDisplayScale() -> Int? {
        return Int(self.displayScale != nil ? self.displayScale! : "")
    }
    
    open func setDisplayScale(_ displayScale: String?) {
        self.displayScale = displayScale
    }
    
    open func getUnit() -> String? {
        return self.unit
    }
    
    open func setUnit(_ unit: String?) {
        self.unit = unit
    }
    
    open func getUnitPosition() -> UnitPosition? {
        return self.unitPosition
    }
    
    open func setUnitPosition(_ unitPosition: UnitPosition?) {
        self.unitPosition = unitPosition;
    }
    

    open func getDigit() -> Bool? {
        return self.digit
    }
    
    open func setDigit(_ digit: Bool?) {
        self.digit = digit
    }
    
    open func getMaxValue() -> Int? {
        return Int(self.maxValue != nil ? self.maxValue! : "")
    }
    
    open func setMaxValue(_ maxValue: String?) {
        self.maxValue = maxValue
    }
   
    open func getMinValue() -> Int? {
        return Int(self.minValue != nil ? self.minValue! : "")
    }
    
    open func setMinValue(_ minValue: String?) {
        self.minValue = minValue
    }
    
    open func getDefaultValue() -> String? {
        return self.defaultValue
    }
    
    open func setDefaultValue(_ defaultValue: String?) {
        self.defaultValue = defaultValue
    }
    
    open func getUnique() -> Bool? {
        return self.unique
    }
    
    open func setUnique(_ unique: Bool?) {
        self.unique = unique
    }
}
