// Copyright (c) 2018 Cybozu, Inc.

public class MultipleSelectField: AbstractSelectionField {
    internal var defaultValue: [String]?
    
    
    enum MultipleSelectCodingKeys: CodingKey {
        case defaultValue
    }
   
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.MULTI_SELECT
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MultipleSelectCodingKeys.self)
        self.defaultValue = try container.decode([String].self, forKey: MultipleSelectCodingKeys.defaultValue)
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: MultipleSelectCodingKeys.self)
        if(self.defaultValue!.count > 0){
            try container.encode(self.defaultValue, forKey: MultipleSelectCodingKeys.defaultValue)
        }
        try super.encode(to: encoder)
    }
    
    public func getDefaultValue() -> [String]? {
        return self.defaultValue
    }
    
    public func setDefaultValue(_ defaultValue: [String]?) {
        self.defaultValue = defaultValue
    }
}
