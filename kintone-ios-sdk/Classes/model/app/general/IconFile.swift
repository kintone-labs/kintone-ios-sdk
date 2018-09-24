//
//  IconFile.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

class IconFile: NSObject, Codable {
    private var fileKey: String?
    private var contentType: String?
    private var name: String?
    private var size: String?
    
    public func getFileKey() -> String? {
        return self.fileKey
    }
    public func setFileKey(_ fileKey: String?) {
        self.fileKey = fileKey
    }
    
    public init(_ fileKey: String?) {
        self.fileKey = fileKey
    }
    public func getContentType() -> String? {
        return self.contentType
    }
    public func setContentType(_ contentType: String?) {
        self.contentType = contentType
    }
    public func getName() -> String? {
        return self.name
    }
    public func setName(_ name: String?) {
        self.name = name
    }
    public func getSize() -> String? {
        return self.size
    }
    public func setSize(_ size: String?) {
        self.size = size
    }
    
    public init(_ fileKey: String?, _ contentType: String?, _ name: String?, _ size: String?) {
        self.fileKey = fileKey
        self.contentType = contentType
        self.name = name
        self.size = size
    }
}
