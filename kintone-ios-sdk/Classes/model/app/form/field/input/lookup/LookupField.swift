//
//  LookupField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class LookupField: AbstractInputField {
    private var lookup: LookupItem?
    
    enum LookupFieldCodingKeys: CodingKey {
        case lookup
    }
    /**
     * @param code
     * @param type
     */
    public init(_ code: String, _ type: FieldType) {
        super.init()
        self.type = type
        self.code = code
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LookupFieldCodingKeys.self)
        self.lookup = try container.decode(LookupItem.self, forKey: LookupFieldCodingKeys.lookup)
        try super.init(from: decoder)
    }
    
    /**
     * @return the lookup
     */
    public func getLookup() -> LookupItem? {
        return self.lookup;
    }
    
    /**
     * @param lookup the lookup to set
     */
    public func setLookup(_ lookup: LookupItem?) {
        self.lookup = lookup
    }
    
    
    /**
     * @param type
     * the type to set
     */
    public override func setType(_ type: FieldType?) {
        self.type = type
    }
    
}
