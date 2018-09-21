//
//  Member.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/07.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

public class Member: NSObject, Codable {
    
    public var code: String?
    public var name: String?
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - code: the user/group/organization code
    ///   - name: the user/group/organization name
    public init(_ code: String?, _ name: String?) {
        self.code = code
        self.name = name
    }
}
