//
//  FieldGroup.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/18/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

import UIKit

public class FieldGroup: Field {
    internal var label: String?
    internal var noLabel: Bool?
    internal var openGroup: Bool?
    
    /**
     * default constructor
     */
    public override init() {
        super.init()
        self.type = FieldType.GROUP;
    }
    
    public init(_ code: String?) {
        super.init()
        self.code = code!;
        self.type = FieldType.GROUP;
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
    
    public func getOpenGroup() -> Bool? {
        return self.openGroup;
    }
    
    public func setOpenGroup(_ openGroup: Bool?) {
        self.openGroup = openGroup;
    }
}
