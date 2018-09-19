//
//  Record.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/18.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

import UIKit

class Record: NSObject {
    
    private var connection: Connection?
    private let parser = RecordParser()
    
    public init(_ connection: Connection) {
        self.connection = connection
    }
    
    func getRecord(_ app: Int, _ id: Int) throws -> GetRecordResponse {
        do {
            let recordRequest = GetRecordRequest(app, id)
            let body = try! parser.parseObject(recordRequest)
            let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
            let response = try! self.connection?.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.RECORD, jsonBody)
            return try parser.parseJson(GetRecordResponse.self, response as! Data)
        }
    }
    
}
