// Copyright (c) 2018 Cybozu, Inc.

open class GetAppDeployStatusResponse: NSObject, Codable {
    private var apps: Array<AppDeployStatus>?
    
    open func getApps() -> Array<AppDeployStatus>? {
        return self.apps
    }
    open func setApps(apps: Array<AppDeployStatus>?) {
        self.apps = apps
    }
}
