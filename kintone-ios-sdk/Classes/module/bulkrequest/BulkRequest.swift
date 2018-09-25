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
    public func addRecord(_ app: Int, _ record: [String: FieldValue]) -> BulkRequest {
        let addRecordRequest: AddRecordRequest = AddRecordRequest(app, record)
        do {
            let bulkRequestItem: BulkRequestItem = try BulkRequestItem(ConnectionConstants.POST_REQUEST, connection.getPathURI(ConnectionConstants.RECORD), addRecordRequest as Any)
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
        let parser = RecordParser()
        let responses: BulkRequestResponse = BulkRequestResponse();
        do {
            var requests: Array<BulkRequestItem>  = self.bulkRequests.getRequests()!
    
            let body = try parser.parseObject(self.bulkRequests)
            let jsonBody = String(data: body, encoding: String.Encoding.utf8)
        
            let response: Data = try connection.request(ConnectionConstants.POST_REQUEST, ConnectionConstants.BULK_REQUEST, jsonBody!);
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
        /**
    JsonObject object = response.getAsJsonObject();
    JsonArray array = object.getAsJsonArray("results");
    
    Integer count = 0;
    for(BulkRequestItem request : requests) {
    switch(request.getPayload().getClass().getSimpleName()) {
    case BulkRequestConstants.ADD_RECORD:
    responses.addResponse(parser.parseJson(array.get(count), AddRecordResponse.class));
    break;
    case BulkRequestConstants.ADD_RECORDS:
    responses.addResponse(parser.parseJson(array.get(count), AddRecordsResponse.class));
    break;
    case BulkRequestConstants.UPDATE_RECORD:
    responses.addResponse(parser.parseJson(array.get(count), UpdateRecordResponse.class));
    break;
    case BulkRequestConstants.UPDATE_RECORDS:
    responses.addResponse(parser.parseJson(array.get(count), UpdateRecordsResponse.class));
    break;
    case BulkRequestConstants.DELETE_RECORDS:
    responses.addResponse(parser.parseJson(array.get(count), HashMap.class));
    break;
    case BulkRequestConstants.UPDATE_STATUS_RECORD:
    responses.addResponse(parser.parseJson(array.get(count), UpdateRecordResponse.class));
    break;
    case BulkRequestConstants.UPDATE_STATUS_RECORDS:
    responses.addResponse(parser.parseJson(array.get(count), UpdateRecordsResponse.class));
    break;
    case BulkRequestConstants.UPDATE_ASSIGNEE_RECORDS:
    responses.addResponse(parser.parseJson(array.get(count), UpdateRecordResponse.class));
    break;
    default:
    throw new KintoneAPIException("Invalid Request Command");
    }
    count++;
    }
 */
    return responses
    }
}
