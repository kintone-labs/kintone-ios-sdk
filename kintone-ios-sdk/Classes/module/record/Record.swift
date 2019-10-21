//
//  Record.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/18.
//  Copyright © 2018年 Cybozu. All rights reserved.
//
import Promises

open class Record: NSObject {
    
    private var connection: Connection?
    private let parser = RecordParser()
    private let recordCursor: RecordCursor?
    
    /// Constructor
    ///
    /// - Parameter connection: connection
    public init(_ connection: Connection) {
        self.connection = connection
        self.recordCursor = RecordCursor(connection)
    }
    
    /// Get the record from kintone app
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - id: the ID of record
    /// - Returns: GetRecordResponse
    /// - Throws: KintoneAPIException
    open func getRecord(_ app: Int,_ id: Int)  -> Promise<GetRecordResponse> {
        // execute GET RECORDS API
        return Promise { fulfill, reject in
            // execute GET RECORDS API
            let recordRequest = GetRecordRequest(app, id)
            do {
                let body = try self.parser.parseObject(recordRequest)
                let jsonBody = String(data: body, encoding: .utf8)!
                self.connection?.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.RECORD, jsonBody).then{ response in
                    // return response as GetRecordResponse class
                    let parseResponse = try self.parser.parseJson(GetRecordResponse.self, response)
                    fulfill(parseResponse)
                    }.catch{ error in
                        reject(error)
                }
            } catch {
                reject(error)
            }
        }
    }
    /// Get All records from kintone app
    ///
    /// - Parameters:
    ///   - app: The ID of kintone app
    ///   - query: Query to get the record
    ///   - fields: The field codes that you want in the response
    /// - Returns: Promise<GetRecordsResponse>
    /// - Throws: KintoneAPIException
    open func getAllRecordsByCursor(_ app: Int,_  query: String? = nil,_ fields: [String]? = nil)  -> Promise<GetRecordsResponse> {
        let recordLimitSize = 500
        // execute GET RECORDS API
        return (self.recordCursor?.createCursor(app, fields, query, recordLimitSize)
            .then{createCursorRespone ->  Promise<GetRecordsResponse> in
                return (self.recordCursor?.getAllRecords(createCursorRespone.getId()))!
            })!
    }
    
    /// Add a record to kintone app
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - record: the record data which will add to kintone app
    /// - Returns: AddRecordResponse
    /// - Throws: KintoneAPIException
    open func addRecord(_ app: Int, _ record: [String:FieldValue]?)  -> Promise<AddRecordResponse> {
        // execute POST RECORD API
        return Promise<AddRecordResponse> { fulfill, reject in
            // execute POST RECORD API
            let recordRequest = AddRecordRequest(app, record)
            do {
                let body = try self.parser.parseObject(recordRequest)
                let jsonBody = String(data: body, encoding: .utf8)!
                self.connection?.request(ConnectionConstants.POST_REQUEST, ConnectionConstants.RECORD, jsonBody).then{ response in
                    // return response as GetRecordResponse class
                    let parseResponseToJson = try self.parser.parseJson(AddRecordResponse.self, response)
                    fulfill(parseResponseToJson)
                    }.catch{ error in
                        reject(error)
                }
            } catch {
                reject(error)
            }
        }
    }
    
    func updateBulkRecord(_ app: Int, _ records: [RecordUpdateItem]) -> Promise<BulkRequestResponse> {
        let bulkRequest = BulkRequest(self.connection!)
        let length = records.count
        var numRequest =  length / RecordConstants.LIMIT_UPDATE_RECORD
        if ((length % RecordConstants.LIMIT_UPDATE_RECORD) > 0 || length == 0) {
            numRequest += 1
        }
        for index in 1...numRequest {
            let begin = (index - 1) * RecordConstants.LIMIT_UPDATE_RECORD
            let end = (length - begin) < RecordConstants.LIMIT_UPDATE_RECORD ? length : begin + RecordConstants.LIMIT_UPDATE_RECORD
            let recordsPerRequest = Array(records[begin..<end])
            do {
                try _ = bulkRequest.updateRecords(app, recordsPerRequest)
            } catch {
              return Promise<BulkRequestResponse> { _,reject in
                    reject(error)
                }
            }
        }
        return bulkRequest.execute()
    }
    /// Update the record on kintone app by ID
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - records: the records data which will update
    /// - Returns: BulkRequestResponse
    /// - Throws: BulksException
    open func updateAllRecords (_ app: Int, _ records: [RecordUpdateItem]) -> Promise<BulkRequestResponse>{
        return Promise<BulkRequestResponse>(on: .global(), { fulfill, reject in
            let numRecordsPerBulk = RecordConstants.NUM_BULK_REQUEST * RecordConstants.LIMIT_UPDATE_RECORD
            var numBulkRequest = records.count / numRecordsPerBulk
            let bulkRequestResponse = BulkRequestResponse()
            
            if ((records.count % numRecordsPerBulk) > 0 || records.count == 0)
            {
                numBulkRequest += 1
            }
            
            var offset = 0
            for _ in 1...numBulkRequest {
                let length = records.count
                let end = (length - offset) < numRecordsPerBulk ? length : offset + numRecordsPerBulk
                do {
                    let recordsPerBulk = Array(records[offset..<end])
                    let resultPerBulk = try await(self.updateBulkRecord(app, recordsPerBulk))
                    bulkRequestResponse.addResponse(resultPerBulk.getResults() as Any)
                } catch {
                    bulkRequestResponse.addResponse(error)
                    return reject(BulksException(bulkRequestResponse.getResults()))
                }
                offset += numRecordsPerBulk
            }
            fulfill(bulkRequestResponse)
        })
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
    open func updateRecordByID(_ app: Int, _ id: Int, _ record: [String:FieldValue]?, _ revision: Int?)  -> Promise<UpdateRecordResponse> {
        // execute PUT RECORD API
        return Promise<UpdateRecordResponse> { fulfill, reject in
            // execute PUT RECORD API
            let recordRequest = UpdateRecordRequest(app, id, nil, revision, record)
            do {
                let body = try self.parser.parseObject(recordRequest)
                let jsonBody = String(data: body, encoding: .utf8)!
                self.connection?.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.RECORD, jsonBody).then{ response in
                    // return response as GetRecordResponse class
                    let parseResponseToJson = try self.parser.parseJson(UpdateRecordResponse.self, response)
                    fulfill(parseResponseToJson)
                    }.catch{ error in
                        reject(error)
                }
            } catch {
                reject(error)
            }
        }
    }
    
    /// Delete the records on kintone app
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - ids: the array of record IDs
    /// - Throws: KintoneAPIException
    open func deleteRecords(_ app: Int, _ ids: [Int])  -> Promise<Void> {
        // execute DELETE RECORDS API
        return Promise<Void> { fulfill, reject in
            do {
                let recordRequest = DeleteRecordsRequest(app, ids, nil)
                let body = try self.parser.parseObject(recordRequest)
                let jsonBody = String(data: body, encoding: .utf8)!
                self.connection?.request(ConnectionConstants.DELETE_REQUEST, ConnectionConstants.RECORDS, jsonBody).then{response in
                    fulfill(())
                    }.catch { error in
                        reject(error)
                }
            } catch {
                reject(error)
            }
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
    open func getRecords(_ app: Int, _ query: String?, _ fields: [String]?, _ totalCount: Bool?)  -> Promise<GetRecordsResponse> {
        return Promise { fulfill, reject in
            do {
                // execute GET RECORDS API
                let recordsRequest = GetRecordsRequest(fields, app, query, totalCount)
                let body = try self.parser.parseObject(recordsRequest)
                let jsonBody = String(data: body, encoding: .utf8)!
                self.connection?.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.RECORDS, jsonBody).then{ response in
                    let parseResponse = try self.parser.parseJson(GetRecordsResponse.self, response)
                    fulfill(parseResponse)
                    }.catch{ error in
                        reject(error)
                }
            } catch {
                reject(error)
            }
        }
    }

    
    func addBulkRecord (_ app: Int, _ records: [[String:FieldValue]]) -> Promise<BulkRequestResponse>{
        let bulkRequest = BulkRequest(self.connection!)
        let length = records.count
        var numRequest =  length / RecordConstants.LIMIT_ADD_RECORD
        if ((length % RecordConstants.LIMIT_ADD_RECORD) > 0 || length == 0) {
            numRequest += 1
        }
        for index in 1...numRequest {
            let begin = (index - 1) * RecordConstants.LIMIT_ADD_RECORD
            let end = (length - begin) < RecordConstants.LIMIT_ADD_RECORD ? length : begin + RecordConstants.LIMIT_ADD_RECORD
            let recordsPerRequest = Array(records[begin..<end])
            do {
                try _ = bulkRequest.addRecords(app, recordsPerRequest)
            } catch {
                return Promise<BulkRequestResponse> { _,reject in
                    reject(error)
                }
            }
        }
        return bulkRequest.execute()
    }
    
    /// Add all record to kintone app
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - records: the records data which will add to kintone app
    /// - Returns: AddRecordResponse
    /// - Throws: BulksException
    open func addAllRecords (_ app: Int, _ records: [[String:FieldValue]] ) -> Promise<BulkRequestResponse>{
        return Promise<BulkRequestResponse>(on: .global(), { fulfill, reject in
            let numRecordsPerBulk = RecordConstants.NUM_BULK_REQUEST * RecordConstants.LIMIT_ADD_RECORD
            var numBulkRequest = records.count / numRecordsPerBulk
            let bulkRequestResponse = BulkRequestResponse()
            
            if ((records.count % numRecordsPerBulk) > 0 || records.count == 0)
            {
                numBulkRequest += 1
            }
            
            var offset = 0
            for _ in 1...numBulkRequest {
                let length = records.count
                let end = (length - offset) < numRecordsPerBulk ? length : offset + numRecordsPerBulk
                do {
                    let recordsPerBulk = Array(records[offset..<end])
                    let resultPerBulk = try await(self.addBulkRecord(app, recordsPerBulk))
                    bulkRequestResponse.addResponse(resultPerBulk.getResults() as Any)
                } catch {
                    bulkRequestResponse.addResponse(error)
                    return reject(BulksException(bulkRequestResponse.getResults()))
                }
                offset += numRecordsPerBulk
            }
            fulfill(bulkRequestResponse)
        })
    }
    
    /// Add records to kintone app
    ///
    /// - Parameters:
    ///   - app: the  ID of kintone app
    ///   - records: the records data which will add to kintone app
    /// - Returns: AddRecordsResponse
    /// - Throws: KintoneAPIException
    open func addRecords(_ app: Int, _ records: [[String:FieldValue]]) -> Promise<AddRecordsResponse> {
        return Promise<AddRecordsResponse> { fulfill, reject in
            do {
                // execute POST RECORD API
                let recordRequest = AddRecordsRequest(app, records)
                let body = try self.parser.parseObject(recordRequest)
                let jsonBody = String(data: body, encoding: .utf8)!
                self.connection?.request(ConnectionConstants.POST_REQUEST, ConnectionConstants.RECORDS, jsonBody).then{ response in
                    let parseResponseToJson = try self.parser.parseJson(AddRecordsResponse.self, response)
                    fulfill(parseResponseToJson)
                    }.catch{ error in
                        reject(error)
                }
            } catch {
                reject(error)
            }
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
    open func updateRecordByUpdateKey(_ app: Int, _ updateKey: RecordUpdateKey, _ record: [String:FieldValue]?, _ revision: Int?) -> Promise<UpdateRecordResponse> {
        return Promise<UpdateRecordResponse> { fulfill, reject in
            do {
                // execute PUT RECORD API
                let recordRequest = UpdateRecordRequest(app, nil, updateKey, revision, record)
                let body = try self.parser.parseObject(recordRequest)
                let jsonBody = String(data: body, encoding: .utf8)!
                self.connection?.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.RECORD, jsonBody).then{ response in
                    // return response as UpdateRecordResponse class
                    let parseResponseToJson = try self.parser.parseJson(UpdateRecordResponse.self, response)
                    fulfill(parseResponseToJson)
                    }.catch{ error in
                        reject(error)
                }
            } catch {
                reject(error)
            }
        }
    }
    
    /// Update the records on kintone app
    ///
    /// - Parameters:
    ///   - app: the ID of record
    ///   - records: the array of record data which will update
    /// - Returns: UpdateRecordsResponse
    /// - Throws: KintoneAPIException
    open func updateRecords(_ app: Int, _ records: [RecordUpdateItem])  -> Promise<UpdateRecordsResponse> {
        return Promise<UpdateRecordsResponse> { fulfill, reject in
            do {
                // execute PUT RECORDS API
                let recordRequest = UpdateRecordsRequest(app, records)
                let body = try self.parser.parseObject(recordRequest)
                let jsonBody = String(data: body, encoding: .utf8)!
                self.connection?.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.RECORDS, jsonBody).then{ response in
                    // return response as UpdateRecordsResponse class
                    let parseResponseToJson = try self.parser.parseJson(UpdateRecordsResponse.self, response)
                    fulfill(parseResponseToJson)
                    }.catch{ error in
                        reject(error)
                }
            } catch {
                reject(error)
            }
        }
    }
    
    /// Delete the records on kintone app with revision
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - idsWithRevision: the map of revision number to record ID
    /// - Throws: KintoneAPIException
    open func deleteRecordsWithRevision(_ app: Int, _ idsWithRevision: [Int:Int?])  -> Promise<Void> {
        return Promise<Void> {fulfill, reject in
            do {
                // split idsWithRevision into key list and value list
                var ids = [Int]()
                var revisions = [Int?]()
                for entry in idsWithRevision {
                    ids.append(entry.key)
                    revisions.append(entry.value)
                }
                // execute DELETE RECORDS API
                let recordRequest = DeleteRecordsRequest(app, ids, revisions)
                let body = try self.parser.parseObject(recordRequest)
                let jsonBody = String(data: body, encoding: .utf8)!
                self.connection?.request(ConnectionConstants.DELETE_REQUEST, ConnectionConstants.RECORDS, jsonBody).then{response in
                    fulfill(())
                    }.catch {error in
                        reject(error)
                }
            } catch{
                reject(error)
            }
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
    open func updateRecordAssignees(_ app: Int, _ id: Int, _ assignees: [String], _ revision: Int?)  -> Promise<UpdateRecordResponse> {
        return Promise<UpdateRecordResponse> { fulfill, reject in
            do {
                // execute PUT RECORD_ASSIGNEES API
                let recordRequest = UpdateRecordAssigneesRequest(app, id, assignees, revision)
                let body = try self.parser.parseObject(recordRequest)
                let jsonBody = String(data: body, encoding: .utf8)!
                self.connection?.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.RECORD_ASSIGNEES, jsonBody).then{ response in
                    let parseResponseToJson = try self.parser.parseJson(UpdateRecordResponse.self, response)
                    fulfill(parseResponseToJson)
                    }.catch{ error in
                        reject(error)
                }
            } catch {
                reject(error)
            }
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
    open func updateRecordStatus(_ app: Int, _ id: Int, _ action: String, _ assignee: String?, _ revision: Int?)  -> Promise<UpdateRecordResponse> {
        return Promise<UpdateRecordResponse> { fulfill, reject in
            do {
                // execute PUT RECORD_STATUS API
                let recordRequest = UpdateRecordStatusRequest(action, app, assignee, id, revision)
                let body = try self.parser.parseObject(recordRequest)
                let jsonBody = String(data: body, encoding: .utf8)!
                self.connection?.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.RECORD_STATUS, jsonBody).then{ response in
                    // return response as UpdateRecordsResponse class
                    let parseResponseToJson = try self.parser.parseJson(UpdateRecordResponse.self, response)
                    fulfill(parseResponseToJson)
                    }.catch{ error in
                        reject(error)
                }
            } catch {
                reject(error)
            }
        }
    }
    
    /// Update status of the records on kintone app
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - records: the array of record's infomation for update status
    /// - Returns: UpdateRecordsResponse
    /// - Throws: KintoneAPIException
    open func updateRecordsStatus(_ app: Int, _ records: [RecordUpdateStatusItem])  -> Promise<UpdateRecordsResponse> {
        return Promise<UpdateRecordsResponse> { fulfill, reject in
            do {
                // execute PUT RECORDS_STATUS API
                let recordRequest = UpdateRecordsStatusRequest(app, records)
                let body = try self.parser.parseObject(recordRequest)
                let jsonBody = String(data: body, encoding: .utf8)!
                self.connection?.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.RECORDS_STATUS, jsonBody).then{ response in
                    let parseResponseToJson = try self.parser.parseJson(UpdateRecordsResponse.self, response)
                    fulfill(parseResponseToJson)
                    }.catch{ error in
                        reject(error)
                }
            } catch {
                reject(error)
            }
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
    open func getComments(_ app: Int, _ record: Int, _ order: String?, _ offset: Int?, _ limit: Int?)  -> Promise<GetCommentsResponse> {
        return Promise { fulfill, reject in
            do {
                // execute GET RECORD_COMMENTS API
                let recordRequest = GetCommentsRecordRequest(app, record, order, offset, limit)
                let body = try self.parser.parseObject(recordRequest)
                let jsonBody = String(data: body, encoding: .utf8)!
                self.connection?.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.RECORD_COMMENTS, jsonBody).then{ response in
                    let parseResponse = try self.parser.parseJson(GetCommentsResponse.self, response)
                    fulfill(parseResponse)
                    }.catch{ error in
                        reject(error)
                }
            } catch {
                reject(error)
            }
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
    open func addComment(_ app: Int, _ record: Int, _ comment: CommentContent)  -> Promise<AddCommentResponse> {
        return Promise { fulfill, reject in
            do {
                // execute GET RECORD_COMMENTS API
                let recordRequest = AddCommentRecordRequest(app, record, comment)
                let body = try self.parser.parseObject(recordRequest)
                let jsonBody = String(data: body, encoding: .utf8)!
                self.connection?.request(ConnectionConstants.POST_REQUEST, ConnectionConstants.RECORD_COMMENT, jsonBody).then{ response in
                    let parseResponse = try self.parser.parseJson(AddCommentResponse.self, response)
                    fulfill(parseResponse)
                    }.catch{ error in
                        reject(error)
                }
            } catch {
                reject(error)
            }
        }
    }
    
    /// Delete the comment on the record
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - record: the ID of record
    ///   - comment: the ID of comment on the record
    /// - Throws: KintoneAPIException
    open func deleteComment(_ app: Int, _ record: Int, _ comment: Int) -> Promise<Void> {
        return Promise<Void> { fulfill,reject in
            do {
                // execute DELETE RRECORD_COMMENT API
                let recordRequest = DeleteCommentRecordRequest(app, record, comment)
                let body = try self.parser.parseObject(recordRequest)
                let jsonBody = String(data: body, encoding: .utf8)!
                self.connection?.request(ConnectionConstants.DELETE_REQUEST, ConnectionConstants.RECORD_COMMENT, jsonBody).then{response in
                    fulfill(())
                    }.catch { error in
                        reject(error)
                }
            } catch {
                reject(error)
            }
        }
    }
    
    private func fetchRecords(_ app: Int, _ query: String, _ fields: [String], _ totalCount: Bool,
                              _ offset: Int, _ records: [[String: FieldValue]]) throws -> GetRecordsResponse {
        var validQuery: String
        var interOffset = offset
        var interRecord = records
        
        if query.count != 0 {
            validQuery = "\(query) limit \(RecordConstants.LIMIT_GET_RECORD) offset \(offset)"
        } else {
            validQuery = "limit \(RecordConstants.LIMIT_GET_RECORD) offset \(offset)"
        }
        do {
            let fetchBlock = try await(self.getRecords(app, validQuery, fields, totalCount))
            interRecord.append(contentsOf: fetchBlock.getRecords()!)
            if fetchBlock.getRecords()!.count < RecordConstants.LIMIT_GET_RECORD {
                fetchBlock.setRecords(interRecord)
                return fetchBlock
            }
            interOffset = offset + RecordConstants.LIMIT_GET_RECORD
        } catch let error as KintoneAPIException {
            throw error
        }
        return try self.fetchRecords(app, query, fields, totalCount, interOffset, interRecord)
    }
    
    open func getAllRecordsByQuery(_ app: Int, _ query: String? = "", _ fields: [String]? = [], _ totalCount: Bool? = false) -> Promise<GetRecordsResponse> {
        return Promise<GetRecordsResponse>(on: .global(), { fulfill, reject in
            do {
                let response = try self.fetchRecords(app, query!, fields!, totalCount!, 0, [[String: FieldValue]]())
                fulfill(response)
            } catch {
                reject(error)
            }
        })
    }
  
    private func deleteBulkRecord(_ app: Int, _ ids: [Int]) throws -> BulkRequestResponse {
        do {
            let bulkRequest = BulkRequest(self.connection!)
            let length:Int = ids.count
            var loopTimes:Int = length / RecordConstants.LIMIT_DELETE_RECORD
            if (length % RecordConstants.LIMIT_DELETE_RECORD) > 0 {
                loopTimes+=1
            }
            if (length > 0 && length < RecordConstants.LIMIT_DELETE_RECORD) {
                loopTimes = 1
            }
//            for i in 0..<loopTimes {
//                let begin:Int = i * RecordConstants.LIMIT_DELETE_RECORD
//                let end:Int = (length - begin) < RecordConstants.LIMIT_DELETE_RECORD ? length : (begin + RecordConstants.LIMIT_DELETE_RECORD)
//                let idsPerRequest = ids[begin..<end]
//                try bulkRequest.deleteRecords(app, Array(idsPerRequest))
//            }
            return try await(bulkRequest.execute())
        } catch let error as KintoneAPIException {
            throw error
        }
    }
    
    open func deleteAllRecordsByQuery(_ app: Int, _ query: String? = "") -> Promise<BulkRequestResponse> {
        return Promise<BulkRequestResponse>(on: .global(), { fulfill, reject in
            do {
                var innerQuery: String
                if (query == nil) {
                    innerQuery = ""
                } else {
                    innerQuery = query!
                }
                let requestResponse = BulkRequestResponse()
                var fields = [String]()
                fields.append("$id")
                let getRecordsRequest: GetRecordsResponse = try await(self.getAllRecordsByQuery(app, innerQuery, fields, true))
                let recordsArray = getRecordsRequest.getRecords()
                let totalRecords:Int = getRecordsRequest.getTotalCount()!
                let numRecordsPerBulk:Int = RecordConstants.NUM_BULK_REQUEST * RecordConstants.LIMIT_DELETE_RECORD
                var numBulkRequest:Int = totalRecords / numRecordsPerBulk
                if (totalRecords % numRecordsPerBulk) > 0 {
                    numBulkRequest+=1
                }
                if totalRecords > 0 && totalRecords < numRecordsPerBulk {
                    numBulkRequest = 1
                }
                var ids = [Int]()
                recordsArray?.forEach{ item in
                    let idText:String = (item["$id"]!).getValue()! as! String
                    let id:Int = Int(idText)!
                    ids.append(id)
                }
                var offset:Int = 0
                for _ in 0..<numBulkRequest {
                    let end:Int = (totalRecords - offset) < numRecordsPerBulk ? totalRecords : (offset + numRecordsPerBulk)
                    let idPerBulk = ids[offset..<end]
                    let idPerBulkArray:[Int] = Array(idPerBulk)
                    do {
                        let requestResponsePerBulk:BulkRequestResponse = try self.deleteBulkRecord(app, idPerBulkArray)
                        requestResponse.addResponse(requestResponsePerBulk.getResults()!)
                    } catch let error as KintoneAPIException {
                        requestResponse.addResponse(error)
                        throw BulksException(requestResponse.getResults())
                    }
                    offset += numRecordsPerBulk
                }
                fulfill(requestResponse)
            } catch {
                reject(error)
            }
        })
    }
  
    /// Upsert the record on kintone app by UpdateKey
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - updateKey: the unique key of the record to be updated
    ///   - record: the record data which will update
    ///   - revision: the number of revision. Default value is -1.
    /// - Returns: AddRecordResponse or UpdateRecordResponse
    /// - Throws: KintoneAPIException
    open func upsertRecord(_ app: Int, _ updateKey: RecordUpdateKey, _ record: [String:FieldValue], _ revision: Int? = -1) -> Promise<AnyObject> {
        return Promise<AnyObject>(on: .global(), { fulfill, reject in
            do {
                let response = try self._getResponseToUpsertRecord(app, updateKey, record, revision)
                fulfill(response);
            } catch let error as KintoneAPIException {
                reject(error)
            }
        })
    }

    /// Get response to upsert record.
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - updateKey: the unique key of the record to be updated
    ///   - record: the record data which will update
    ///   - revision: the number of revision
    /// - Returns: AddRecordResponse or UpdateRecordResponse
    /// - Throws: KintoneAPIException
    private func _getResponseToUpsertRecord(_ app: Int, _ updateKey: RecordUpdateKey, _ record: [String:FieldValue], _ revision: Int?) throws -> AnyObject {
        let updateKeyField = updateKey.getField()!
        let updateKeyValue = updateKey.getValue()!
        let query = "\(updateKeyField) = \"\(updateKeyValue)\""
        let getRecordsResponse = try await(self.getRecords(app, query, [updateKeyField], false))
        let numberOfRecords: Int = getRecordsResponse.getRecords()!.count
        if updateKeyValue.isEmpty || numberOfRecords < 1 {
            record[updateKeyField]?.setValue(updateKeyValue)
            return try await(self.addRecord(app, record))
        } else if numberOfRecords == 1 {
            return try await(self.updateRecordByUpdateKey(app, updateKey, record, revision))
        }
        throw KintoneAPIException("\(updateKeyField) is not unique field")
    }
  
    /// Upsert the records on kintone app
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - records: the records data which will update
    /// - Returns: BulkRequestResponse
    /// - Throws: BulksException or KintoneAPIException
    open func upsertRecords(_ app: Int, _ records: [RecordUpsertItem]) -> Promise<BulkRequestResponse> {
        return Promise<BulkRequestResponse>(on: .global(), {fulfill, reject in
            if records.count > RecordConstants.LIMIT_UPSERT_RECORD {
                 return reject(KintoneAPIException("upsertRecords can't handle over \(RecordConstants.LIMIT_UPSERT_RECORD) records."))
            }
            
            let bulkRequestResponse = BulkRequestResponse()
            
            do {
                let allRecordsResponse = try await(self.getAllRecordsByQuery(app))
                let allRecords = allRecordsResponse.getRecords()
                var recordsToUpdate: [RecordUpdateItem] = []
                var recordsToAdd: [[String:FieldValue]] = []
                
                for recordUpsertItem in records {
                    let recordUpdateKey = recordUpsertItem.getUpdateKey()!
                    let recordUpdateKeyValue = recordUpdateKey.getValue()!
                    let recordUpdateKeyField = recordUpdateKey.getField()!
                    let record = recordUpsertItem.getRecord()!
                    
                    if self._doesExistSameFieldValue(allRecords, recordUpsertItem) {
                        let recordUpdateItem = RecordUpdateItem(nil, nil, recordUpdateKey, record)
                        recordsToUpdate.append(recordUpdateItem)
                    } else {
                        record[recordUpdateKeyField]?.setValue(recordUpdateKeyValue)
                        recordsToAdd.append(record)
                    }
                }
                let upsertBulkRequest = try await(self._executeUpsertBulkRequest(app, recordsToUpdate, recordsToAdd))
                bulkRequestResponse.addResponse(upsertBulkRequest.getResults()!)
            } catch {
                bulkRequestResponse.addResponse(error)
                return reject(BulksException(bulkRequestResponse.getResults()))
            }
            fulfill(bulkRequestResponse)
        })
    }
    
    private func _executeUpsertBulkRequest(_ app: Int,_ recordsToUpdate: [RecordUpdateItem]?,_ recordsToAdd: [[String:FieldValue]]?) -> Promise<BulkRequestResponse> {
        do {
            var bulkRequest = BulkRequest(self.connection!)
            if recordsToAdd!.count > 0 {
                bulkRequest = try self._getBulkRequestForAddRecords(app, bulkRequest, recordsToAdd!)
            }
            if recordsToUpdate!.count > 0 {
                bulkRequest = try self._getBulkRequestForUpdateRecords(app, bulkRequest, recordsToUpdate!)
            }
            return bulkRequest.execute()
        } catch {
            return Promise<BulkRequestResponse> { _, reject in
                reject(error)
            }
        }
    }

    private func _getBulkRequestForAddRecords(_ app: Int,_ bulkRequest: BulkRequest, _ records: [[String:FieldValue]]) throws -> BulkRequest{
        let recordLimit = RecordConstants.LIMIT_ADD_RECORD
        let length = records.count;
        var numRequest =  length / recordLimit;
        if ((length % recordLimit) > 0 || length == 0) {
            numRequest += 1
        }
        for index in 1...numRequest {
            let begin = (index - 1) * recordLimit;
            let end = (length - begin) < recordLimit ? length : begin + recordLimit;
            let recordsPerRequest = Array(records[begin..<end]);
            do {
                try _ = bulkRequest.addRecords(app, recordsPerRequest);
            } catch let error as KintoneAPIException {
                throw error
            }
        }
        return bulkRequest
    }
    
    private func _getBulkRequestForUpdateRecords(_ app: Int,_ bulkRequest: BulkRequest, _ records: [RecordUpdateItem]) throws -> BulkRequest{
        let recordLimit = RecordConstants.LIMIT_UPDATE_RECORD
        let length = records.count;
        var numRequest =  length / recordLimit;
        if ((length % recordLimit) > 0 || length == 0) {
            numRequest += 1
        }
        for index in 1...numRequest {
            let begin = (index - 1) * recordLimit;
            let end = (length - begin) < recordLimit ? length : begin + recordLimit;
            let recordsPerRequest = Array(records[begin..<end]);
            do {
                try _ = bulkRequest.updateRecords(app, recordsPerRequest);
            } catch let error as KintoneAPIException {
                throw error
            }
        }
        return bulkRequest
    }
    
    private func _doesExistSameFieldValue(_ records: [[String:FieldValue]]?,_ compareRecord: RecordUpsertItem) -> Bool {
        let compareRecordUpdateKey = compareRecord.getUpdateKey()!
        let compareRecordUpdateKeyValue = compareRecordUpdateKey.getValue()!
        let compareRecordUpdateKeyField = compareRecordUpdateKey.getField()!
        
        if compareRecordUpdateKeyValue.isEmpty {
            return false
        }
        
        for record in records! {
            let recordValue = record[compareRecordUpdateKeyField]?.getValue() as? String
            if recordValue == compareRecordUpdateKeyValue {
                return true
            }
        }
        return false
    }
}
