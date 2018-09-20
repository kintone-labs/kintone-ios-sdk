//
//  AbstractMemberSelectField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

import Foundation


public class AbstractMemberSelectField: AbstractInputField {
    internal var defaultValue: [MemberSelectEntity]
    internal var entites: [MemberSelectEntity]
    
    public override init() {
        self.defaultValue = [MemberSelectEntity]()
        self.entites = [MemberSelectEntity]()
    }
    /**
     * @return the defaultValue
     */
    public func getDefaultValue() -> [MemberSelectEntity] {
        return self.defaultValue;
    }
    
    /**
     * @param defaultValue
     * the defaultValue to set
     */
    public func setDefaultValue(_ defaultValue: [MemberSelectEntity]) {
        self.defaultValue = defaultValue;
    }
    
    /**
     * @return the entites
     */
    public func getEntites() -> [MemberSelectEntity] {
        return self.entites
    }
    
    /**
     * @param entites
     * the entites to set
     */
    public func setEntites(_ entites: [MemberSelectEntity]) {
        self.entites = entites;
    }
}
