//
//  RowLayout.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class RowLayout: ItemLayout {
    private var fields: [FieldLayout]?
    
    /**
     * default constructor
     */
    public override init() {
        super.init()
        self.type = LayoutType.ROW
        self.fields = [FieldLayout]()
    }
    
    private enum CodingKeys: String, CodingKey {
        case fields
    }
    
    /**
     * @return the fields
     */
    public func getFields() -> [FieldLayout]? {
        return self.fields
    }
    
    /**
     * @param fields
     *   the fields to set
     */
    public func setFields(_ fields: [FieldLayout]?) {
        self.fields = fields
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fields = try container.decode([FieldLayout].self, forKey: .fields)
        try super.init(from: decoder)
    }
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        for fieldItem in self.fields! {
           try container.encode(fieldItem, forKey: CodingKeys.fields)
        }
        try super.encode(to: encoder)
    }
}
