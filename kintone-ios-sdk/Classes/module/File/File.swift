//
//  File.swift
//  kintone-ios-sdk
//
//  Created by shota-fujiwara on 2018/09/28.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

class File: NSObject{
    private var connection: Connection
    private let parser = Parser()
    
    /// Constructor
    ///
    /// - Parameter connection: connection
    public init(_ connection: Connection){
        self.connection = connection
    }
    
    /// Upload file on kintone
    ///
    /// - Parameters:
    ///   - filePath
    /// - Returns:
    /// - Throws: KintoneAPIException
    public func upload(_ filePath: String) throws -> FileModel {
        do{
        let response = try self.connection.uploadFile(filePath, )
        return try self.parser.parseJson(FileModel.self, response)
        }
    }
    
    /// Download file on kintone
    ///
    /// - Parameters:
    ///   - filekey
    ///   - filePath
    /// - Returns:
    /// - Throws: KintoneAPIException
    public func download(_ filekey: String, _ outPutFilePath: String) throws {
        do{
        let request = DownloadRequest(filekey)
        let body = try self.parser.parseObject(request)
        let jsonBody = String(data: body, encoding: .utf8)
            try self.connection.downloadFile(jsonBody!)
        }
    }
    
}

