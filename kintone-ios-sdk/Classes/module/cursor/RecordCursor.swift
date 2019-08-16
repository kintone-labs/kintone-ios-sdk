//
//  RecordCursor.swift
//  kintone-ios-sdk
//
//  Created by Ho Kim Cuc on 8/15/19.
//  Copyright © 2019 Cybozu. All rights reserved.
//

import Promises

public protocol RecordCursor {
    func createCursor(_ app: Int, _ fields: [String]?, _ query: String?, _ size: Int?) -> Promise<CreateRecordCursorResponse>
    func getRecords(_ cursorID: String) -> Promise<GetRecordCursorResponse>
    func getAllRecords(_ cursorID: String) -> Promise<GetRecordsResponse>
    func deleteCursor(_ cursorID: String) -> Promise<Void>
}

public extension RecordCursor where Self: Cursor {
    /// Create cursor to get Records kintone
    /// - Parameters:
    ///   - app: The ID of kintone app
    ///   - query: Query to get the record
    ///   - fields: The field codes that you want in the response
    /// - Returns: Promise<CreateRecordCursorResponse>
    /// - Throws: KintoneAPIException
    func createCursor(_ app: Int, _ fields: [String]? = nil, _ query: String? = nil, _ size: Int?) -> Promise<CreateRecordCursorResponse> {
        let defaultSize = 100
        return Promise { fulfill, reject in
            let createCursorRequest = CreateRecordCursorRequest(app, fields, query, size ?? defaultSize)
            do {
                let body = try self.parser.parseObject(createCursorRequest)
                let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
                self.connection?.request(ConnectionConstants.POST_REQUEST, ConnectionConstants.CURSOR_RECORD, jsonBody).then { response in
                    let cursorRespone = try self.parser.parseJson(CreateRecordCursorResponse.self, response)
                    fulfill(cursorRespone)
                }.catch{ error in
                    reject(error)
                }
            } catch {
                reject(error)
            }
        }
    }
    
    /// Get the kintone records by cursor
    /// - Parameters:
    ///   - cursorID: The cursor ID
    /// - Returns: Promise<GetRecordCursorResponse>
    /// - Throws: KintoneAPIException
    func getRecords(_ cursorID: String) -> Promise<GetRecordCursorResponse> {
        return Promise { fulfill, reject in
            let getRecordCursorRequest = CursorModel(cursorID)
            do {
                let body = try self.parser.parseObject(getRecordCursorRequest)
                let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
                self.connection?.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.CURSOR_RECORD, jsonBody).then { response in
                    let getRecordCursorRespone = try self.parser.parseJson(GetRecordCursorResponse.self, response)
                    fulfill(getRecordCursorRespone)
                }.catch{ error in
                    reject(error)
                }
            } catch {
                reject(error)
            }
        }
    }
    
    /// Get all kintone records by cursor
    /// - Parameters:
    ///   - cursorID: The cursor ID
    /// - Returns: Promise<GetRecordsResponse>
    /// - Throws: KintoneAPIException
    func getAllRecords(_ cursorID: String)  -> Promise<GetRecordsResponse> {
        return Promise<GetRecordsResponse>(on: .global(), { fulfill, reject in
            var next = true
            var allRecords: [[String:FieldValue]] = []
            while (next) {
                do {
                    let records = try await (self.getRecords(cursorID))
                    next = records.getNext()
                    allRecords += records.getRecords()
                } catch {
                    reject(error)
                }
            }
            let getRecordsRsp = GetRecordsResponse();
            getRecordsRsp.setRecords(allRecords)
            getRecordsRsp.setTotalCount(allRecords.count)
            fulfill(getRecordsRsp)
        })
    }
    
    /// Delete a cursor
    /// - Parameters:
    ///   - cursorID: The cursor ID
    /// - Returns: Promise<Void>
    /// - Throws: KintoneAPIException
    func deleteCursor(_ cursorID: String) -> Promise<Void> {
        return Promise { fulfill, reject in
            let deleteCursor = CursorModel(cursorID)
            do {
                let body = try self.parser.parseObject(deleteCursor)
                let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
                self.connection?.request(ConnectionConstants.DELETE_REQUEST, ConnectionConstants.CURSOR_RECORD, jsonBody).then { response in
                    fulfill(())
                }.catch{ error in
                    reject(error)
                }
            } catch {
                reject(error)
            }
        }
    }
}
