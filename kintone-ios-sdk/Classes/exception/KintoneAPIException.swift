//
//  KintoneAPIException.swift
//  kintone-ios-sdk
//
//  Created by h001218 on 2018/09/11.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

import UIKit

/**
 * Exception will occur in using kintone RestAPI.
 *
 */
public class KintoneAPIException: Error {
    private var message: String?
    private var httpErrorCode: Int?
    private var errorResponse: ErrorResponse?
    private var errorRedponses: Array<ErrorResponse>?
    
    public init(_ httpErrorCode: Int?, _ errorResponse: ErrorResponse?){
        self.message = errorResponse?.getMessage()
        self.httpErrorCode = httpErrorCode
        self.errorResponse = errorResponse
    }
    
    public init(_ error: String?){
        self.message = error
    }
    
    public func getHttpErrorCode() -> Int? {
        return self.httpErrorCode
    }
    
    public func getErrorResponse() -> ErrorResponse? {
        return self.errorResponse
    }
    
    public func toString() -> String? {
        if (self.errorResponse == nil){
            if (self.errorRedponses == nil){
                return message
            }
        }
        
        var sb: String = ""
        if (self.errorRedponses == nil){
            if (errorResponse?.getId() != nil){
                sb.append("id: " + (errorResponse?.getId())!)
            }
            if (errorResponse?.getCode() != nil){
                sb.append(", code: " + (errorResponse?.getCode())!)
            }
            if (errorResponse?.getMessage() != nil){
                sb.append(", message: " + (errorResponse?.getMessage())!)
            }
        } else {
            var count: Int = 1
        }
        
        return sb
    }
}
