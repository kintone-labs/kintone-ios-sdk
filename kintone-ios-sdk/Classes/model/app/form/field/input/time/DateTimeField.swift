// Copyright (c) 2018 Cybozu, Inc.

public class DateTimeField: AbstractInputField {
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
    
    override public func encode(to encoder: Encoder) throws {
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
   
    public func getUnique() -> Bool? {
        return unique;
    }
  
    public func setUnique(_ unique: Bool?) {
        self.unique = unique
    }
    
    public func getDefaultValue() -> String? {
        return self.defaultValue
    }
   
    public func setDefaultValue(_ defaultValue: String?) {
        self.defaultValue = defaultValue
    }
   
    public func getDefaultNowValue() -> Bool? {
        return self.defaultNowValue
    }
   
    public func setDefaultNowValue(_ defaultNowValue: Bool?) {
        self.defaultNowValue = defaultNowValue
    }
}
