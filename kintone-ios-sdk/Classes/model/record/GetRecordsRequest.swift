//
//  GetRecordsRequest.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/06.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

open class GetRecordsRequest: NSObject, Codable {
    
    private var fields: Array<String>?
    private var app: Int?
    private var query: String?
    private var totalCount: Bool?
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - fields: the field codes that you want in the response
    ///   - app: the ID of kintone app
    ///   - query: the query string that will specify what records will be responded
    ///   - totalCount: the flag that  will or not retrieve the total count of records
    public init(_ fields: Array<String>?, _ app: Int?, _ query: String?, _ totalCount: Bool?){
        self.fields = fields
        self.app = app
        self.query = query
        self.totalCount = totalCount
    }
}
