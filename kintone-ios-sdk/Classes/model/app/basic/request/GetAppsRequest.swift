//
//  GetAppsRequest.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/18/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class GetAppsRequest: NSObject {
    private var ids: [Int]?
    private var codes: [Int]?
    private var name: String?
    private var spaceIds: [Int]?
    private var offset: Int?
    private var limit: Int?
    
    public func getIds() -> [Int]? {
        return self.ids
    }
    public func setId(_ ids: [Int]) {
        self.ids = ids
    }
    public func getCodes() -> [Int]? {
        return self.codes
    }
    public func setCodes(_ codes: [Int]) {
        self.codes = codes
    }
    public func getName() -> String? {
        return self.name
    }
    public func setName(_ name: String) {
        self.name = name
    }
    public func getSpaceIds() -> [Int]? {
        return self.spaceIds
    }
    public func setSpaceIds(_ spaceIds: [Int]) {
        self.spaceIds = spaceIds
    }
    public func getOffset() -> Int? {
        return self.offset
    }
    public func setOffset(_ offset: Int) {
        self.offset = offset
    }
    public func getLimit() -> Int? {
        return self.limit
    }
    public func setLimit(_ limit: Int) {
        self.limit = limit
    }
    
    public init(_ ids: [Int], _ codes: [Int], _ name: String, _ spaceIds: [Int], _ offset: Int, _ limit: Int) {
        self.ids = ids
        self.codes = codes
        self.name = name
        self.spaceIds = spaceIds
        self.offset = offset
        self.limit = limit
    }
}
