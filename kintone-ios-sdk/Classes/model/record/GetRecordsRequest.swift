//
//  GetRecordsRequest.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/06.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

import UIKit

class GetRecordsRequest: NSObject, Codable {
    private var fields: Array<String>?
    private var app: Int?
    private var query: String?
    private var totalCount: Bool?
    
    public init(fields: Array<String>?, app: Int?, query: String?, totalCount: Bool?){
        self.fields = fields
        self.app = app
        self.query = query
        self.totalCount = totalCount
    }
}
