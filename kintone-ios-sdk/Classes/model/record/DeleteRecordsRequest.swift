//
//  DeleteRecordsRequest.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/12.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

class DeleteRecordsRequest: NSObject, Codable {
    
    private var app: Int?
    private var ids: [Int]?
    private var revisions: [Int?]?
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - ids: the array of record IDs
    ///   - revisions: the array of revision number
    public init(_ app: Int?, _ ids: [Int]?, _ revisions: [Int?]?) {
        self.app = app
        self.ids = ids
        self.revisions = revisions
    }
}
