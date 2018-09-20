//
//  UpdateRecordsStatusRequest.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/12.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

import UIKit

class UpdateRecordsStatusRequest: NSObject, Codable {
    
    private var app: Int?
    private var records: [RecordUpdateStatusItem]?
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - records: the array of record's infomation for update
    public init(_ app: Int?, _ records: [RecordUpdateStatusItem]?) {
        self.app = app;
        self.records = records;
    }
}
