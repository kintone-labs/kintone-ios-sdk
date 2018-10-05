//
//  AddRecordsResponse.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/12.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

public class AddRecordsResponse: NSObject, Codable {
    
    private var ids: [Int]?
    private var revisions: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case ids
        case revisions
    }
    
    public override init() {
    }
    
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
    public func getRevisions() -> [Int]? {
        return self.revisions
    }
    
    public func setRevisions(_ revisions: [Int]) {
        self.revisions = revisions
    }
    
    public required init(from decoder: Decoder) throws {
        do {
            let parser = RecordParser()
            let response = try parser.parseForAddRecordsResponse(decoder)
            self.ids = response.getIDs()
            self.revisions = response.getRevisions()
        }
    }

}
