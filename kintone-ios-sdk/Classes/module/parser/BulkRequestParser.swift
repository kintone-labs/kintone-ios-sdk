//
//  BulkRequestParser.swift
//  kintone-ios-sdk
//
//  Created by h001218 on 2018/09/25.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

internal class BulkRequestParser: Parser {
    
    public func parseJsonToBulkRequestItem(_ decoder: Decoder) throws -> BulkRequestItem {
        do {
            let bulkRequestItem = BulkRequestItem()
            
            // Set coding-key for decoding
            let container = try decoder.container(keyedBy: BulkRequestItem.CodingKeys.self)
            
            // Convert method to String Class
            bulkRequestItem.setMethod((try container.decodeIfPresent(String.self, forKey: BulkRequestItem.CodingKeys.method))!)
            
            // Convert api to String Class
            bulkRequestItem.setApi((try container.decodeIfPresent(String.self, forKey: BulkRequestItem.CodingKeys.api))!)
            
            // Convert value to Swift Class corresponding to payload
            if bulkRequestItem.getApi() != nil {
                var apiName = (bulkRequestItem.getApi()! as NSString)
                let regex = try NSRegularExpression(pattern: "/v1/(.*).json", options: NSRegularExpression.Options())
                if let regex_result = regex.firstMatch(in: apiName as String, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, apiName.length)){
                    
                    apiName = "\(apiName.substring(with: regex_result.range(at: 1)))" as NSString
                    
                    switch (apiName as String) + ":" + bulkRequestItem.getMethod()! {
                    case "\(ConnectionConstants.RECORD):\(ConnectionConstants.POST_REQUEST)":
                        bulkRequestItem.setPayload(try container.decodeIfPresent(AddRecordRequest.self, forKey: BulkRequestItem.CodingKeys.payload) as Any)
                        break
                    case "\(ConnectionConstants.RECORDS):\(ConnectionConstants.POST_REQUEST)":
                        bulkRequestItem.setPayload(try container.decodeIfPresent(AddRecordsRequest.self, forKey: BulkRequestItem.CodingKeys.payload) as Any)
                        break
                    case "\(ConnectionConstants.RECORD):\(ConnectionConstants.PUT_REQUEST)":
                        bulkRequestItem.setPayload(try container.decodeIfPresent(UpdateRecordRequest.self, forKey: BulkRequestItem.CodingKeys.payload) as Any)
                        break
                    case "\(ConnectionConstants.RECORDS):\(ConnectionConstants.PUT_REQUEST)":
                        bulkRequestItem.setPayload(try container.decodeIfPresent(UpdateRecordsRequest.self, forKey: BulkRequestItem.CodingKeys.payload) as Any)
                        break
                    case "\(ConnectionConstants.RECORDS):\(ConnectionConstants.DELETE_REQUEST)":
                        bulkRequestItem.setPayload(try container.decodeIfPresent(DeleteRecordsRequest.self, forKey: BulkRequestItem.CodingKeys.payload) as Any)
                        break
                    case "\(ConnectionConstants.RECORD_STATUS):\(ConnectionConstants.PUT_REQUEST)":
                        bulkRequestItem.setPayload(try container.decodeIfPresent(UpdateRecordStatusRequest.self, forKey: BulkRequestItem.CodingKeys.payload) as Any)
                        break
                    case "\(ConnectionConstants.RECORDS_STATUS):\(ConnectionConstants.PUT_REQUEST)":
                        bulkRequestItem.setPayload(try container.decodeIfPresent(UpdateRecordStatusRequest.self, forKey: BulkRequestItem.CodingKeys.payload) as Any)
                        break
                    case "\(ConnectionConstants.RECORD_ASSIGNEES):\(ConnectionConstants.PUT_REQUEST)":
                        bulkRequestItem.setPayload(try container.decodeIfPresent(UpdateRecordAssigneesRequest.self, forKey: BulkRequestItem.CodingKeys.payload) as Any)
                        break
                    default:
                        bulkRequestItem.setPayload(try container.decodeIfPresent(String.self, forKey: BulkRequestItem.CodingKeys.payload) as Any)
                    }
                } else {
                    throw KintoneAPIException("Missing search target character string")
                }
            } else {
                throw KintoneAPIException("Missing search target character string")
            }
            return bulkRequestItem
        } catch {
            throw KintoneAPIException("parse error")
        }
    }
    
    /// convert BulkRequestItem.class to Json
    ///
    /// - Parameter encoder:
    /// - Throws:
    public func parseBulkRequestToJson(to encoder: Encoder, _ method: String?, _ api: String?, _ payload: Any?) throws {
        do {
            // Set coding-key for encoding
            var container = encoder.container(keyedBy: BulkRequestItem.CodingKeys.self)
            
            // Convert method to json-item
            try container.encodeIfPresent(method, forKey: BulkRequestItem.CodingKeys.method)
            
            // Convert api to json-item
            try container.encodeIfPresent(api, forKey: BulkRequestItem.CodingKeys.api)
            
            // Convert value to json-item corresponding to payload
            var apiName = api! as NSString
            let regex = try NSRegularExpression(pattern: "/v1/(.*).json", options: NSRegularExpression.Options())
            if let regex_result = regex.firstMatch(in: apiName as String, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, apiName.length)){
                
                apiName = "\(apiName.substring(with: regex_result.range(at: 1)))" as NSString
            } else {
                throw KintoneAPIException("Missing search target character string")
            }
            
            switch (apiName as String) + ":" + method! {
            case "\(ConnectionConstants.RECORD):\(ConnectionConstants.POST_REQUEST)":
                if let pl = payload as? AddRecordRequest {
                    try container.encodeIfPresent(pl, forKey: BulkRequestItem.CodingKeys.payload)
                }
                break
            case "\(ConnectionConstants.RECORDS):\(ConnectionConstants.POST_REQUEST)":
                if let pl = payload as? AddRecordsRequest {
                    try container.encodeIfPresent(pl, forKey: BulkRequestItem.CodingKeys.payload)
                }
                break
            case "\(ConnectionConstants.RECORD):\(ConnectionConstants.PUT_REQUEST)":
                if let pl = payload as? UpdateRecordRequest {
                    try container.encodeIfPresent(pl, forKey: BulkRequestItem.CodingKeys.payload)
                }
                break
            case "\(ConnectionConstants.RECORDS):\(ConnectionConstants.PUT_REQUEST)":
                if let pl = payload as? UpdateRecordsRequest {
                    try container.encodeIfPresent(pl, forKey: BulkRequestItem.CodingKeys.payload)
                }
                break
            case "\(ConnectionConstants.RECORDS):\(ConnectionConstants.DELETE_REQUEST)":
                if let pl = payload as? DeleteRecordsRequest {
                    try container.encodeIfPresent(pl, forKey: BulkRequestItem.CodingKeys.payload)
                }
                break
            case "\(ConnectionConstants.RECORD_STATUS):\(ConnectionConstants.PUT_REQUEST)":
                if let pl = payload as? UpdateRecordStatusRequest {
                    try container.encodeIfPresent(pl, forKey: BulkRequestItem.CodingKeys.payload)
                }
                break
            case "\(ConnectionConstants.RECORDS_STATUS):\(ConnectionConstants.PUT_REQUEST)":
                if let pl = payload as? UpdateRecordsStatusRequest {
                    try container.encodeIfPresent(pl, forKey: BulkRequestItem.CodingKeys.payload)
                }
                break
            case "\(ConnectionConstants.RECORD_ASSIGNEES):\(ConnectionConstants.PUT_REQUEST)":
                if let pl = payload as? UpdateRecordAssigneesRequest {
                    try container.encodeIfPresent(pl, forKey: BulkRequestItem.CodingKeys.payload)
                }
                break
            default:
                throw KintoneAPIException("Invalid Request Command")
            }
        } catch {
            throw KintoneAPIException("parse error")
        }
    }
}
