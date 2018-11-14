// Copyright (c) 2018 Cybozu, Inc.

open class AbstractSystemField: Field {
    internal var label: String?
    
    
    enum AbstractSystemCodingKeys: CodingKey {
        case label
    }
    
    public override init() {
        super.init()
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AbstractSystemCodingKeys.self)
        self.label = try container.decode(String.self, forKey: AbstractSystemCodingKeys.label)
        try super.init(from: decoder)
    }
   
    open func getLabel() -> String? {
        return self.label
    }
    
    open func setLabel(_ label: String?) {
        self.label = label
    }
}
