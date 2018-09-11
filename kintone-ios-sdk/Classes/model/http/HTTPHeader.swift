//
//  HTTPHeader.swift
//  kintone-ios-sdk
//
//  Created by t000572 on 2018/09/05.
//  Copyright © 2018年 y001112. All rights reserved.
//


public class HTTPHeader: NSObject {

    private var key: String?
    private var value: String?

    init(_ key: String?, _ value: String?) {
        self.key = key
        self.value = value
    }

    /// get key of the authentication
    ///
    /// - Returns: key of the authentication
    public func getKey() -> String? {
        return self.key
    }

    /// get value of the authentication
    ///
    /// - Returns: value of the authentication
    public func getValue() -> String? {
        return self.value
    }
}
