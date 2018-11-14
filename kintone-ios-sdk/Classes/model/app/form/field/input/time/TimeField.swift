// Copyright (c) 2018 Cybozu, Inc.

open class TimeField: AbstractInputField {
    internal var defaultValue: String?
    internal var defaultNowValue: Bool?
    
    enum TimeCodingKeys: CodingKey {
        case defaultValue
        case defaultNowValue
    }
    
    public override init() {
        super.init()
    }
    
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.TIME
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TimeCodingKeys.self)
        self.defaultValue = try container.decode(String.self, forKey: TimeCodingKeys.defaultValue)
        self.defaultNowValue = try container.decode(Bool.self, forKey: TimeCodingKeys.defaultNowValue)
        try super.init(from: decoder)
    }
    
    override open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: TimeCodingKeys.self)
        if(self.defaultValue != nil){
            try container.encode(self.defaultValue, forKey: TimeCodingKeys.defaultValue)
        }
        if(self.defaultNowValue != nil){
            try container.encode(self.defaultNowValue, forKey: TimeCodingKeys.defaultNowValue)
        }
        try super.encode(to: encoder)
    }
    
    open func getDefaultValue() -> String? {
        return self.defaultValue
    }
    
    open func setDefaultValue(_ defaultValue: String?) {
        self.defaultValue = defaultValue
    }
    
    open func getDefaultNowValue() -> Bool? {
        return self.defaultNowValue
    }
    
    open func setDefaultNowValue(_ defaultNowValue: Bool?) {
        self.defaultNowValue = defaultNowValue
    }
}
