//
//  File.swift
//  kintone-ios-sdk
//
//  Created by shota-fujiwara on 2018/09/28.
//  Copyright © 2018年 Cybozu. All rights reserved.
//
import Promises
import UIKit

open class File: NSObject{
    private var connection: Connection
    private let parser = Parser()
    
    /// Constructor
    ///
    /// - Parameter connection: connection
    public init(_ connection: Connection){
        self.connection = connection
    }
    
    /// Upload Async file on kintone
    ///
    /// - Parameters:
    ///   - filePath
    /// - Returns:
    /// - Throws: KintoneAPIException
    open func upload(_ filePath: String) -> Promise<FileModel> {
        return Promise { fulfill, reject in
            do {
                var fileData = Data()
                let targetFilePath = URL(string: filePath)!
                if targetFilePath.pathExtension == "png"  {
                    if let pngImage = UIImage(contentsOfFile: targetFilePath.path) {
                        fileData = try UIImagePNGRepresentation(pngImage) ?? Data(contentsOf: targetFilePath)
                    }
                } else {
                    fileData = try Data(contentsOf: targetFilePath)
                }
                self.connection.uploadFile(targetFilePath.lastPathComponent, fileData).then{ response in
                    let parseResponse = try self.parser.parseJson(FileModel.self, response)
                    fulfill(parseResponse)
                    }.catch{ error in
                        reject(error)
                }
            } catch {
                reject(error)
            }
        }
    }
    /// Download Async file on kintone
    ///
    /// - Parameters:
    ///   - filekey
    ///   - filePath
    /// - Returns:
    /// - Throws: KintoneAPIException
    open func download(_ filekey: String, _ outPutFilePath: String) -> Promise<Void> {
        return Promise { fulfill, reject in
            do {
                let request = DownloadRequest(filekey)
                let body = try self.parser.parseObject(request)
                let jsonBody = String(data: body, encoding: .utf8)
                self.connection.downloadFile(jsonBody!).then{ fileData in
                    try fileData.write(to: URL(string: outPutFilePath)!, options: .atomic)
                    fulfill(())
                    }.catch{ error in
                        reject(error)
                }
            } catch {
                reject(error)
            }
        }
    }
    
}

