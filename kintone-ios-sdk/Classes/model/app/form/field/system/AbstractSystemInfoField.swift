// Copyright (c) 2018 Cybozu, Inc.

public class AbstractSystemInfoField: AbstractSystemField {
    internal var noLabel: Bool?
    
    enum AbstractSystemInfoCodingKeys: CodingKey {
        case noLabel
    }
    
    public override init() {
        super.init()
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AbstractSystemInfoCodingKeys.self)
        self.noLabel = try container.decode(Bool.self, forKey: AbstractSystemInfoCodingKeys.noLabel)
        try super.init(from: decoder)
    }
    
    public func getNoLabel() -> Bool? {
        return self.noLabel
    }
    
    public func setNoLabel(_ noLabel: Bool?) {
        self.noLabel = noLabel
    }
}
