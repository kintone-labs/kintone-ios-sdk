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
    
    public required init(from decoder: Decoder) throws {
        super.init()
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
}
