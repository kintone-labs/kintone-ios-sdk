//
//  AppApp.swift
//  kintone-ios-sdk
//
//  Created by trung-doan on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

protocol AppApp {
    func getApp(_ appId: Int?) throws -> AppModel
}

extension AppApp where Self: App {
    func getApp(_ appId: Int?) throws -> AppModel {
        do {
            let getAppRequest = GetAppRequest(appId)
            let body = try! parser.parseObject(getAppRequest)
            let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
            let response = try! self.connection?.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody)
            return try parser.parseJson(AppModel.self, response as! Data)
        }
    }
}
