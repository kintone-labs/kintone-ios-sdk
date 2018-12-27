//
//  DownloadRequest.swift
//  kintone-ios-sdk
//
//  Created by shota-fujiwara on 2018/10/02.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

open class DownloadRequest: NSObject, Codable {
    private var fileKey: String
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - filekey
    public init(_ filekey: String){
     self.fileKey = filekey
    }
    
}
