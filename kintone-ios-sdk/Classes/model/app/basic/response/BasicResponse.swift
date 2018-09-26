//
//  BasicResponse.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class BasicResponse: NSObject, Codable {
    private var revision: String?
    
    public func getRevision() -> Int? {
        return Int(self.revision!)
    }
    public func setRevision(_ revision: Int?) {
        self.revision = "\(String(describing: revision!))"
    }
    
    public init(_ revision: Int?) {
        super.init()
        self.setRevision(revision)
    }
}
