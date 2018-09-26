//
//  RecordUpdateKey.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/06.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

public class RecordUpdateKey: NSObject, Codable {
    
    private var field: String?
    private var value: String?
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - field: the field code of unique key in the kintone app
    ///   - value: the field value in the record
    public init(field: String?, value: String?) {
        self.field = field
        self.value = value
    }

}
