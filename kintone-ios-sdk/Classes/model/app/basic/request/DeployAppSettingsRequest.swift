//
//  DeployAppSettingsRequest.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class DeployAppSettingsRequest: NSObject, Codable {
    private var apps: Array<AddPreviewAppResponse>? = []
    private var revert: Bool?
    
    public func getApps() -> Array<AddPreviewAppResponse>? {
        return self.apps
    }
    public func setApps(_ apps: Array<AddPreviewAppResponse>) {
        self.apps = apps
    }
    public func getRevert() -> Bool? {
        return self.revert
    }
    public func setRevert(_ revert: Bool) {
        self.revert = revert
    }
    
    public init(_ apps: Array<AddPreviewAppResponse>?, _ revert: Bool? = nil) {
        self.apps = apps
        self.revert = revert
    }
}
