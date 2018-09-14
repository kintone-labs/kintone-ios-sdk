//
//  GetRecordResponse.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/05.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

import UIKit

class GetRecordResponse: NSObject, Codable {
    
    private var record: [String:FieldValue]?
    
    /// get the record data
    ///
    /// - Returns: the record dat
    public func getRecord() -> [String:FieldValue]? {
        return self.record
    }
    
    /// set the record data
    ///
    /// - Parameter record: the record data
    public func setRecord(_ record: [String:FieldValue]) {
        self.record = record
    }

}
