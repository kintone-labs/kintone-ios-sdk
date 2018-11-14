// Copyright (c) 2018 Cybozu, Inc.

open class RichTextField: AbstractInputField {
    private var defaultValue: String?
    
    enum RichTextCodingKeys: CodingKey {
        case defaultValue
    }
    
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.RICH_TEXT
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RichTextCodingKeys.self)
        self.defaultValue = try container.decode(String.self, forKey: RichTextCodingKeys.defaultValue)
        try super.init(from: decoder)
    }
    
    override open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: RichTextCodingKeys.self)
        if(self.defaultValue != nil){
            try container.encode(self.defaultValue, forKey: RichTextCodingKeys.defaultValue)
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
