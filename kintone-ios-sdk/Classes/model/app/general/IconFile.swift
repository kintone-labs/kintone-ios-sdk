//
//  IconFile.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

class IconFile: NSObject {
    private var fileKey: String?
    
    public func getFileKey() -> String? {
        return self.fileKey
    }
    public func setFileKey(_ fileKey: String) {
        self.fileKey = fileKey
    }
    
    public init(_ fileKey: String) {
        self.fileKey = fileKey
    }
}
