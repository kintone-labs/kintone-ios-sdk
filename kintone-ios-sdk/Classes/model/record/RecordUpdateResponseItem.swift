
//
//  RecordUpdateResponseItem.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/12.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

class RecordUpdateResponseItem: NSObject, Codable {
    
    private var id: Int?
    private var revision: Int?
    
    /// get the ID of record
    ///
    /// - Returns: the ID of record
    public func getID() -> Int? {
        return self.id
    }
    
    /// set the ID of record
    ///
    /// - Parameter id: the ID of record
    public func setID(_ id: Int) {
        self.id = id;
    }
    
    /// get the number of revision
    ///
    /// - Returns: the number of revision
    public func getRevision() -> Int? {
        return self.revision;
    }
    
    /// set the number of revision
    ///
    /// - Parameter revision: the number of revision
    public func setRevision(_ revision: Int) {
        self.revision = revision;
    }
}
