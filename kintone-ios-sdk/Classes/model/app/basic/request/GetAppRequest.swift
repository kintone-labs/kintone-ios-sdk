//
//  GetAppRequest.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/18/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//
public class GetAppRequest: NSObject, Codable {
    private var id: Int?
    
    public func getId() -> Int? {
        return self.id
    }
    public func setId(id: Int) {
        self.id = id
    }
    
    public init(_ id: Int?) {
        self.id = id
    }
}
