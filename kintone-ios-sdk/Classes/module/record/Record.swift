//
//  Record.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/18.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

open class Record: NSObject {
    
    private var connection: Connection?
    private let parser = RecordParser()
    
    /// Constructor
    ///
    /// - Parameter connection: connection
    public init(_ connection: Connection) {
        self.connection = connection
    }
    
    /// Get the record from kintone app
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - id: the ID of record
    /// - Returns: GetRecordResponse
    /// - Throws: KintoneAPIException
    open func getRecord(_ app: Int, _ id: Int) throws -> GetRecordResponse {
        do {
            // execute GET RECORDS API
            let recordRequest = GetRecordRequest(app, id)
            let body = try self.parser.parseObject(recordRequest)
            let jsonBody = String(data: body, encoding: .utf8)!
            let response = try self.connection?.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.RECORD, jsonBody)
            // return response as GetRecordResponse class
            return try self.parser.parseJson(GetRecordResponse.self, response!)
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    /// Get the records from kintone app by query
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - query: the query string that will specify what records will be responded
    ///   - fields: the field codes that you want in the response
    ///   - totalCount: the flag that  will or not retrieve the total count of records
    /// - Returns: GetRecordsResponse
    /// - Throws: KintoneAPIException
    open func getRecords(_ app: Int, _ query: String?, _ fields: [String]?, _ totalCount: Bool?) throws -> GetRecordsResponse {
        do {
            // execute GET RECORDS API
            let recordsRequest = GetRecordsRequest(fields, app, query, totalCount)
            let body = try self.parser.parseObject(recordsRequest)
            let jsonBody = String(data: body, encoding: .utf8)!
            let response = try self.connection?.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.RECORDS, jsonBody)
            // return response as GetRecordsResponse class
            return try self.parser.parseJson(GetRecordsResponse.self, response!)
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    /// Add a record to kintone app
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - record: the record data which will add to kintone app
    /// - Returns: AddRecordResponse
    /// - Throws: KintoneAPIException
    open func addRecord(_ app: Int, _ record: [String:FieldValue]?) throws -> AddRecordResponse {
        do {
            // execute POST RECORD API
            let recordRequest = AddRecordRequest(app, record)
            let body = try self.parser.parseObject(recordRequest)
            let jsonBody = String(data: body, encoding: .utf8)
            let response = try self.connection?.request(ConnectionConstants.POST_REQUEST, ConnectionConstants.RECORD, jsonBody!)
            // return response as AddRecordResponse class
            return try self.parser.parseJson(AddRecordResponse.self, response!)
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    /// Add records to kintone app
    ///
    /// - Parameters:
    ///   - app: the  ID of kintone app
    ///   - records: the records data which will add to kintone app
    /// - Returns: AddRecordsResponse
    /// - Throws: KintoneAPIException
    open func addRecords(_ app: Int, _ records: [[String:FieldValue]]) throws -> AddRecordsResponse {
        do {
            // execute POST RECORDS API
            let recordRequest = AddRecordsRequest(app, records)
            let body = try self.parser.parseObject(recordRequest)
            let jsonBody = String(data: body, encoding: .utf8)
            let response = try self.connection?.request(ConnectionConstants.POST_REQUEST, ConnectionConstants.RECORDS, jsonBody!)
            // return response as AddRecordsResponse class
            return try self.parser.parseJson(AddRecordsResponse.self, response!)
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    /// Update the record on kintone app by ID
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - id: the ID of record
    ///   - record: the record data which will update
    ///   - revision: the number of revision
    /// - Returns: UpdateRecordResponse
    /// - Throws: KintoneAPIException
    open func updateRecordByID(_ app: Int, _ id: Int, _ record: [String:FieldValue]?, _ revision: Int?) throws -> UpdateRecordResponse {
        do {
            // execute PUT RECORD API
            let recordRequest = UpdateRecordRequest(app, id, nil, revision, record)
            let body = try self.parser.parseObject(recordRequest)
            let jsonBody = String(data: body, encoding: .utf8)
            let response = try self.connection?.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.RECORD, jsonBody!)
            // return response as UpdateRecordResponse class
            return try self.parser.parseJson(UpdateRecordResponse.self, response!)
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    /// Update the record on kintone app by UpdateKey
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - updateKey: the unique key of the record to be updated
    ///   - record: the record data which will update
    ///   - revision: the number of revision
    /// - Returns: UpdateRecordResponse
    /// - Throws: KintoneAPIException
    open func updateRecordByUpdateKey(_ app: Int, _ updateKey: RecordUpdateKey, _ record: [String:FieldValue]?, _ revision: Int?) throws -> UpdateRecordResponse {
        do {
            // execute PUT RECORD API
            let recordRequest = UpdateRecordRequest(app, nil, updateKey, revision, record)
            let body = try self.parser.parseObject(recordRequest)
            let jsonBody = String(data: body, encoding: .utf8)
            let response = try self.connection?.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.RECORD, jsonBody!)
            // return response as UpdateRecordResponse class
            return try self.parser.parseJson(UpdateRecordResponse.self, response!)
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    /// Update the records on kintone app
    ///
    /// - Parameters:
    ///   - app: the ID of record
    ///   - records: the array of record data which will update
    /// - Returns: UpdateRecordsResponse
    /// - Throws: KintoneAPIException
    open func updateRecords(_ app: Int, _ records: [RecordUpdateItem]) throws -> UpdateRecordsResponse {
        do {
            // execute PUT RECORDS API
            let recordRequest = UpdateRecordsRequest(app, records)
            let body = try self.parser.parseObject(recordRequest)
            let jsonBody = String(data: body, encoding: .utf8)
            let response = try self.connection?.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.RECORDS, jsonBody!)
            // return response as UpdateRecordsResponse class
            return try self.parser.parseJson(UpdateRecordsResponse.self, response!)
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    /// Delete the records on kintone app
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - ids: the array of record IDs
    /// - Throws: KintoneAPIException
    open func deleteRecords(_ app: Int, _ ids: [Int]) throws {
        do {
            // execute DELETE RECORDS API
            let recordRequest = DeleteRecordsRequest(app, ids, nil)
            let body = try self.parser.parseObject(recordRequest)
            let jsonBody = String(data: body, encoding: .utf8)
            try self.connection?.request(ConnectionConstants.DELETE_REQUEST, ConnectionConstants.RECORDS, jsonBody!)
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    /// Delete the records on kintone app with revision
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - idsWithRevision: the map of revision number to record ID
    /// - Throws: KintoneAPIException
    open func deleteRecordsWithRevision(_ app: Int, _ idsWithRevision: [Int:Int?]) throws {
        // split idsWithRevision into key list and value list
        var ids = [Int]()
        var revisions = [Int?]()
        for entry in idsWithRevision {
            ids.append(entry.key)
            revisions.append(entry.value)
        }
        do {
            // execute DELETE RECORDS API
            let recordRequest = DeleteRecordsRequest(app, ids, revisions)
            let body = try self.parser.parseObject(recordRequest)
            let jsonBody = String(data: body, encoding: .utf8)
            try self.connection?.request(ConnectionConstants.DELETE_REQUEST, ConnectionConstants.RECORDS, jsonBody!)
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    /// Update assignees of the record on kintone app
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - id: the ID of record
    ///   - assignees: the array of assignee's user code
    ///   - revision: the number of revision
    /// - Returns: UpdateRecordResponse
    /// - Throws: KintoneAPIException
    open func updateRecordAssignees(_ app: Int, _ id: Int, _ assignees: [String], _ revision: Int?) throws -> UpdateRecordResponse {
        do {
            // execute PUT RECORD_ASSIGNEES API
            let recordRequest = UpdateRecordAssigneesRequest(app, id, assignees, revision)
            let body = try self.parser.parseObject(recordRequest)
            let jsonBody = String(data: body, encoding: .utf8)
            let response = try self.connection?.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.RECORD_ASSIGNEES, jsonBody!)
            // return response as UpdateRecordResponse class
            return try self.parser.parseJson(UpdateRecordResponse.self, response!)
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    /// Update status of the record on kintone app
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - id: the ID of record
    ///   - action: the Action name of the action you want to do
    ///   - assignee: the log in name of the assignee
    ///   - revision: the number of revision
    /// - Returns: UpdateRecordResponse
    /// - Throws: KintoneAPIException
    open func updateRecordStatus(_ app: Int, _ id: Int, _ action: String, _ assignee: String?, _ revision: Int?) throws -> UpdateRecordResponse {
        do {
            // execute PUT RECORD_STATUS API
            let recordRequest = UpdateRecordStatusRequest(action, app, assignee, id, revision)
            let body = try self.parser.parseObject(recordRequest)
            let jsonBody = String(data: body, encoding: .utf8)
            let response = try self.connection?.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.RECORD_STATUS, jsonBody!)
            // return response as UpdateRecordResponse class
            return try self.parser.parseJson(UpdateRecordResponse.self, response!)
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    /// Update status of the records on kintone app
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - records: the array of record's infomation for update status
    /// - Returns: UpdateRecordsResponse
    /// - Throws: KintoneAPIException
    open func updateRecordsStatus(_ app: Int, _ records: [RecordUpdateStatusItem]) throws -> UpdateRecordsResponse {
        do {
            // execute PUT RECORDS_STATUS API
            let recordRequest = UpdateRecordsStatusRequest(app, records)
            let body = try self.parser.parseObject(recordRequest)
            let jsonBody = String(data: body, encoding: .utf8)
            let response = try self.connection?.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.RECORDS_STATUS, jsonBody!)
            // return response as UpdateRecordsResponse class
            return try self.parser.parseJson(UpdateRecordsResponse.self, response!)
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    /// Get the comments on the record
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - record: the ID of record
    ///   - order: the sort order of the comment ID
    ///   - offset: the count you will skip the retrieval
    ///   - limit: the number of records to retreive
    /// - Returns: GetCommentsResponse
    /// - Throws: KintoneAPIException
    open func getComments(_ app: Int, _ record: Int, _ order: String?, _ offset: Int?, _ limit: Int?) throws -> GetCommentsResponse {
        do {
            // execute GET RECORD_COMMENTS API
            let recordRequest = GetCommentsRecordRequest(app, record, order, offset, limit)
            let body = try self.parser.parseObject(recordRequest)
            let jsonBody = String(data: body, encoding: .utf8)
            let response = try self.connection?.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.RECORD_COMMENTS, jsonBody!)
            // return response as GetCommentsResponse class
            return try self.parser.parseJson(GetCommentsResponse.self, response!)
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    /// Add a comment on the record
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - record: the ID of record
    ///   - comment: the detail of comment
    /// - Returns: AddCommentResponse
    /// - Throws: KintoneAPIException
    open func addComment(_ app: Int, _ record: Int, _ comment: CommentContent) throws -> AddCommentResponse {
        do {
            // execute POST RECORD_COMMENT API
            let recordRequest = AddCommentRecordRequest(app, record, comment)
            let body = try self.parser.parseObject(recordRequest)
            let jsonBody = String(data: body, encoding: .utf8)
            let response = try self.connection?.request(ConnectionConstants.POST_REQUEST, ConnectionConstants.RECORD_COMMENT, jsonBody!)
            // return response as AddCommentResponse class
            return try self.parser.parseJson(AddCommentResponse.self, response!)
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    /// Delete the comment on the record
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - record: the ID of record
    ///   - comment: the ID of comment on the record
    /// - Throws: KintoneAPIException
    open func deleteComment(_ app: Int, _ record: Int, _ comment: Int) throws {
        do {
            // execute DELETE RRECORD_COMMENT API
            let recordRequest = DeleteCommentRecordRequest(app, record, comment)
            let body = try self.parser.parseObject(recordRequest)
            let jsonBody = String(data: body, encoding: .utf8)
            try self.connection?.request(ConnectionConstants.DELETE_REQUEST, ConnectionConstants.RECORD_COMMENT, jsonBody!)
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
}
