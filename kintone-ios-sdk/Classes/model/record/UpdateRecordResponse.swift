//
//  UpdateRecordResponse.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/12.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

public class UpdateRecordResponse: NSObject, Codable {
    
    private var revision: Int?

    /// get the number of revision
    ///
    /// - Returns: the number of revision
    public func getRevision() -> Int? {
        return self.revision;
    }

    /// sdt the number of revision
    ///
    /// - Parameter revision: the number of revision
    public func setRevision(_ revision: Int?) {
        self.revision = revision;
    }
}
