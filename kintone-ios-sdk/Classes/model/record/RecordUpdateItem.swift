//
//  RecordUpdateItem.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/06.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

class RecordUpdateItem: NSObject, Codable {
    
    private var id: Int?
    private var revision: Int?
    private var updateKey: RecordUpdateKey?
    private var record: [String:FieldValue]?

    /// Constructor
    ///
    /// - Parameters:
    ///   - id: the ID of record
    ///   - revision: the number of revision
    ///   - updateKey: the unique key of the record to be updated
    ///   - record: the record data which will update
    public init(_ id: Int?, _ revision: Int?, _ updateKey: RecordUpdateKey?, _ record: [String:FieldValue]?) {
        self.id = id
        self.revision = revision
    }
}
