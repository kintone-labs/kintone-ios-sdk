// Copyright (c) 2018 Cybozu, Inc.

open class FieldGroup: Field {
    internal var label: String?
    internal var noLabel: Bool?
    internal var openGroup: Bool?
    
    enum FieldGroupCodingKeys: String, CodingKey {
        case label
        case noLabel
        case openGroup
    }
 
    public override init() {
        super.init()
        self.type = FieldType.GROUP;
    }
    
    public init(_ code: String?) {
        super.init()
        self.code = code!;
        self.type = FieldType.GROUP;
    }
    
    required public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: FieldGroupCodingKeys.self)
            self.label = try container.decode(String.self, forKey: FieldGroupCodingKeys.label)
            self.noLabel = try container.decode(Bool.self, forKey: FieldGroupCodingKeys.noLabel)
            self.openGroup = try container.decode(Bool.self, forKey: FieldGroupCodingKeys.openGroup)
            try super.init(from: decoder)
        } catch {
            throw KintoneAPIException("Parse error")
        }
    }
    
    override open func encode(to encoder: Encoder) throws {
        do {
            var container = encoder.container(keyedBy: FieldGroupCodingKeys.self)
            if(self.label != nil){
                try container.encode(self.label, forKey: FieldGroupCodingKeys.label)
            }
            if(self.noLabel != nil){
                try container.encode(self.noLabel, forKey: FieldGroupCodingKeys.noLabel)
            }
            if(self.openGroup != nil){
                try container.encode(self.openGroup, forKey: FieldGroupCodingKeys.openGroup)
            }
            try super.encode(to: encoder)
        } catch {
            throw KintoneAPIException("Encode error")
        }
    }
    
    open func getLabel() -> String? {
        return self.label;
    }
    
    open func setLabel(_ label: String?) {
        self.label = label;
    }
    
    open func getNoLabel() -> Bool? {
        return self.noLabel;
    }
    
    open func setNoLabel(_ noLabel: Bool?) {
        self.noLabel = noLabel;
    }
    
    open func getOpenGroup() -> Bool? {
        return self.openGroup;
    }
    
    open func setOpenGroup(_ openGroup: Bool?) {
        self.openGroup = openGroup;
    }
}
