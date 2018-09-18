//
//  BulkRequestItem.swift
//  kintone-ios-sdk
//
//  Created by h001218 on 2018/09/17.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

public class BulkRequestItem: NSObject, Codable {
    
    private var method: String?
    private var api: String?
    private var payload: Any?
    
    enum CodingKeys: String, CodingKey {
        case method
        case api
        case payload
    }
    
    public override init() {
    }
    
    public func getMethod() -> String? {
        return self.method
    }
    
    public func setMethod(_ method: String) {
        self.method = method
    }
    
    public func getApi() -> String? {
        return self.api
    }
    
    public func setApi(_ api: String) {
        self.api = api
    }
    
    public func getPayload() -> Any? {
        return self.payload
    }
    
    public func setPayload(_ payload: Any?) {
        self.payload = payload
    }
    
    /// Convert Json to BulkRequestItem.class
    ///
    /// - Parameter decoder:
    /// - Throws:
    public required init(from decoder: Decoder) throws {
        do {
            // Set coding-key for decoding
            let container = try decoder.container(keyedBy: CodingKeys.self)
            // Convert method to String Class
            self.method = try container.decodeIfPresent(String.self, forKey: CodingKeys.method)
            // Convert api to String Class
            self.api = try container.decodeIfPresent(String.self, forKey: CodingKeys.api)
            
            // Convert value to Swift Class corresponding to payload
            switch type(of: self.payload) {
            case is AddRecordRequest:
                self.payload = try container.decodeIfPresent(AddRecordRequest.self, forKey: CodingKeys.payload)
                break
            default:
                self.payload = try container.decodeIfPresent(String.self, forKey: CodingKeys.payload)
            }
        } catch {
            throw KintoneAPIException("parse error")
        }
    }
    
    /// convert BulkRequestItem.class to Json
    ///
    /// - Parameter encoder:
    /// - Throws:
    public func encode(to encoder: Encoder) throws {
        do {
            // Set coding-key for encoding
            var container = encoder.container(keyedBy: CodingKeys.self)
            // Convert method to json-item
            try container.encodeIfPresent(method, forKey: CodingKeys.method)
            // Convert api to json-item
            try container.encodeIfPresent(api, forKey: CodingKeys.api)
            // Convert value to json-item corresponding to payload
            switch type(of: self.payload) {
            case is AddRecordRequest:
                let payload = self.payload as! AddRecordRequest
                try container.encodeIfPresent(payload, forKey: CodingKeys.payload)
                break
            default:
                let payload = self.payload as! String
                try container.encodeIfPresent(payload, forKey: CodingKeys.payload)
            }
        } catch {
            throw KintoneAPIException("parse error")
        }
    }
}
