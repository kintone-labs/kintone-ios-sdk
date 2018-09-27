//
//  AbstractSystemInfoField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class AbstractSystemInfoField: AbstractSystemField {
    internal var noLabel: Bool?
    
    enum AbstractSystemInfoCodingKeys: CodingKey {
        case noLabel
    }
    
    public override init() {
        super.init()
    }
    /**
     * @return
     */
    public func getNoLabel() -> Bool? {
        return self.noLabel
    }
    
    /**
     * @param noLabel
     */
    public func setNoLabel(_ noLabel: Bool?) {
        self.noLabel = noLabel
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AbstractSystemInfoCodingKeys.self)
        self.noLabel = try container.decode(Bool.self, forKey: AbstractSystemInfoCodingKeys.noLabel)
        try super.init(from: decoder)
    }
}
