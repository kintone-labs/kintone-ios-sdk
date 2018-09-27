//
//  CategoryField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class CategoryField: AbstractSystemField {
    internal var enabled: Bool?
    
    enum CategoryCodingKeys: CodingKey {
        case enabled
    }
    /**
     * @param code
     */
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.CATEGORY
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CategoryCodingKeys.self)
        self.enabled = try container.decode(Bool.self, forKey: CategoryCodingKeys.enabled)
        try super.init(from: decoder)
    }
    
    /**
     * @return
     */
    public func getEnabled() -> Bool? {
        return self.enabled;
    }
    
    /**
     * @param enabled
     */
    public func setEnabled(_ enabled: Bool?) {
        self.enabled = enabled
    }
}
