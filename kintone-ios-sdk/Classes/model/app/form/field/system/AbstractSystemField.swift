//
//  AbstractSystemField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

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
    /**
     * @return the label
     */
    public func getLabel() -> String? {
        return self.label
    }
    
    /**
     * @param label the label to set
     */
    public func setLabel(_ label: String?) {
        self.label = label
    }
}
