//
//  GetFormLayoutRequest.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

class GetFormLayoutRequest: NSObject {
    private var app: Int?
    
    public func getApp() -> Int? {
        return self.app
    }
    public func setApp(_ app: Int) {
        self.app = app
    }
    
    public init(_ app: Int) {
        self.app = app
    }
}
