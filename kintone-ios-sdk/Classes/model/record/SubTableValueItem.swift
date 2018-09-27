//
//  SubTableValueItem.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/10.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

class SubTableValueItem: NSObject, Codable {
    
    private var id: Int?
    private var value: [String:FieldValue]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case value
    }
    
    public override init() {
    }
    
    /// get the ID of record
    ///
    /// - Returns: the ID of table
    public func getID() -> Int? {
        return self.id
    }
    
    /// set the ID of record
    ///
    /// - Parameter id: the ID of record
    public func setID(_ id: Int) {
        self.id = id
    }
    
    /// get the row data of table
    ///
    /// - Returns: the row data of table
    public func getValue() -> [String:FieldValue]? {
        return self.value
    }
    
    /// set the row data of table
    ///
    /// - Parameter value: the row data of table
    public func setValue(_ value: [String:FieldValue]) {
        self.value = value
    }
    
    public required init(from decoder: Decoder) throws {
        do {
            let parser = RecordParser()
            let response = try parser.parseJsonToSubTableItem(decoder)
            self.id = response.getID()
            self.value = response.getValue()
        }
    }

}
