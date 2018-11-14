// Copyright (c) 2018 Cybozu, Inc.

open class AbstractProcessManagementField: AbstractSystemField {
    internal var enabled: Bool?
    
    enum AbstractProcessManagementCodingKeys: CodingKey {
        case enabled
    }
    
    public override init() {
        super.init()
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AbstractProcessManagementCodingKeys.self)
        self.enabled = try container.decode(Bool.self, forKey: AbstractProcessManagementCodingKeys.enabled)
        try super.init(from: decoder)
    }
    
    open func getEnabled() -> Bool? {
        return self.enabled
    }
    
    open func setEnabled(_ enabled: Bool?) {
        self.enabled = enabled
    }
}
