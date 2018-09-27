//
//  GetCommentsRecordRequest.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/19.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

class GetCommentsRecordRequest: NSObject, Codable {
    
    private var app:Int?
    private var record: Int?
    private var order: String?
    private var offset: Int?
    private var limit: Int?
    
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - record: the ID of record
    ///   - order: the sort order of the comment ID
    ///   - offset: the count you will skip the retrieval
    ///   - limit: the number of records to retreive
    public init(_ app: Int?, _ record: Int?, _ order: String?, _ offset: Int?, _ limit: Int?) {
        self.app = app
        self.record = record
        self.order = order
        self.offset = offset
        self.limit = limit
    }
    
}
