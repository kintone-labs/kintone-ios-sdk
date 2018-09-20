//
//  App.swift
//  kintone-ios-sdk
//
//  Created by trung-doan on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

class App: NSObject {
    var connection: Connection?
    
    public init(_ connection: Connection?) {
        self.connection = connection;
    }
}

extension App: AppApp {}
extension App: AppCustomization {}
extension App: AppForm {}
extension App: AppGeneral {}
extension App: AppPermission {}
extension App: AppProcessManagement {}
extension App: AppView {}
