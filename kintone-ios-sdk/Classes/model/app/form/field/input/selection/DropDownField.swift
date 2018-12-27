// Copyright (c) 2018 Cybozu, Inc.

open class DropDownField: AbstractSelectionField {
    internal var defaultValue: String?
    
    enum DropDownCodingKeys: CodingKey {
        case defaultValue
    }
    
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.DROP_DOWN
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DropDownCodingKeys.self)
        self.defaultValue = try container.decode(String.self, forKey: DropDownCodingKeys.defaultValue)
        try super.init(from: decoder)
    }
    
    override open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DropDownCodingKeys.self)
        if(self.defaultValue != nil){
            try container.encode(self.defaultValue, forKey: DropDownCodingKeys.defaultValue)
        }
        try super.encode(to: encoder)
    }
    
    open func getDefaultValue() -> String? {
        return self.defaultValue
    }
    
    open func setDefaultValue(_ defaultValue: String?) {
        self.defaultValue = defaultValue
    }
}
