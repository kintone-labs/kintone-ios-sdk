//
//  UpdateRecordRequest.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/12.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

class UpdateRecordRequest: NSObject, Codable {
    
    private var app: Int?
    private var id: Int?
    private var updateKey: RecordUpdateKey?
    private var revision: Int?
    private var record: [String:FieldValue]?
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - id: the ID of record
    ///   - updateKey: the unique key of the record to be updated
    ///   - revision: the number of revision
    ///   - record: the record data which will update
    public init(_ app: Int?, _ id: Int?, _ updateKey: RecordUpdateKey?, _ revision: Int?, _ record: [String:FieldValue]?) {
        self.app = app;
        self.id = id;
        self.updateKey = updateKey;
        self.revision = revision;
        self.record = record;
    }
}
