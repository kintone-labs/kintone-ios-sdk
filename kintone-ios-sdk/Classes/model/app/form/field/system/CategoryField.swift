// Copyright (c) 2018 Cybozu, Inc.

open class CategoryField: AbstractSystemField {
    internal var enabled: Bool?
    
    enum CategoryCodingKeys: CodingKey {
        case enabled
    }
 
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.CATEGORY
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CategoryCodingKeys.self)
        self.enabled = try container.decode(Bool.self, forKey: CategoryCodingKeys.enabled)
        try super.init(from: decoder)
    }
    
    open func getEnabled() -> Bool? {
        return self.enabled;
    }
    
    open func setEnabled(_ enabled: Bool?) {
        self.enabled = enabled
    }
}
