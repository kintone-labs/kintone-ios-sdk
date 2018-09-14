//
//  RecordUpdateStatusItem.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/12.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

import UIKit

class RecordUpdateStatusItem: NSObject, Codable {
    
    private var action: String?
    private var assignee: String?
    private var id: Int?
    private var revision: Int?
    
    
    /// Construtor
    ///
    /// - Parameters:
    ///   - action: the Action name of the action you want to do
    ///   - assignee: the log in name of the assignee
    ///   - id: the ID of record
    ///   - revision: the number of revision
    public init(_ action: String?, _ assignee: String?, _ id: Int?, _ revision: Int?) {
        self.action = action;
        self.assignee = assignee;
        self.id = id;
        self.revision = revision;
    }
}
