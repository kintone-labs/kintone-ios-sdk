//
//  AbstractSystemInfoField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

import Foundation

public class AbstractSystemInfoField: AbstractSystemField {
    internal var noLabel: Bool?
    
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
}
