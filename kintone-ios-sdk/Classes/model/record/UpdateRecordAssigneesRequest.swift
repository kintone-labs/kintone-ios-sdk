//
//  UpdateRecordAssigneesRequest.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/12.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

class UpdateRecordAssigneesRequest: NSObject, Codable {
    
    private var app: Int?
    private var id: Int?
    private var assignees: [String]?;
    private var revision: Int?
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - id: the ID of record
    ///   - assignees: the array of assignee's user code
    ///   - revision: the number of revision
    public init(_ app: Int?, _ id: Int?, _ assignees: [String]?, _ revision: Int?) {
        self.app = app;
        self.id = id;
        self.assignees = assignees;
        self.revision = revision;
    }
}
