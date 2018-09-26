//
//  GetRecordsResponse.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/12.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

public class GetRecordsResponse: NSObject, Codable {
    
    private var records: [[String:FieldValue]]?
    private var totalCount: Int?
    
    /// get the array of record data
    ///
    /// - Returns: the array of record data
    public func getRecords() -> [[String:FieldValue]]? {
        return self.records
    }
    
    /// set the array of record data
    ///
    /// - Parameter records: the array of record data
    public func setRecords(_ records: [[String:FieldValue]]) {
        self.records = records
    }
    
    /// get the total count of record data
    ///
    /// - Returns: the total count of record data
    public func getTotalCount() -> Int? {
        return self.totalCount
    }
    
    public func setTotalCount(_ totalCount: Int) {
        self.totalCount = totalCount
    }

}
