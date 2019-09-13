//
//  RecordUpsertItem.swift
//  kintone-ios-sdk
//
//  Created by k000607 on 8/28/19.
//  Copyright © 2019 Cybozu. All rights reserved.
//

open class RecordUpsertItem: NSObject, Codable {
    
    private var updateKey: RecordUpdateKey?
    private var record: [String:FieldValue]?
    
    /// get update key of record
    ///
    /// - Returns: the UpdateKey of record
    open func getUpdateKey() -> RecordUpdateKey? {
        return self.updateKey
    }
    
    /// get record data
    ///
    /// - Returns: the array of field
    open func getRecord() -> [String:FieldValue]? {
        return self.record
    }
    
    /// get record data by update key
    ///
    /// - Parameters:
    ///   - updateKey: the unique key of the record to be updated
    /// - Returns: the record upsert item
    open func getRecord(_ updateKey: RecordUpdateKey?) -> [String:FieldValue]? {
        if self.updateKey == updateKey {
            return self.record
        }
        return nil
    }
    
    /// set update key of record
    ///
    /// - Parameters:
    ///   - updateKey: the unique key of the record to be updated
    open func setUpdateKey(_ updateKey: RecordUpdateKey?) {
        self.updateKey = updateKey
    }
    
    /// set record data
    ///
    /// - Parameters:
    ///   - record: the array of field
    open func setRecord(_ record: [String:FieldValue]?) {
        self.record = record
    }
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - updateKey: the unique key of the record to be updated
    ///   - record: the record data which will update
    public init(_ updateKey: RecordUpdateKey?, _ record: [String:FieldValue]?) {
        self.updateKey = updateKey
        self.record = record
    }
}
