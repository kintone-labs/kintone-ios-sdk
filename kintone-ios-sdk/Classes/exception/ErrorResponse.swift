//
//  ErrorResponse.swift
//  kintone-ios-sdk
//
//  Created by h001218 on 2018/09/11.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

/// Response error message which be sent by kintone RestAPI when sending request unsuccessfully.
public class ErrorResponse: NSObject, Codable {
    private var message: String?
    private var id: String?
    private var code: String?
    private var errors: String?
    
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - message: the message of error
    ///   - id: The error ID which is returned from the kintone API
    ///   - code: The error code which is returned from the kintone API
    ///   - errors: Description of error
    public init(message: String?, id: String?, code: String?, errors: String?){
        self.message = message
        self.id = id
        self.code = code
        self.errors = errors
    }
    
    /// Return error message.
    ///
    /// - Returns: Description of error
    public func getMessage() -> String? {
        return self.message
    }
    
    /// Set error message
    ///
    /// - Parameter message: Description of error
    public func setMessage(_ message: String?) {
        self.message = message
    }
    
    /// Get the id of message.
    ///
    /// - Returns: Id of message
    public func getId() -> String? {
        return self.id
    }
    
    /// Set id for message.
    ///
    /// - Parameter id: The error ID which is returned from the kintone API
    public func setId(id: String?) {
        self.id = id
    }
    
    /// Get the message's code.
    ///
    /// - Returns: Code of message
    public func getCode() -> String? {
        return self.code
    }
    
    /// Set code for message.
    ///
    /// - Parameter code: Code of message
    public func setCode(code: String?) {
        self.code = code
    }
    
    /// get the info of error
    ///
    /// - Returns: the info of error
    public func getErrors() -> String? {
        return self.errors
    }
    
    /// set the info of error
    ///
    /// - Parameter errors: the info of error
    public func setErrors(errors: String?) {
        self.errors = errors
    }
}
