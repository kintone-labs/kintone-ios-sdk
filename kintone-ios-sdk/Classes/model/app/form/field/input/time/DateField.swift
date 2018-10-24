// Copyright (c) 2018 Cybozu, Inc.

public class DateField: AbstractInputField {
    internal var unique: Bool?
    internal var defaultValue: String?
    internal var defaultNowValue: Bool?
    
    enum DateCodingKeys: CodingKey {
        case unique
        case defaultValue
        case defaultNowValue
    }
   
    public override init() {
        super.init()
    }
    
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.DATE
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DateCodingKeys.self)
        self.defaultValue = try container.decode(String.self, forKey: DateCodingKeys.defaultValue)
        self.defaultNowValue = try container.decode(Bool.self, forKey: DateCodingKeys.defaultNowValue)
        self.unique = try container.decode(Bool.self, forKey: DateCodingKeys.unique)
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DateCodingKeys.self)
        if(self.defaultValue != nil){
            try container.encode(self.defaultValue, forKey: DateCodingKeys.defaultValue)
        }
        if(self.defaultNowValue != nil){
            try container.encode(self.defaultNowValue, forKey: DateCodingKeys.defaultNowValue)
        }
        if(self.unique != nil){
            try container.encode(self.unique, forKey: DateCodingKeys.unique)
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
