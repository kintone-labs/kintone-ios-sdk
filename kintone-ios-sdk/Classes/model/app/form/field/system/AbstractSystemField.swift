//
//  AbstractSystemField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

import Foundation


public class AbstractSystemField: Field {
    internal var label: String?
    
    public override init() {
        super.init()
    }
    public required init(from decoder: Decoder) throws {
        super.init()
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
