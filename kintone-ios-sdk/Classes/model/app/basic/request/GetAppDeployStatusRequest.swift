// Copyright (c) 2018 Cybozu, Inc.

open class GetAppDeployStatusRequest: NSObject, Codable {
    private var apps: [Int]
    
    open func getApps() -> [Int] {
        return self.apps
    }
    open func setApps(_ apps: [Int]) {
        self.apps = apps
    }
    
    init(_ apps: [Int]) {
        self.apps = apps
    }
}
