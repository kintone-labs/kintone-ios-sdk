//
//  UpdateViewsRequest.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

class UpdateViewsRequest: NSObject, Codable {
    private var app: Int?
    private var views: [String: ViewModel]?
    private var revision: Int?
    
    public func getApp() -> Int? {
        return self.app
    }
    public func setApp(_ app: Int) {
        self.app = app
    }
    public func getViews() -> [String: ViewModel]? {
        return self.views
    }
    public func setViews(_ views: [String: ViewModel]) {
        self.views = views
    }
    public func getRevision() -> Int? {
        return self.revision
    }
    public func setRevision(_ revision: Int) {
        self.revision = revision
    }
    
    public init(_ app: Int, _ views: [String: ViewModel],_ revision: Int) {
        super.init()
        self.setApp(app)
        self.setViews(views)
        self.setRevision(revision)
    }
}
