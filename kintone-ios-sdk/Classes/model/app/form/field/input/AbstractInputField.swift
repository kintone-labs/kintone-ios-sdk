//
//  AbstractInputField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/18/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

import UIKit

public class AbstractInputField: Field
{
    internal var label: String?
    internal var noLabel: Bool?
    internal var required: Bool?
    
    public override init() {
        super.init()
    }
    public required init(from decoder: Decoder) throws {
       super.init()
    }
    
    public func getLabel() -> String? {
        return self.label;
    }
    
    public func setLabel(_ label: String?) {
        self.label = label;
    }
    
    public func getNoLabel() -> Bool? {
        return self.noLabel;
    }
    
    public func setNoLabel(_ noLabel: Bool?) {
        self.noLabel = noLabel;
    }
    
    public func getRequired() -> Bool? {
        return self.required;
    }
    
    public func setRequired(_ required: Bool?) {
        self.required = required;
    }
}
