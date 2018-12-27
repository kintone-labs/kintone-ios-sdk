// Copyright (c) 2018 Cybozu, Inc.

open class LinkField: AbstractInputField {
    private var defaultValue: String?
    private var unique: Bool?
    private var maxLength: String?
    private var minLength: String?
    private var linkProtocol: LinkProtocol?
    
    enum LinkFieldCodingKeys: String, CodingKey {
        case defaultValue
        case unique
        case minLength
        case maxLength
        case linkProtocol = "protocol"
    }
    
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.LINK
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LinkFieldCodingKeys.self)
        self.linkProtocol = try container.decode(LinkProtocol.self, forKey: LinkFieldCodingKeys.linkProtocol)
        self.minLength = try container.decode(String.self, forKey: LinkFieldCodingKeys.minLength)
        self.maxLength = try container.decode(String.self, forKey: LinkFieldCodingKeys.maxLength)
        self.defaultValue = try container.decode(String.self, forKey: LinkFieldCodingKeys.defaultValue)
        self.unique = try container.decode(Bool.self, forKey: LinkFieldCodingKeys.unique)
        try super.init(from: decoder)
    }
    
    override open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: LinkFieldCodingKeys.self)
        if(self.linkProtocol != nil){
            try container.encode(self.linkProtocol, forKey: LinkFieldCodingKeys.linkProtocol)
        }
        if(self.minLength != nil){
            try container.encode(self.minLength, forKey: LinkFieldCodingKeys.minLength)
        }
        if(self.maxLength != nil){
            try container.encode(self.maxLength, forKey: LinkFieldCodingKeys.maxLength)
        }
        if(self.defaultValue != nil){
            try container.encode(self.defaultValue, forKey: LinkFieldCodingKeys.defaultValue)
        }
        if(self.unique != nil){
            try container.encode(self.unique, forKey: LinkFieldCodingKeys.unique)
        }
        try super.encode(to: encoder)
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
   
    open func getMaxLength() -> Int? {
        return Int(self.maxLength != nil ? self.maxLength! : "")
    }
    
    open func setMaxLength(_ maxLength: String?) {
        self.maxLength = maxLength
    }
  
    open func getMinLength() -> Int? {
        return Int(self.minLength != nil ? self.minLength! : "")
    }
  
    open func setMinLength(_ minLength: String?) {
        self.minLength = minLength
    }
  
    open func getProtocol() -> LinkProtocol? {
        return self.linkProtocol
    }
   
    open func setProtocol(_ linkProtocol: LinkProtocol?) {
        self.linkProtocol = linkProtocol
    }
}
