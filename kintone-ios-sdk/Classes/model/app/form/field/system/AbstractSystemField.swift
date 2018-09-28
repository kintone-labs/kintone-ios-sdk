// Copyright (c) 2018 Cybozu, Inc.

public class AbstractSystemField: Field {
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
   
    public func getLabel() -> String? {
        return self.label
    }
    
    public func setLabel(_ label: String?) {
        self.label = label
    }
}
