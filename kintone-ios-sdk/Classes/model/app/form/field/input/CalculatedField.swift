// Copyright (c) 2018 Cybozu, Inc.

public class CalculatedField: AbstractInputField {
    private var expression: String?
    private var hideExpression: Bool?
    private var displayScale: String?
    private var unit: String?
    private var unitPosition: UnitPosition?
    private var format: NumberFormat?
    
    enum CalculatedFieldCodingKeys: CodingKey {
        case expression
        case hideExpression
        case displayScale
        case unit
        case unitPosition
        case format
    }
   
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
        let container = try decoder.container(keyedBy: CalculatedFieldCodingKeys.self)
        self.expression = try container.decode(String.self, forKey: CalculatedFieldCodingKeys.expression)
        self.hideExpression = try container.decode(Bool.self, forKey: CalculatedFieldCodingKeys.hideExpression)
        self.displayScale = try container.decode(String.self, forKey: CalculatedFieldCodingKeys.displayScale)
        self.format = try container.decode(NumberFormat.self, forKey: CalculatedFieldCodingKeys.format)
        self.unitPosition = try container.decode(UnitPosition.self, forKey: CalculatedFieldCodingKeys.unitPosition)
        self.unit = try container.decode(String.self, forKey: CalculatedFieldCodingKeys.unit)
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CalculatedFieldCodingKeys.self)
        if(self.displayScale != nil){
            try container.encode(self.displayScale, forKey: CalculatedFieldCodingKeys.displayScale)
        }
        if(self.unit != nil){
            try container.encode(self.unit, forKey: CalculatedFieldCodingKeys.unit)
        }
        if(self.unitPosition != nil){
            try container.encode(self.unitPosition, forKey: CalculatedFieldCodingKeys.unitPosition)
        }
        if(self.expression != nil){
            try container.encode(self.expression, forKey: CalculatedFieldCodingKeys.expression)
        }
        if(self.format != nil){
            try container.encode(self.format, forKey: CalculatedFieldCodingKeys.format)
        }
        if(self.hideExpression != nil){
            try container.encode(self.hideExpression, forKey: CalculatedFieldCodingKeys.hideExpression)
        }
        try super.encode(to: encoder)
    }
    
    public func getExpression() -> String? {
        return self.expression
    }
   
    public func setExpression(_ expression: String?) {
        self.expression = expression
    }
  
    public func getHideExpression() -> Bool? {
        return self.hideExpression
    }
   
    public func setHideExpression(_ hideExpression: Bool?) {
        self.hideExpression = hideExpression
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
  
    public func getFormat() -> NumberFormat? {
        return self.format;
    }
    
    public func setFormat(_ format: NumberFormat?) {
        self.format = format;
    }
}
