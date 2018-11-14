//
//  UpdateRecordResponse.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/12.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

open class UpdateRecordResponse: NSObject, Codable {
    
    private var revision: Int?
    
    enum CodingKeys: String, CodingKey {
        case revision
    }
    
    public override init() {
    }

    /// get the number of revision
    ///
    /// - Returns: the number of revision
    open func getRevision() -> Int? {
        return self.revision;
    }

    /// sdt the number of revision
    ///
    /// - Parameter revision: the number of revision
    open func setRevision(_ revision: Int?) {
        self.revision = revision;
    }
    
    public required init(from decoder: Decoder) throws {
        do {
            let parser = RecordParser()
            let response = try parser.parseForUpdateRecordResponse(decoder)
            self.revision = response.getRevision()
        }
    }
    
}
