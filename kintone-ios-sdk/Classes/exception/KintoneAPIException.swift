//
//  KintoneAPIException.swift
//  kintone-ios-sdk
//
//  Created by h001218 on 2018/09/11.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

/// Exception will occur in using kintone RestAPI.
open class KintoneAPIException: Error {
    private var message: String?
    private var httpErrorCode: Int?
    private var errorResponse: ErrorResponse?
    private var request: Array<BulkRequestItem>?
    private var errorResponses: Array<ErrorResponse>?
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - httpErrorCode: Http error code
    ///   - errorResponse: Response message sent by kintone RestAPI
    public init(_ httpErrorCode: Int?, _ errorResponse: ErrorResponse?){
        self.message = errorResponse?.getMessage()
        self.httpErrorCode = httpErrorCode
        self.errorResponse = errorResponse
    }
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - httpErrorCode: Http error code
    ///   - request: Http request
    ///   - errorResponses: Response message sent by kintone RestAPI
    public init(_ httpErrorCode: Int?, _ request: Array<BulkRequestItem>?, _ errorResponses: Array<ErrorResponse>? ) {
        self.httpErrorCode = httpErrorCode
        self.errorResponses = errorResponses
        self.request = request
    }
    
    /// Constructor
    ///
    /// - Parameter error: The error code which is returned from the kintone API
    public init(_ error: String?){
        self.message = error
    }
    
    /// get Http error code
    ///
    /// - Returns: Http error code
    open func getHttpErrorCode() -> Int? {
        return self.httpErrorCode
    }
    
    /// get Error Response message
    ///
    /// - Returns: Response message sent by kintone RestAPI
    open func getErrorResponse() -> ErrorResponse? {
        return self.errorResponse
    }
    
    /// output error message
    ///
    /// - Returns: Error message
    open func toString() -> String? {
        if (self.errorResponse == nil){
            if (self.request == nil || self.errorResponses == nil){
                return self.message
            }
        }
        
        var sb = ""
        if (self.errorResponses == nil){
            if (self.errorResponse?.getId() != nil){
                sb.append("id: " + (self.errorResponse?.getId())!)
            }
            if (self.errorResponse?.getCode() != nil){
                sb.append(", code: " + (self.errorResponse?.getCode())!)
            }
            if (self.errorResponse?.getMessage() != nil){
                sb.append(", message: " + (self.errorResponse?.getMessage())!)
            }
            if (self.errorResponse?.getErrors() != nil){
                
                var sb2 = ""
                for (key, value) in (self.errorResponse?.getErrors())! {
                    for (key2, value2) in value {
                        let str = value2.joined(separator: "/")
                        sb2.append("\(key): -> \(key2): -> \(str)")
                    }
                }
                sb.append(", errors: \(sb2)")
            }
        } else {
            var count = 1
            
            for errorResponse in self.errorResponses! {
                if (errorResponse.getId() != nil) {
                    sb.append("api_no: " + String(count))
                    sb.append(", method: " + (self.request?[count - 1].getMethod())!)
                    sb.append(", api_name: " + (self.request?[count - 1].getApi())!)
                    sb.append(", id: " + errorResponse.getId()!)
                    sb.append(", code: " + errorResponse.getCode()!)
                    sb.append(", message: " + errorResponse.getMessage()!)
                    
                    if (errorResponse.getErrors() != nil){
                        
                        var sb2 = ""
                        for (key, value) in (errorResponse.getErrors())! {
                            for (key2, value2) in value {
                                let str = value2.joined(separator: "/")
                                sb2.append("\(key) -> \(key2) -> \(str)")
                            }
                        }
                        sb.append(", errors: \(sb2)")
                    }
                }
                count += 1
            }
        }
        sb.append(", status: \(String(describing: self.httpErrorCode))")
        return sb
    }
}
