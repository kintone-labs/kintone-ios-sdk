// Copyright (c) 2018 Cybozu, Inc.

open class AbstractMemberSelectField: AbstractInputField {
    internal var defaultValue: [MemberSelectEntity]
    internal var entities: [MemberSelectEntity]
    
    
    enum AbstractMemberSelectCodingKeys: CodingKey {
        case defaultValue
        case entities
    }
    
    public override init() {
        self.defaultValue = [MemberSelectEntity]()
        self.entities = [MemberSelectEntity]()
        super.init()
      
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AbstractMemberSelectCodingKeys.self)
        self.defaultValue = try container.decode([MemberSelectEntity].self, forKey: AbstractMemberSelectCodingKeys.defaultValue)
        self.entities = try container.decode([MemberSelectEntity].self, forKey: AbstractMemberSelectCodingKeys.entities)
        try super.init(from: decoder)
    }
    
    override open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AbstractMemberSelectCodingKeys.self)
        if(self.defaultValue.count > 0){
            try container.encode(self.defaultValue, forKey: AbstractMemberSelectCodingKeys.defaultValue)
        }
        if(self.entities.count > 0){
            try container.encode(self.entities, forKey: AbstractMemberSelectCodingKeys.entities)
        }
        try super.encode(to: encoder)
    }

    open func getDefaultValue() -> [MemberSelectEntity] {
        return self.defaultValue
    }
    
    open func setDefaultValue(_ defaultValue: [MemberSelectEntity]) {
        self.defaultValue = defaultValue
    }
    
    open func getEntites() -> [MemberSelectEntity] {
        return self.entities
    }
    
    open func setEntites(_ entities: [MemberSelectEntity]) {
        self.entities = entities
    }
}
