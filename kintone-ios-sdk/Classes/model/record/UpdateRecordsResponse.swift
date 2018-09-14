//
//  UpdateRecordsResponse.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/12.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

import UIKit

class UpdateRecordsResponse: NSObject, Codable {
    
    private var records: [RecordUpdateResponseItem]?
    
    /// get the array of record's IDs
    ///
    /// - Returns: the array of record's IDs
    public func getRecords() -> [RecordUpdateResponseItem]? {
        return self.records;
    }
    
    /// set the array of record's ID
    ///
    /// - Parameter records: the array of record's ID
    public func setRecords(_ records: [RecordUpdateResponseItem]) {
        self.records = records
    }
}
