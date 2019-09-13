//
//  CreateRecordCursorResponse.swift
//  kintone-ios-sdk
//
//  Created by Ho Kim Cuc on 8/15/19.
//  Copyright © 2019 Cybozu. All rights reserved.
//

open class CreateRecordCursorRequest: NSObject, Codable {
    private var app: Int?
    private var fields: [String]?
    private var query: String?
    private var size: Int?

    public init(_ app: Int?, _ fields: [String]?, _ query: String? = "", _ size: Int?) {
        super.init()
        self.app = app
        self.fields = fields
        self.query = query
        self.size = size
    }
}
