//
//  baseParser.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/18.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

public class Parser: NSObject {
    
    public func parseObject<T>(_ data: T) throws -> Data where T : Encodable {
        do {
            return try JSONEncoder().encode(data)
        } catch  {
            throw KintoneAPIException("parse error")
        }
    }
    
    public func parseJson<T>(_ type: T.Type, _ data: Data) throws -> T where T : Decodable {
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            throw KintoneAPIException("parse error")
        }
    }
    
}
