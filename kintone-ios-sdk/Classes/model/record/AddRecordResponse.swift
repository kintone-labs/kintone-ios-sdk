//
//  AddRecordResponse.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/12.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

import UIKit

class AddRecordResponse: NSObject {
    
    private var id: Int?
    private var revision: Int?
    
    /// get the ID of record
    ///
    /// - Returns: the ID of record
    public func getId() -> Int? {
        return self.id
    }
    
    /// set the ID of record
    ///
    /// - Parameter id: the ID of record
    public func setId(_ id: Int) {
        self.id = id
    }
    
    /// getb the revision of record
    ///
    /// - Returns: the revision number of record
    public func getRevision() -> Int? {
        return self.revision
    }
    
    /// set the revision of record
    ///
    /// - Parameter revision: the revision number of record
    public func setRevision(_ revision: Int) {
        self.revision = revision
    }

}
