//
//  BulkRequest.swift
//  kintone-ios-sdk
//
//  Created by h001218 on 2018/09/24.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

class BulkRequest: NSObject {
    //private static let BulkRequestParser parser = new BulkRequestParser();
    private var connection: Connection
    private var bulkRequests: BulkRequestModel
    
    /// Constructor function of BulkRequest.
    ///
    /// - Parameter connection: <#connection description#>
    public init(_ connection: Connection) {
        self.connection = connection;
        self.bulkRequests = BulkRequestModel()
    }
    
    /// Add the record.
    ///
    /// - Parameters:
    ///   - app: <#app description#>
    ///   - record: <#record description#>
    /// - Returns: <#return value description#>
    public func addRecord(_ app: Int?, _ record: [String: FieldValue]) -> BulkRequest {
        let addRecordRequest: AddRecordRequest = AddRecordRequest(app, record)
        do {
            let bulkRequestItem: BulkRequestItem = try BulkRequestItem(ConnectionConstants.POST_REQUEST, connection.getPathURI(ConnectionConstants.RECORD), addRecordRequest as Any)
            self.bulkRequests.addRequest(bulkRequestItem)
            return self
        } catch {
            return self
        }
    }
    
    /// Add multi records.
    ///
    /// - Parameters:
    ///   - app: <#app description#>
    ///   - records: <#records description#>
    /// - Returns: <#return value description#>
    public func addRecords(_ app: Int?, _ records: Array<[String: FieldValue]?>) -> BulkRequest {
        
        var tempRecords: Array<[String: FieldValue]> = []
        for record in records {
        //for (HashMap<String, FieldValue> record : records) {
            if (record == nil) {
                tempRecords.append([:])
            } else {
                tempRecords.append(record!)
            }
        }
        
        let addRecordRequest: AddRecordsRequest = AddRecordsRequest(app, tempRecords)
        do {
            let bulkRequestItem: BulkRequestItem = try BulkRequestItem(ConnectionConstants.POST_REQUEST, connection.getPathURI(ConnectionConstants.RECORDS), addRecordRequest as Any)
            self.bulkRequests.addRequest(bulkRequestItem)
            return self
        } catch {
            return self
        }
    }
    
    /// Update the specific record by ID.
    ///
    /// - Parameters:
    ///   - app: <#app description#>
    ///   - id: <#id description#>
    ///   - record: <#record description#>
    ///   - revision: <#revision description#>
    /// - Returns: <#return value description#>
    public func updateRecordByID(_ app: Int?, _ id: Int?, _ record: [String: FieldValue]?, _ revision: Int?) -> BulkRequest {
        let updateRecordRequest: UpdateRecordRequest = UpdateRecordRequest(app, id, nil, revision, record)
        do {
            let bulkRequestItem: BulkRequestItem  = try BulkRequestItem(ConnectionConstants.PUT_REQUEST, connection.getPathURI(ConnectionConstants.RECORD), updateRecordRequest as Any)
            self.bulkRequests.addRequest(bulkRequestItem)
            return self
        } catch {
            return self
        }
    }
    
    /// Update the specific record by updateKey.
    ///
    /// - Parameters:
    ///   - app: <#app description#>
    ///   - updateKey: <#updateKey description#>
    ///   - record: <#record description#>
    ///   - revision: <#revision description#>
    /// - Returns: <#return value description#>
    public func updateRecordByUpdateKey(_ app: Int?, _ updateKey: RecordUpdateKey?, _ record: [String: FieldValue]?, _ revision: Int) -> BulkRequest {
        let updateRecordRequest: UpdateRecordRequest  = UpdateRecordRequest(app, nil, updateKey, revision, record)
        do {
            let bulkRequestItem: BulkRequestItem = try BulkRequestItem(ConnectionConstants.PUT_REQUEST, connection.getPathURI(ConnectionConstants.RECORD), updateRecordRequest)
            self.bulkRequests.addRequest(bulkRequestItem)
            return self
        } catch {
            return self
        }
    }
    
    /// Update multi records.
    ///
    /// - Parameters:
    ///   - app: <#app description#>
    ///   - records: <#records description#>
    /// - Returns: <#return value description#>
    public func updateRecords(_ app: Int?, _ records: Array<RecordUpdateItem>? ) -> BulkRequest {
        let updateRecordsRequest: UpdateRecordsRequest = UpdateRecordsRequest(app, records)
        do {
            let bulkRequestItem: BulkRequestItem = try BulkRequestItem(ConnectionConstants.PUT_REQUEST, connection.getPathURI(ConnectionConstants.RECORDS), updateRecordsRequest)
                self.bulkRequests.addRequest(bulkRequestItem)
            return self
        } catch {
            return self
        }
    
    }
    
    /// Delete multi records.
    ///
    /// - Parameters:
    ///   - app: <#app description#>
    ///   - ids: <#ids description#>
    /// - Returns: <#return value description#>
    public func deleteRecords(_ app: Int?, _ ids: Array<Int>?) -> BulkRequest {
        let deleteRecordsRequest: DeleteRecordsRequest = DeleteRecordsRequest(app, ids, nil)
        do {
            let bulkRequestItem: BulkRequestItem = try BulkRequestItem(ConnectionConstants.DELETE_REQUEST, connection.getPathURI(ConnectionConstants.RECORDS), deleteRecordsRequest)
            self.bulkRequests.addRequest(bulkRequestItem)
            return self
        } catch {
            return self
        }
    }
    
    /// Delete records at the specific revision.
    ///
    /// - Parameters:
    ///   - app: <#app description#>
    ///   - idsWithRevision: <#idsWithRevision description#>
    /// - Returns: <#return value description#>
    public func deleteRecordsWithRevision(_ app: Int?, _ idsWithRevision: [Int: Int]) -> BulkRequest {
    
        var ids: Array<Int> = []
        var revisions: Array<Int> = []
    
        for entry in idsWithRevision {
            ids.append(entry.key)
            revisions.append(entry.value)
        }
        
        let deleteRecordsRequest: DeleteRecordsRequest = DeleteRecordsRequest(app, ids, revisions)
        
        do {
            let bulkRequestItem: BulkRequestItem = try BulkRequestItem(ConnectionConstants.DELETE_REQUEST, connection.getPathURI(ConnectionConstants.RECORDS), deleteRecordsRequest)
            self.bulkRequests.addRequest(bulkRequestItem)
            return self
        } catch {
            return self
        }
    }
    
    /// Update assignees of the specific record.
    ///
    /// - Parameters:
    ///   - app: <#app description#>
    ///   - record: <#record description#>
    ///   - assignees: <#assignees description#>
    ///   - revision: <#revision description#>
    /// - Returns: <#return value description#>
    public func updateRecordAssignees(_ app: Int?, _ record: Int?, _ assignees: Array<String>?, _ revision: Int?) -> BulkRequest {
    
        let updateRecordAssigneesRequest: UpdateRecordAssigneesRequest = UpdateRecordAssigneesRequest(app, record, assignees, revision)
        do {
            let bulkRequestItem: BulkRequestItem = try BulkRequestItem(ConnectionConstants.PUT_REQUEST, connection.getPathURI(ConnectionConstants.RECORD_ASSIGNEES), updateRecordAssigneesRequest)
            self.bulkRequests.addRequest(bulkRequestItem)
            return self
        } catch {
            return self
        }
    }
    
    /// Update status of the specific record.
    ///
    /// - Parameters:
    ///   - app: <#app description#>
    ///   - id: <#id description#>
    ///   - action: <#action description#>
    ///   - assignee: <#assignee description#>
    ///   - revision: <#revision description#>
    /// - Returns: <#return value description#>
    public func updateRecordStatus(_ app: Int?, _ id: Int?, _ action: String?, _ assignee: String?, _ revision: Int?) -> BulkRequest {
    
        let updateRecordStatusRequest: UpdateRecordStatusRequest = UpdateRecordStatusRequest(action, app, assignee, id, revision)
        
        do {
            let bulkRequestItem: BulkRequestItem = try BulkRequestItem(ConnectionConstants.PUT_REQUEST, connection.getPathURI(ConnectionConstants.RECORD_STATUS), updateRecordStatusRequest)
            self.bulkRequests.addRequest(bulkRequestItem)
            return self
        } catch {
            return self
        }
    }
    
    /// Update status of the multi records.
    ///
    /// - Parameters:
    ///   - app: <#app description#>
    ///   - records: <#records description#>
    /// - Returns: <#return value description#>
    public func updateRecordsStatus(_ app: Int?, _ records: Array<RecordUpdateStatusItem>?) -> BulkRequest {
    
        let updateRecordsStatusRequest: UpdateRecordsStatusRequest = UpdateRecordsStatusRequest(app, records)
        do {
            let bulkRequestItem: BulkRequestItem  = try BulkRequestItem(ConnectionConstants.PUT_REQUEST, connection.getPathURI(ConnectionConstants.RECORDS_STATUS), updateRecordsStatusRequest)
            self.bulkRequests.addRequest(bulkRequestItem)
            return self
        } catch {
            return self
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
            let jsonBody = String(data: body, encoding: String.Encoding.utf8)
        
            let response: Data = try connection.request(ConnectionConstants.POST_REQUEST, ConnectionConstants.BULK_REQUEST, jsonBody!)
            let jsonobject = try JSONSerialization.jsonObject(with: response, options: JSONSerialization.ReadingOptions.allowFragments)
            
            let jsonArray = (jsonobject as! NSDictionary)["results"] as! NSArray
            
            var count: Int = 0
            for request in requests {
                let jsonRequest: Data = try JSONSerialization.data(withJSONObject: jsonArray[count], options: [])
                
                var apiName: NSString = request.getApi()! as NSString
                let regex = try NSRegularExpression(pattern: "/v1/(.*).json", options: NSRegularExpression.Options())
                if let regex_result = regex.firstMatch(in: apiName as String, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, apiName.length)){
                    
                    apiName = "\(apiName.substring(with: regex_result.range(at: 1)))" as NSString
                } else {
                    throw KintoneAPIException("Missing search target character string")
                }
                switch (apiName as String) + ":" + request.getMethod()! {
                    case "\(ConnectionConstants.RECORD):\(ConnectionConstants.POST_REQUEST)":
                        let res: AddRecordResponse = try parser.parseJson(AddRecordResponse.self, jsonRequest)
                        responses.addResponse(res)
                        break
                    case "\(ConnectionConstants.RECORDS):\(ConnectionConstants.POST_REQUEST)":
                        let res: AddRecordsResponse = try parser.parseJson(AddRecordsResponse.self, jsonRequest)
                        responses.addResponse(res)
                        break
                    case "\(ConnectionConstants.RECORD):\(ConnectionConstants.PUT_REQUEST)":
                        let res: UpdateRecordRequest = try parser.parseJson(UpdateRecordRequest.self, jsonRequest)
                        responses.addResponse(res)
                        break
                    case "\(ConnectionConstants.RECORDS):\(ConnectionConstants.PUT_REQUEST)":
                        let res: UpdateRecordsRequest = try parser.parseJson(UpdateRecordsRequest.self, jsonRequest)
                        responses.addResponse(res)
                        break
                    case "\(ConnectionConstants.RECORDS):\(ConnectionConstants.DELETE_REQUEST)":
                        let res: DeleteRecordsRequest = try parser.parseJson(DeleteRecordsRequest.self, jsonRequest)
                        responses.addResponse(res)
                        break
                    case "\(ConnectionConstants.RECORD_STATUS):\(ConnectionConstants.PUT_REQUEST)":
                        let res: UpdateRecordStatusRequest = try parser.parseJson(UpdateRecordStatusRequest.self, jsonRequest)
                        responses.addResponse(res)
                        break
                    case "\(ConnectionConstants.RECORDS_STATUS):\(ConnectionConstants.PUT_REQUEST)":
                        let res: UpdateRecordsStatusRequest = try parser.parseJson(UpdateRecordsStatusRequest.self, jsonRequest)
                        responses.addResponse(res)
                        break
                    case "\(ConnectionConstants.RECORD_ASSIGNEES):\(ConnectionConstants.PUT_REQUEST)":
                        let res: UpdateRecordAssigneesRequest = try parser.parseJson(UpdateRecordAssigneesRequest.self, jsonRequest)
                        responses.addResponse(res)
                        break
                    default:
                        throw KintoneAPIException("Invalid Request Command");
                }
                count += 1
            }
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    return responses
    }
}
