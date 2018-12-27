// Copyright (c) 2018 Cybozu, Inc.

open class GetAppsResponse: NSObject, Codable {
    private var apps: Array<AppModel>?
    
    open func getApps() -> Array<AppModel>? {
        return self.apps
    }
    open func setApps(_ apps: Array<AppModel>?) {
        self.apps = apps
    }
}
