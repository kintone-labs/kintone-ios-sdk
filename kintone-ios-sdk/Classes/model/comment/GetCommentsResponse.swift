//
//  GetCommentsResponse.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/19.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

open class GetCommentsResponse: NSObject, Codable {
    
    private var comments: [Comment]?
    private var older: Bool = false
    private var newer: Bool = false
    
    /// get the array of comments on a record
    ///
    /// - Returns: the array of comments on a record
    open func getComments() -> [Comment]? {
        return self.comments
    }
    
    /// set the array of comments on a record
    ///
    /// - Parameter comments: the array of comments on a record
    open func setComments(_ comments: [Comment]) {
        self.comments = comments
    }
    
    /// get older flag
    ///
    /// - Returns: infomation of older comments
    open func getOlder() -> Bool {
        return self.older
    }
    
    /// set older flag
    ///
    /// - Parameter older: infomation of older comments
    open func setOlder(_ older: Bool) {
        self.older = older
    }
    
    /// get newer flag
    ///
    /// - Returns: infomation of newer comments
    open func getNewer() -> Bool {
        return self.newer
    }
    
    /// set older flag
    ///
    /// - Parameter older: infomation of older comments
    open func setNewer(_ newer: Bool) {
        self.newer = newer
    }
}
