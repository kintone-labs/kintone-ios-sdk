//
//  AddCommentRecordRequest.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/19.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

open class AddCommentRecordRequest: NSObject, Codable {
    
    private var app: Int?
    private var record: Int?
    private var comment: CommentContent?
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - record: the ID of record
    ///   - comment: the content of comment
    public init(_ app: Int?, _ record: Int?, _ comment: CommentContent?) {
        self.app = app
        self.record = record
        self.comment = comment
    }

}
