//
//  SubTableLayout.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

import Foundation


public class SubTableLayout: ItemLayout {
    private var code: String?
    private var fields: [FieldLayout]?
    
    /**
     * default constructor
     */
    public override init() {
        super.init()
        self.type = LayoutType.SUBTABLE
    }
    
    public required init(from decoder: Decoder) throws {
        super.init()
    }
    
    /**
     * @return the code
     */
    public func getCode() -> String? {
        return self.code
    }
    
    /**
     * @param code the code to set
     */
    public func setCode(_ code: String?) {
        self.code = code
    }
    
    /**
     * @return the fields
     */
    public func getFields() -> [FieldLayout]? {
        return self.fields
    }
    
    /**
     * @param fields the fields to set
     */
    public func setFields(_ fields: [FieldLayout]?) {
        self.fields = fields
    }
}
