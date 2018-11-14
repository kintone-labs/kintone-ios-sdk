//
//  CommentMention.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/19.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

open class CommentMention: NSObject, Codable {
    
    private var code: String?
    private var type: String?
    
    /// get the code of th mentioned user, group or organization
    ///
    /// - Returns: the code of th mentioned user, group or organization
    open func getCode() -> String? {
        return self.code
    }
    
    /// set the code of th mentioned user, group or organization
    ///
    /// - Parameter code: the code of th mentioned user, group or organization
    open func setCode(_ code: String) {
        self.code = code
    }
    
    /// get the type of mentioned user
    ///
    /// - Returns: the type of mentioned user
    open func getType() -> String? {
        return self.type
    }
    
    /// set the type of mentioned user
    ///
    /// - Parameter type: the type of mentioned user
    open func setType(_ type: String) {
        self.type = type
    }
    
}
