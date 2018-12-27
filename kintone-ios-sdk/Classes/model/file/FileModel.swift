//
//  FileModel.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/10.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

open class FileModel: NSObject, Codable {
    
    private var contentType: String?
    private var fileKey: String?
    private var name: String?
    private var size: String?

    open func getContentType() -> String? {
        return self.contentType
    }
    open func setContentType(_ contentType: String) {
        self.contentType = contentType
    }
    
    open func getFileKey() -> String? {
        return self.fileKey
    }
    open func setFileKey(_ fileKey: String) {
        self.fileKey = fileKey
    }

    open func getName() -> String? {
        return self.name
    }
    open func setName(_ name: String) {
        self.name = name
    }

    open func getSize() -> String? {
        return self.size
    }
    open func setSize(_ size: String) {
        self.size = size
    }
    
}
