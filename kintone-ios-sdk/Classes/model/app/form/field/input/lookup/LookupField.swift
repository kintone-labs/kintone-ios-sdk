// Copyright (c) 2018 Cybozu, Inc.

open class LookupField: AbstractInputField {
    private var lookup: LookupItem?
    
    enum LookupFieldCodingKeys: CodingKey {
        case lookup
    }
   
    public init(_ code: String, _ type: FieldType) {
        super.init()
        self.type = type
        self.code = code
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LookupFieldCodingKeys.self)
        self.lookup = try container.decode(LookupItem.self, forKey: LookupFieldCodingKeys.lookup)
        try super.init(from: decoder)
    }
    
    override open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: LookupFieldCodingKeys.self)
        if(self.lookup != nil){
            try container.encode(self.lookup, forKey: LookupFieldCodingKeys.lookup)
        }
        try super.encode(to: encoder)
    }
    
    open func getLookup() -> LookupItem? {
        return self.lookup;
    }
    
    open func setLookup(_ lookup: LookupItem?) {
        self.lookup = lookup
    }
    
    open override func setType(_ type: FieldType?) {
        self.type = type
    }
    
}
