//
//  UpdateRecordsRequest.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/12.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

internal class UpdateRecordsRequest: NSObject, Codable {

    private var app: Int?
    private var records: [RecordUpdateItem]?
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - app: the ID of record
    ///   - records: the array of record data which will update
    public init(_ app: Int?, _ records: [RecordUpdateItem]?) {
        self.app = app;
        self.records = records;
    }
}
