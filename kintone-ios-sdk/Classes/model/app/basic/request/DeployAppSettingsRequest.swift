// Copyright (c) 2018 Cybozu, Inc.

open class DeployAppSettingsRequest: NSObject, Codable {
    private var apps: Array<AddPreviewAppResponse>? = []
    private var revert: Bool?
    
    open func getApps() -> Array<AddPreviewAppResponse>? {
        return self.apps
    }
    open func setApps(_ apps: Array<AddPreviewAppResponse>) {
        self.apps = apps
    }
    open func getRevert() -> Bool? {
        return self.revert
    }
    open func setRevert(_ revert: Bool) {
        self.revert = revert
    }
    
    public init(_ apps: Array<AddPreviewAppResponse>?, _ revert: Bool? = nil) {
        self.apps = apps
        self.revert = revert
    }
}
