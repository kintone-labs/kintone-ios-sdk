// Copyright (c) 2018 Cybozu, Inc.

open class DateTimeField: AbstractInputField {
    internal var unique: Bool?
    internal var defaultValue: String?
    internal var defaultNowValue: Bool?
    
    enum DateTimeCodingKeys: CodingKey {
        case unique
        case defaultValue
        case defaultNowValue
    }
   
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.DATETIME
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DateTimeCodingKeys.self)
        self.defaultValue = try container.decode(String.self, forKey: DateTimeCodingKeys.defaultValue)
        self.defaultNowValue = try container.decode(Bool.self, forKey: DateTimeCodingKeys.defaultNowValue)
        self.unique = try container.decode(Bool.self, forKey: DateTimeCodingKeys.unique)
        try super.init(from: decoder)
    }
    
    override open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DateTimeCodingKeys.self)
        if(self.defaultValue != nil){
            try container.encode(self.defaultValue, forKey: DateTimeCodingKeys.defaultValue)
        }
        if(self.defaultNowValue != nil){
            try container.encode(self.defaultNowValue, forKey: DateTimeCodingKeys.defaultNowValue)
        }
        if(self.unique != nil){
            try container.encode(self.unique, forKey: DateTimeCodingKeys.unique)
        }
        try super.encode(to: encoder)
    }
   
    open func getUnique() -> Bool? {
        return unique;
    }
  
    open func setUnique(_ unique: Bool?) {
        self.unique = unique
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
