//
//  FieldGroup.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/18/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class FieldGroup: Field {
    internal var label: String?
    internal var noLabel: Bool?
    internal var openGroup: Bool?
    
    enum FieldGroupCodingKeys: String, CodingKey {
        case label
        case noLabel
        case openGroup
    }
    /**
     * default constructor
     */
    public override init() {
        super.init()
        self.type = FieldType.GROUP;
    }
    
    public init(_ code: String?) {
        super.init()
        self.code = code!;
        self.type = FieldType.GROUP;
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FieldGroupCodingKeys.self)
        self.label = try container.decode(String.self, forKey: FieldGroupCodingKeys.label)
        self.noLabel = try container.decode(Bool.self, forKey: FieldGroupCodingKeys.noLabel)
        self.openGroup = try container.decode(Bool.self, forKey: FieldGroupCodingKeys.openGroup)
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
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
    }
    
    public func getLabel() -> String? {
        return self.label;
    }
    
    public func setLabel(_ label: String?) {
        self.label = label;
    }
    
    public func getNoLabel() -> Bool? {
        return self.noLabel;
    }
    
    public func setNoLabel(_ noLabel: Bool?) {
        self.noLabel = noLabel;
    }
    
    public func getOpenGroup() -> Bool? {
        return self.openGroup;
    }
    
    public func setOpenGroup(_ openGroup: Bool?) {
        self.openGroup = openGroup;
    }
}
