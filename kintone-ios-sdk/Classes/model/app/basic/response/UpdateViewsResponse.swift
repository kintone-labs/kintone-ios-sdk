//
//  UpdateViewsResponse.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

class UpdateViewsResponse: NSObject, Codable {
    private var revision: String?
    private var views: [String: ViewModel]?
    
    public func getRevision() -> Int? {
        return Int(self.revision!)
    }
    public func setRevision(_ revision: Int?) {
        self.revision = "\(String(describing: revision))"
    }
    
    public func getViews() -> [String: ViewModel]? {
        return self.views
    }
    public func setViews(_ views: [String: ViewModel]?) {
        self.views = views
    }
    
    public init(_ revision: Int?, _ views: [String: ViewModel]?) {
        super.init()
        self.setRevision(revision)
        self.setViews(views)
    }
}
