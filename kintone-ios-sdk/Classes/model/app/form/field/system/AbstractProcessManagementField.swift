//
//  AbstractProcessManagementField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class AbstractProcessManagementField: AbstractSystemField {
    internal var enabled: Bool?
    
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
}
