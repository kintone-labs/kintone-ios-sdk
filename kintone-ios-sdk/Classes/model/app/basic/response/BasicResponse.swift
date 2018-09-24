//
//  BasicResponse.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

class BasicResponse: NSObject, Codable {
    private var revision: Int?
    
    public func getRevision() -> Int? {
        return self.revision
    }
    public func setRevision(_ revision: Int?) {
        self.revision = revision
    }
    
    public init(_ revision: Int?) {
        self.revision = revision
    }
}
