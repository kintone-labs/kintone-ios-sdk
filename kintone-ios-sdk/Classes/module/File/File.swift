//
//  File.swift
//  kintone-ios-sdk
//
//  Created by shota-fujiwara on 2018/09/28.
//  Copyright © 2018年 Cybozu. All rights reserved.
//
import Promises

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
                let targetFilePath = URL(string: filePath)!
                let fileData = try Data(contentsOf: targetFilePath)
                self.connection.uploadFile(targetFilePath.lastPathComponent, fileData).then{ response in
                    let parseResponse = try self.parser.parseJson(FileModel.self, response)
                    fulfill(parseResponse)
                }
            } catch let error as KintoneAPIException {
                reject(error)
            } catch {
                reject(KintoneAPIException(error.localizedDescription))
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
            } catch let error as KintoneAPIException {
                reject(error)
            } catch {
                reject(KintoneAPIException(error.localizedDescription))
            }
        }
    }
    
}

