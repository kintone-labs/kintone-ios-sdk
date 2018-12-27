// Copyright (c) 2018 Cybozu, Inc.

open class MultiLineTextField: AbstractInputField {
    private var defaultValue: String?
    
    enum MultiLineTextCodingKeys: CodingKey {
        case defaultValue
    }
  
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.MULTI_LINE_TEXT
    }
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MultiLineTextCodingKeys.self)
        self.defaultValue = try container.decode(String.self, forKey: MultiLineTextCodingKeys.defaultValue)
        try super.init(from: decoder)
    }
    
    override open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: MultiLineTextCodingKeys.self)
        if(self.defaultValue != nil){
            try container.encode(self.defaultValue, forKey: MultiLineTextCodingKeys.defaultValue)
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
