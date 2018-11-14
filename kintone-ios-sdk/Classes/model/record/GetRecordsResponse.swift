//
//  GetRecordsResponse.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/12.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

open class GetRecordsResponse: NSObject, Codable {
    
    private var records: [[String:FieldValue]]?
    private var totalCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case records
        case totalCount
    }
    
    public override init() {
    }
    
    /// get the array of record data
    ///
    /// - Returns: the array of record data
    open func getRecords() -> [[String:FieldValue]]? {
        return self.records
    }
    
    /// set the array of record data
    ///
    /// - Parameter records: the array of record data
    open func setRecords(_ records: [[String:FieldValue]]) {
        self.records = records
    }
    
    /// get the total count of record data
    ///
    /// - Returns: the total count of record data
    open func getTotalCount() -> Int? {
        return self.totalCount
    }
    
    open func setTotalCount(_ totalCount: Int) {
        self.totalCount = totalCount
    }
    
    public required init(from decoder: Decoder) throws {
        do {
            let parser = RecordParser()
            let response = try parser.parseForGetRecordsResponse(decoder)
            self.records = response.getRecords()
            self.totalCount = response.getTotalCount()
        }
    }

}
