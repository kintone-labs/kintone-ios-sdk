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
    private var maxLength: Int?
    private var minLength: Int?
    private var linkProtocol: LinkProtocol?
    
    /**
     * @param code
     */
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.LINK
    }
    
    public required init(from decoder: Decoder) throws {
        super.init()
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
        return self.maxLength
    }
    
    /**
     * @param maxLength the maxLength to set
     */
    public func setMaxLength(_ maxLength: Int?) {
        self.maxLength = maxLength
    }
    
    /**
     * @return the minLength
     */
    public func getMinLength() -> Int? {
        return self.minLength
    }
    
    /**
     * @param minLength the minLength to set
     */
    public func setMinLength(_ minLength: Int?) {
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
