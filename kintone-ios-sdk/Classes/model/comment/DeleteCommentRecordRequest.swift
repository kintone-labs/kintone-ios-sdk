//
//  DeleteCommentRecordRequest.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/19.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

public class DeleteCommentRecordRequest: NSObject, Codable {
    
    private var app: Int?
    private var record: Int?
    private var comment: Int?
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - record: the ID of record
    ///   - comment: the ID of comment
    public init(_ app: Int?, _ record: Int?, _ comment: Int?) {
        self.app = app
        self.record = record
        self.comment = comment
    }

}
