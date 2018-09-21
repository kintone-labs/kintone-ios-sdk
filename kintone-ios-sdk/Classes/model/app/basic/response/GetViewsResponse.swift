//
//  GetViewsResponse.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

class GetViewsResponse: NSObject, Codable {
    private var revision: Int?
    private var views: [String: ViewModel]?
    
    public func getRevision() -> Int? {
        return self.revision
    }
    public func setRevision(_ revision: Int) {
        self.revision = revision
    }
    public func getViews() -> [String: ViewModel]? {
        return self.views
    }
    public func setViews(_ views: [String: ViewModel]) {
        self.views = views
    }
    
    public init(_ revision: Int, _ views: [String: ViewModel]) {
        self.revision = revision
        self.views =  views
    }
}
