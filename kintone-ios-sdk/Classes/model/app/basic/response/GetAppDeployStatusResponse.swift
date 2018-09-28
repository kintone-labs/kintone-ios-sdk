// Copyright (c) 2018 Cybozu, Inc.

public class GetAppDeployStatusResponse: NSObject, Codable {
    private var apps: Array<AppDeployStatus>?
    
    public func getApps() -> Array<AppDeployStatus>? {
        return self.apps
    }
    public func setApps(apps: Array<AppDeployStatus>?) {
        self.apps = apps
    }
}
