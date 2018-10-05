//
//  BulkRequest.swift
//  kintone-ios-sdk
//
//  Created by h001218 on 2018/09/24.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

public class BulkRequest: NSObject {
    //private static let BulkRequestParser parser = new BulkRequestParser();
    private var connection: Connection
    private var bulkRequests: BulkRequestModel
    
    /// Constructor function of BulkRequest.
    ///
    /// - Parameter connection: The Connection module
    public init(_ connection: Connection) {
        self.connection = connection;
        self.bulkRequests = BulkRequestModel()
    }
    
    /// Add the record.
    ///
    /// - Parameters:
    ///   - app: The ID of kintone app
    ///   - record: The record data which will add to kintone app
    /// - Returns: BulkRequest
    /// - Throws: KintoneAPIException
    public func addRecord(_ app: Int, _ record: [String: FieldValue]?) throws -> BulkRequest {
        let addRecordRequest: AddRecordRequest = AddRecordRequest(app, record)
        do {
            let bulkRequestItem: BulkRequestItem = try BulkRequestItem(ConnectionConstants.POST_REQUEST, connection.getPathURI(ConnectionConstants.RECORD), addRecordRequest as Any)
            self.bulkRequests.addRequest(bulkRequestItem)
            return self
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    /// Add multi records.
    ///
    /// - Parameters:
    ///   - app: The ID of kintone app
    ///   - records: The records data which will add to kintone app
    /// - Returns: BulkRequest
    /// - Throws: KintoneAPIException
    public func addRecords(_ app: Int, _ records: Array<[String: FieldValue]?>) throws -> BulkRequest {
        
        var tempRecords: Array<[String: FieldValue]?> = []
        for record in records {
            tempRecords.append(record)
        }
        
        let addRecordRequest: AddRecordsRequest = AddRecordsRequest(app, tempRecords)
        do {
            let bulkRequestItem: BulkRequestItem = try BulkRequestItem(ConnectionConstants.POST_REQUEST, connection.getPathURI(ConnectionConstants.RECORDS), addRecordRequest as Any)
            self.bulkRequests.addRequest(bulkRequestItem)
            return self
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    /// Update the specific record by ID.
    ///
    /// - Parameters:
    ///   - app: The ID of kintone app
    ///   - id: The Record ID of the record to be updated. Required.
    ///   - record: The record data which will update to kintone app
    ///   - revision: The expected revision number.
    /// - Returns: BulkRequest
    /// - Throws: KintoneAPIException
    public func updateRecordByID(_ app: Int, _ id: Int, _ record: [String: FieldValue]?, _ revision: Int?) throws -> BulkRequest {
        let updateRecordRequest: UpdateRecordRequest = UpdateRecordRequest(app, id, nil, revision, record)
        do {
            let bulkRequestItem: BulkRequestItem  = try BulkRequestItem(ConnectionConstants.PUT_REQUEST, connection.getPathURI(ConnectionConstants.RECORD), updateRecordRequest as Any)
            self.bulkRequests.addRequest(bulkRequestItem)
            return self
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    /// Update the specific record by updateKey.
    ///
    /// - Parameters:
    ///   - app: The ID of kintone app
    ///   - updateKey: The unique key of the record to be updated.
    ///   - record: The record data which will update to kintone app
    ///   - revision: The expected revision number.
    /// - Returns: BulkRequest
    /// - Throws: KintoneAPIException
    public func updateRecordByUpdateKey(_ app: Int, _ updateKey: RecordUpdateKey, _ record: [String: FieldValue]?, _ revision: Int?) throws -> BulkRequest {
        let updateRecordRequest: UpdateRecordRequest  = UpdateRecordRequest(app, nil, updateKey, revision, record)
        do {
            let bulkRequestItem: BulkRequestItem = try BulkRequestItem(ConnectionConstants.PUT_REQUEST, connection.getPathURI(ConnectionConstants.RECORD), updateRecordRequest)
            self.bulkRequests.addRequest(bulkRequestItem)
            return self
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    /// Update multi records.
    ///
    /// - Parameters:
    ///   - app: The ID of kintone app
    ///   - records: The records data which will update to kintone app
    /// - Returns: BulkRequest
    /// - Throws: KintoneAPIException
    public func updateRecords(_ app: Int, _ records: Array<RecordUpdateItem> ) throws -> BulkRequest {
        let updateRecordsRequest: UpdateRecordsRequest = UpdateRecordsRequest(app, records)
        do {
            let bulkRequestItem: BulkRequestItem = try BulkRequestItem(ConnectionConstants.PUT_REQUEST, connection.getPathURI(ConnectionConstants.RECORDS), updateRecordsRequest)
                self.bulkRequests.addRequest(bulkRequestItem)
            return self
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    /// Delete multi records.
    ///
    /// - Parameters:
    ///   - app: The ID of kintone app
    ///   - ids: Array of record IDs that will be deleted
    /// - Returns: BulkRequest
    /// - Throws: KintoneAPIException
    public func deleteRecords(_ app: Int, _ ids: Array<Int>) throws -> BulkRequest {
        let deleteRecordsRequest: DeleteRecordsRequest = DeleteRecordsRequest(app, ids, nil)
        do {
            let bulkRequestItem: BulkRequestItem = try BulkRequestItem(ConnectionConstants.DELETE_REQUEST, connection.getPathURI(ConnectionConstants.RECORDS), deleteRecordsRequest)
            self.bulkRequests.addRequest(bulkRequestItem)
            return self
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    /// Delete records at the specific revision.
    ///
    /// - Parameters:
    ///   - app: The ID of kintone app
    ///   - idsWithRevision: The expected revision number per record ID.
    /// - Returns: BulkRequest
    /// - Throws: KintoneAPIException
    public func deleteRecordsWithRevision(_ app: Int, _ idsWithRevision: [Int: Int?]) throws -> BulkRequest {
    
        var ids: Array<Int> = []
        var revisions: Array<Int?> = []
    
        for entry in idsWithRevision {
            ids.append(entry.key)
            revisions.append(entry.value)
        }
        
        let deleteRecordsRequest: DeleteRecordsRequest = DeleteRecordsRequest(app, ids, revisions)
        
        do {
            let bulkRequestItem: BulkRequestItem = try BulkRequestItem(ConnectionConstants.DELETE_REQUEST, connection.getPathURI(ConnectionConstants.RECORDS), deleteRecordsRequest)
            self.bulkRequests.addRequest(bulkRequestItem)
            return self
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    /// Update assignees of the specific record.
    ///
    /// - Parameters:
    ///   - app: The ID of kintone app
    ///   - record: The Record ID.
    ///   - assignees: The user code(s) of the assignee(s).
    ///   - revision: The revision number of the record before updating the assignees.
    /// - Returns: BulkRequest
    /// - Throws: KintoneAPIException
    public func updateRecordAssignees(_ app: Int, _ record: Int, _ assignees: Array<String>, _ revision: Int?) throws -> BulkRequest {
    
        let updateRecordAssigneesRequest: UpdateRecordAssigneesRequest = UpdateRecordAssigneesRequest(app, record, assignees, revision)
        do {
            let bulkRequestItem: BulkRequestItem = try BulkRequestItem(ConnectionConstants.PUT_REQUEST, connection.getPathURI(ConnectionConstants.RECORD_ASSIGNEES), updateRecordAssigneesRequest)
            self.bulkRequests.addRequest(bulkRequestItem)
            return self
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    /// Update status of the specific record.
    ///
    /// - Parameters:
    ///   - app: The App ID.
    ///   - id: The record ID.
    ///   - action: The Action name of the action you want to run.
    ///   - assignee: The next Assignee.
    ///   - revision: The revision number of the record before updating the status.
    /// - Returns: BulkRequest
    /// - Throws: KintoneAPIException
    public func updateRecordStatus(_ app: Int, _ id: Int, _ action: String, _ assignee: String?, _ revision: Int?) throws -> BulkRequest {
    
        let updateRecordStatusRequest: UpdateRecordStatusRequest = UpdateRecordStatusRequest(action, app, assignee, id, revision)
        
        do {
            let bulkRequestItem: BulkRequestItem = try BulkRequestItem(ConnectionConstants.PUT_REQUEST, connection.getPathURI(ConnectionConstants.RECORD_STATUS), updateRecordStatusRequest)
            self.bulkRequests.addRequest(bulkRequestItem)
            return self
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    /// Update status of the multi records.
    ///
    /// - Parameters:
    ///   - app: The ID of kintone app
    ///   - records: An array including information of the record to be updated.
    /// - Returns: BulkRequest
    /// - Throws: KintoneAPIException
    public func updateRecordsStatus(_ app: Int, _ records: Array<RecordUpdateStatusItem>) throws -> BulkRequest {
    
        let updateRecordsStatusRequest: UpdateRecordsStatusRequest = UpdateRecordsStatusRequest(app, records)
        do {
            let bulkRequestItem: BulkRequestItem  = try BulkRequestItem(ConnectionConstants.PUT_REQUEST, connection.getPathURI(ConnectionConstants.RECORDS_STATUS), updateRecordsStatusRequest)
            self.bulkRequests.addRequest(bulkRequestItem)
            return self
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    /// Execute the BulkRequest and get data which is returned from kintone.
    ///
    /// - Returns: BulkRequestResponse
    /// - Throws: KintoneAPIExcdeption
    public func execute() throws -> BulkRequestResponse {
        let parser = BulkRequestParser()
        let responses: BulkRequestResponse = BulkRequestResponse();
        do {
            let requests: Array<BulkRequestItem>  = self.bulkRequests.getRequests()!
    
            let body = try parser.parseObject(self.bulkRequests)
            let jsonBody = String(data: body, encoding: .utf8)
        
            let response: Data = try connection.request(ConnectionConstants.POST_REQUEST, ConnectionConstants.BULK_REQUEST, jsonBody!)
            let jsonobject = try JSONSerialization.jsonObject(with: response, options: .allowFragments)
            
            let jsonArray = (jsonobject as! NSDictionary)["results"] as! NSArray
            
            var count: Int = 0
            for request in requests {
                let jsonResponse: Data = try JSONSerialization.data(withJSONObject: jsonArray[count], options: [])
                
                var apiName: NSString = request.getApi()! as NSString
                let regex = try NSRegularExpression(pattern: "/v1/(.*).json", options: NSRegularExpression.Options())
                if let regex_result = regex.firstMatch(in: apiName as String, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, apiName.length)){
                    
                    apiName = "\(apiName.substring(with: regex_result.range(at: 1)))" as NSString
                } else {
                    throw KintoneAPIException("Missing search target character string")
                }
                
                switch (apiName as String) + ":" + request.getMethod()! {
                    case "\(ConnectionConstants.RECORD):\(ConnectionConstants.POST_REQUEST)":
                        let res: AddRecordResponse = try parser.parseJson(AddRecordResponse.self, jsonResponse)
                        responses.addResponse(res)
                        break
                    case "\(ConnectionConstants.RECORDS):\(ConnectionConstants.POST_REQUEST)":
                        let res: AddRecordsResponse = try parser.parseJson(AddRecordsResponse.self, jsonResponse)
                        responses.addResponse(res)
                        break
                    case "\(ConnectionConstants.RECORD):\(ConnectionConstants.PUT_REQUEST)":
                        let res: UpdateRecordResponse = try parser.parseJson(UpdateRecordResponse.self, jsonResponse)
                        responses.addResponse(res)
                        break
                    case "\(ConnectionConstants.RECORDS):\(ConnectionConstants.PUT_REQUEST)":
                        let res: UpdateRecordsResponse = try parser.parseJson(UpdateRecordsResponse.self, jsonResponse)
                        responses.addResponse(res)
                        break
                    case "\(ConnectionConstants.RECORDS):\(ConnectionConstants.DELETE_REQUEST)":
                        let res: [String: String] = try parser.parseJson([String: String].self, jsonResponse)
                        responses.addResponse(res)
                        break
                    case "\(ConnectionConstants.RECORD_STATUS):\(ConnectionConstants.PUT_REQUEST)":
                        let res: UpdateRecordResponse = try parser.parseJson(UpdateRecordResponse.self, jsonResponse)
                        responses.addResponse(res)
                        break
                    case "\(ConnectionConstants.RECORDS_STATUS):\(ConnectionConstants.PUT_REQUEST)":
                        let res: UpdateRecordsResponse = try parser.parseJson(UpdateRecordsResponse.self, jsonResponse)
                        responses.addResponse(res)
                        break
                    case "\(ConnectionConstants.RECORD_ASSIGNEES):\(ConnectionConstants.PUT_REQUEST)":
                        let res: UpdateRecordResponse = try parser.parseJson(UpdateRecordResponse.self, jsonResponse)
                        responses.addResponse(res)
                        break
                    default:
                        throw KintoneAPIException("Invalid Request Command");
                }
                count += 1
            }
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
        return responses
    }
}
