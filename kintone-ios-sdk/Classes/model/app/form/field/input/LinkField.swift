//
//  LinkField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class LinkField: AbstractInputField {
    private var defaultValue: String?
    private var unique: Bool?
    private var maxLength: String?
    private var minLength: String?
    private var linkProtocol: LinkProtocol?
    
    enum LinkFieldCodingKeys: String, CodingKey {
        case defaultValue
        case unique
        case minLength
        case maxLength
        case linkProtocol = "protocol"
    }
    
    /**
     * @param code
     */
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.LINK
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LinkFieldCodingKeys.self)
        self.linkProtocol = try container.decode(LinkProtocol.self, forKey: LinkFieldCodingKeys.linkProtocol)
        self.minLength = try container.decode(String.self, forKey: LinkFieldCodingKeys.minLength)
        self.maxLength = try container.decode(String.self, forKey: LinkFieldCodingKeys.maxLength)
        self.defaultValue = try container.decode(String.self, forKey: LinkFieldCodingKeys.defaultValue)
        self.unique = try container.decode(Bool.self, forKey: LinkFieldCodingKeys.unique)
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: LinkFieldCodingKeys.self)
        if(self.linkProtocol != nil){
            try container.encode(self.linkProtocol, forKey: LinkFieldCodingKeys.linkProtocol)
        }
        if(self.minLength != nil){
            try container.encode(self.minLength, forKey: LinkFieldCodingKeys.minLength)
        }
        if(self.maxLength != nil){
            try container.encode(self.maxLength, forKey: LinkFieldCodingKeys.maxLength)
        }
        if(self.defaultValue != nil){
            try container.encode(self.defaultValue, forKey: LinkFieldCodingKeys.defaultValue)
        }
        if(self.unique != nil){
            try container.encode(self.unique, forKey: LinkFieldCodingKeys.unique)
        }
        try super.encode(to: encoder)
    }
    
    /**
     * @return the defaultValue
     */
    public func getDefaultValue() -> String? {
        return self.defaultValue
    }
    
    /**
     * @param defaultValue the defaultValue to set
     */
    public func setDefaultValue(_ defaultValue: String?) {
        self.defaultValue = defaultValue
    }
    /**
     * @return the unique
     */
    public func getUnique() -> Bool? {
        return self.unique
    }
    
    /**
     * @param unique the unique to set
     */
    public func setUnique(_ unique: Bool?) {
        self.unique = unique
    }
    
    /**
     * @return the maxLength
     */
    public func getMaxLength() -> Int? {
        return Int(self.maxLength!)
    }
    
    /**
     * @param maxLength the maxLength to set
     */
    public func setMaxLength(_ maxLength: String?) {
        self.maxLength = maxLength
    }
    
    /**
     * @return the minLength
     */
    public func getMinLength() -> Int? {
        return Int(self.minLength!)
    }
    
    /**
     * @param minLength the minLength to set
     */
    public func setMinLength(_ minLength: String?) {
        self.minLength = minLength
    }
    
    /**
     * @return the linkProtocol
     */
    public func getProtocol() -> LinkProtocol? {
        return self.linkProtocol
    }
    
    /**
     * @param protocol the protocol to set
     */
    public func setProtocol(_ linkProtocol: LinkProtocol?) {
        self.linkProtocol = linkProtocol
    }
}
