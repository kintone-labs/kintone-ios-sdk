//
//  RecordUpdateKey.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/06.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

open class RecordUpdateKey: NSObject, Codable {
    
    private var field: String?
    private var value: String?
    
    /// get field of record
    ///
    /// - Returns: the string of field
    open func getField() -> String? {
        return self.field
    }
    
    /// get value of record
    ///
    /// - Returns: the string of value
    open func getValue() -> String? {
        return self.value
    }
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - field: the field code of unique key in the kintone app
    ///   - value: the field value in the record
    public init(_ field: String?, _ value: String?) {
        self.field = field
        self.value = value
    }

}
