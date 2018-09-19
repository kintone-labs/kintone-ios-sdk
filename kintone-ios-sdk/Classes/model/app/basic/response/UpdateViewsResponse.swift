//
//  UpdateViewsResponse.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

class UpdateViewsResponse: NSObject {
    private var views: [String: ViewModel]?
    
    public func getViews() -> [String: ViewModel]? {
        return self.views
    }
    public func setViews(_ views: [String: ViewModel]) {
        self.views = views
    }
    
    public init(_ views: [String: ViewModel]) {
        self.views =  views
    }
}
