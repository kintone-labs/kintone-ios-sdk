//
//  Member.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/07.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

open class Member: NSObject, Codable {
    
    public var code: String?
    public var name: String?
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - code: the user/group/organization code
    ///   - name: the user/group/organization name
    public init(_ code: String?, _ name: String?) {
        self.code = code
        self.name = name
    }
    
    /// get the user/group/organization code
    ///
    /// - Returns: the user/group/organization code
    open func getCode() -> String? {
        return self.code
    }
    
    /// set the user/group/organization code
    ///
    /// - Parameter code: the user/group/organization code
    open func setCode(_ code: String) {
        self.code = code
    }
    
    /// get the user/group/organization name
    ///
    /// - Returns: the user/group/organization name
    open func getName() -> String? {
        return self.name
    }
    
    /// set the user/group/organization name
    ///
    /// - Parameter name: the user/group/organization name
    open func setName(_ name: String) {
        self.name = name
    }
}
