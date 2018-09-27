//
//  AbstractProcessManagementField.swift
//  kintone-ios-sdk
//

public class AbstractProcessManagementField: AbstractSystemField {
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
    
    public func getEnabled() -> Bool? {
        return self.enabled
    }
    
    public func setEnabled(_ enabled: Bool?) {
        self.enabled = enabled
    }
}
