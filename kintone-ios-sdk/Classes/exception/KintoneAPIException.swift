//
//  KintoneAPIException.swift
//  kintone-ios-sdk
//
//  Created by h001218 on 2018/09/11.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

/// Exception will occur in using kintone RestAPI.
public class KintoneAPIException: Error {
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
    public func getHttpErrorCode() -> Int? {
        return self.httpErrorCode
    }
    
    /// get Error Response message
    ///
    /// - Returns: Response message sent by kintone RestAPI
    public func getErrorResponse() -> ErrorResponse? {
        return self.errorResponse
    }
    
    /// output error message
    ///
    /// - Returns: Error message
    public func toString() -> String? {
        if (self.errorResponse == nil){
            if (self.request == nil || self.errorResponses == nil){
                return message
            }
        }
        
        var sb: String = ""
        if (self.errorResponses == nil){
            if (errorResponse?.getId() != nil){
                sb.append("id: " + (errorResponse?.getId())!)
            }
            if (errorResponse?.getCode() != nil){
                sb.append(", code: " + (errorResponse?.getCode())!)
            }
            if (errorResponse?.getMessage() != nil){
                sb.append(", message: " + (errorResponse?.getMessage())!)
            }
            if (errorResponse?.getErrors() != nil){
                sb.append(", errors: " + (errorResponse?.getErrors())!)
            }
        } else {
            var count: Int = 1
            if (errorResponses != nil) {
                for errorResponse in errorResponses! {
                    if (errorResponse.getId() != nil) {
                        sb.append("api_no: " + String(count))
                        sb.append(", method: " + (self.request?[count - 1].getMethod())!)
                        sb.append(", api_name: " + (self.request?[count - 1].getApi())!)
                        sb.append(", id: " + errorResponse.getId()!)
                        sb.append(", code: " + errorResponse.getCode()!)
                        sb.append(", message: " + errorResponse.getMessage()!)
                        sb.append(", errors: " + errorResponse.getErrors()!)
                    }
                    count += 1
                }
            }
        }
        sb.append(", status: \(String(describing: self.httpErrorCode))")
        return sb
    }
}
