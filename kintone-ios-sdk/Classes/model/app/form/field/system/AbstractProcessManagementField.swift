//
//  AbstractProcessManagementField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class AbstractProcessManagementField: AbstractSystemField {
    internal var enabled: Bool?
    
    enum AbstractProcessManagementCodingKeys: CodingKey {
        case enabled
    }
    
    public override init() {
        super.init()
    }
    /**
     * @return
     */
    public func getEnabled() -> Bool? {
        return self.enabled
    }
    
    /**
     * @param enabled
     */
    public func setEnabled(_ enabled: Bool?) {
        self.enabled = enabled
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AbstractProcessManagementCodingKeys.self)
        self.enabled = try container.decode(Bool.self, forKey: AbstractProcessManagementCodingKeys.enabled)
        try super.init(from: decoder)
    }
}
