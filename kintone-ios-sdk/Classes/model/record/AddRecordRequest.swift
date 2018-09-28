//
//  AddRecordRequest.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/06.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

internal class AddRecordRequest: NSObject, Codable {
    
    private var app: Int?
    private var record: [String: FieldValue]?
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - record: the record data which will add to kintone app
    public init(_ app: Int?, _ record: [String: FieldValue]) {
        self.app = app
        self.record = record
    }
}
