//
//  ErrorResponse.swift
//  kintone-ios-sdk
//
//  Created by h001218 on 2018/09/11.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

import UIKit

public class ErrorResponse: NSObject, Codable {
    private var message: String?
    private var id: String?
    private var code: String?
    private var errors: String?
    
    public init(message: String?, id: String?, code: String?, errors: String?){
        self.message = message
        self.id = id
        self.code = code
        self.errors = errors
    }
    
    public func getMessage() -> String? {
        return self.message
    }
    
    public func setMessage(_ message: String?) {
        self.message = message
    }
    
    public func getId() -> String? {
        return self.id
    }
    
    public func setId(id: String?) {
        self.id = id
    }
    
    public func getCode() -> String? {
        return self.code
    }
    
    public func setCode(code: String?) {
        self.code = code
    }
    
    public func getErrors() -> String? {
        return self.errors
    }
    
    public func setErrors(errors: String?) {
        self.errors = errors
    }
}
