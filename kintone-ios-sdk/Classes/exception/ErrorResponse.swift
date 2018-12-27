//
//  ErrorResponse.swift
//  kintone-ios-sdk
//
//  Created by h001218 on 2018/09/11.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

/// Response error message which be sent by kintone RestAPI when sending request unsuccessfully.
open class ErrorResponse: NSObject, Decodable {
    private var message: String?
    private var id: String?
    private var code: String?
    private var errors: [String: [String: Array<String>]]?
    
    enum CodingKeys: String, CodingKey {
        case message
        case id
        case code
        case errors
    }
    
    public override init() {
    }
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - message: the message of error
    ///   - id: The error ID which is returned from the kintone API
    ///   - code: The error code which is returned from the kintone API
    ///   - errors: Description of error
    public required init(message: String?, id: String?, code: String?, errors: [String: [String: Array<String>]]?){
        self.message = message
        self.id = id
        self.code = code
        self.errors = errors
    }
    
    public required init(from decoder: Decoder) throws {
        do {
            let parser = ErrorResponseParser()
            let er = try parser.parseJsonToErrorResponse(decoder)
            self.message = er.getMessage()
            self.id = er.getId()
            self.code = er.getCode()
            self.errors = er.getErrors()
        }
    }
    
    /// Return error message.
    ///
    /// - Returns: the message of error
    open func getMessage() -> String? {
        return self.message
    }
    
    /// Set error message
    ///
    /// - Parameter message: the message of error
    open func setMessage(_ message: String?) {
        self.message = message
    }
    
    /// Get the id of message.
    ///
    /// - Returns: Id of message
    open func getId() -> String? {
        return self.id
    }
    
    /// Set id for message.
    ///
    /// - Parameter id: The error ID which is returned from the kintone API
    open func setId(_ id: String?) {
        self.id = id
    }
    
    /// Get the message's code.
    ///
    /// - Returns: Code of message
    open func getCode() -> String? {
        return self.code
    }
    
    /// Set code for message.
    ///
    /// - Parameter code: Code of message
    open func setCode(_ code: String?) {
        self.code = code
    }
    
    /// get the Description of error
    ///
    /// - Returns: the Description of error
    open func getErrors() -> [String: [String: Array<String>]]? {
        return self.errors
    }
    
    /// set the Description of error
    ///
    /// - Parameter errors: the Description of error
    open func setErrors(_ errors: [String: [String: Array<String>]]?) {
        self.errors = errors
    }
}
