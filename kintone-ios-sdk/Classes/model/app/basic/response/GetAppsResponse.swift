// Copyright (c) 2018 Cybozu, Inc.

public class GetAppsResponse: NSObject, Codable {
    private var apps: Array<AppModel>?
    
    public func getApps() -> Array<AppModel>? {
        return self.apps
    }
    public func setApps(_ apps: Array<AppModel>?) {
        self.apps = apps
    }
}
