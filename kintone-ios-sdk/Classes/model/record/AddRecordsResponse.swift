//
//  AddRecordsResponse.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/12.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

public class AddRecordsResponse: NSObject, Codable {
    
    private var ids: [Int]?
    // ★★★　revisionsの値としてところどころnilとなるような配列を許容するかを考慮する必要あり
    private var revisions: [Int?]?
    
    /// get the array of record IDs
    ///
    /// - Returns: the array of record IDs
    public func getIDs() -> [Int]? {
        return self.ids
    }
    
    /// set the array of record IDs
    ///
    /// - Parameter ids: the array of record IDs
    public func  setIDs(_ ids: [Int]) {
        self.ids = ids
    }
    
    /// get the array of revision numbers
    ///
    /// - Returns: the array of revision numbers
    public func getRevisions() -> [Int?]? {
        return self.ids
    }
    
    public func setRevisions(_ revisions: [Int?]) {
        self.revisions = revisions
    }

}
