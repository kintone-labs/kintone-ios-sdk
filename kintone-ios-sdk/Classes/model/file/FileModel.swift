//
//  FileModel.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/10.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

import UIKit

public class FileModel: NSObject, Codable {
    
    private var contentType: String?
    private var fileKey: String?
    private var name: String?
    private var size: String?

    public func getContentType() -> String? {
        return self.contentType
    }
    public func setContentType(_ contentType: String) {
        self.contentType = contentType
    }
    
    public func getFileKey() -> String? {
        return self.fileKey
    }
    public func setFileKey(_ fileKey: String) {
        self.fileKey = fileKey
    }

    public func getName() -> String? {
        return self.name
    }
    public func setName(_ name: String) {
        self.name = name
    }

    public func getSize() -> String? {
        return self.size
    }
    func setSize(_ size: String) {
        self.size = size
    }
    
}
