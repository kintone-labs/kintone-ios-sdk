//
//  GetAppDeployStatusResponse.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

class GetAppDeployStatusResponse: NSObject {
    private var apps: Array<AppDeployStatus>?
    
    public func getApps() -> Array<AppDeployStatus>? {
        return self.apps
    }
    public func setApps(apps: Array<AppDeployStatus>) {
        self.apps = apps
    }
}
