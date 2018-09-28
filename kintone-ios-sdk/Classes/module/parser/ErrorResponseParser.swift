//
//  ErrorResponseParser.swift
//  kintone-ios-sdk
//
//  Created by h001218 on 2018/09/26.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

class ErrorResponseParser: Parser {
    
    public func parseJsonToErrorResponse(_ decoder: Decoder) throws -> ErrorResponse {
        do {
            let errorResponse = ErrorResponse()
            
            // Set coding-key for decoding
            let container = try decoder.container(keyedBy: ErrorResponse.CodingKeys.self)
            
            // Convert message to String Class
            errorResponse.setMessage((try container.decodeIfPresent(String.self, forKey: ErrorResponse.CodingKeys.message)))
            
            // Convert id to String Class
            errorResponse.setId((try container.decodeIfPresent(String.self, forKey: ErrorResponse.CodingKeys.id)))
            
            // Convert code to String Class
            errorResponse.setCode((try container.decodeIfPresent(String.self, forKey: ErrorResponse.CodingKeys.code)))
            
            // Convert errors to String Class
            errorResponse.setErrors((try container.decodeIfPresent([String: [String: Array<String>]].self, forKey: ErrorResponse.CodingKeys.errors)))
            return errorResponse
        } catch {
            throw KintoneAPIException("parse error")
        }
    }
}
