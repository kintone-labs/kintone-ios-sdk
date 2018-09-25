//
//  SubTableLayout.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class SubTableLayout: ItemLayout {
    private var code: String?
    private var fields: [FieldLayout]?
    
    private enum CodingKeys: String, CodingKey {
        case fields
        case code
    }
    /**
     * default constructor
     */
    public override init() {
        super.init()
        self.type = LayoutType.SUBTABLE
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
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(String.self, forKey: SubTableLayout.CodingKeys.code)
        self.fields = try container.decode([FieldLayout].self, forKey: .fields)
        try super.init(from: decoder)
    }
}
