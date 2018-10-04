//
//  AddRecordsRequest.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/12.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

internal class AddRecordsRequest: NSObject, Codable {
    
    private var app: Int?
    private var records: [[String:FieldValue]?]
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - app: the  ID of kintone app
    ///   - records: the records data which will add to kintone app
    public init(_ app: Int?, _ records: [[String:FieldValue]?]) {
        self.app = app
        self.records = records
    }

}
