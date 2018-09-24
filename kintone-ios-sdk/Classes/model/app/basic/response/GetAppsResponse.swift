//
//  AppsModel.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/21/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

class GetAppsResponse: NSObject, Codable {
    private var apps: Array<AppModel>?
    
    public func getApps() -> Array<AppModel>? {
        return self.apps
    }
    public func setApps(_ apps: Array<AppModel>?) {
        self.apps = apps
    }
}
