//
//  GetAppDeployStatusRequest.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/24/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class GetAppDeployStatusRequest: NSObject, Codable {
    private var apps: [Int]?
    
    public func getApps() -> [Int]? {
        return self.apps
    }
    public func setApps(_ apps: [Int]) {
        self.apps = apps
    }
    
    init(_ apps: [Int]?) {
        self.apps = apps
    }
}
