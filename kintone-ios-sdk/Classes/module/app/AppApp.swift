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
    private func _getAppsBy(ids idsOpt: [Int]? = nil, codes codesOpt: [String]? = nil, name nameOpt: String? = nil, spaceIds spaceIdsOpt: [Int]? = nil, offset offsetOpt: Int? = 0, limit limitOpt: Int? = 100) throws -> Array<AppModel> {
        let getAppsRequest = GetAppsRequest(ids: idsOpt, codes: codesOpt, name: nameOpt, spaceIds:spaceIdsOpt, offset: offsetOpt, limit: limitOpt)
        let body = try! parser.parseObject(getAppsRequest)
        let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
        let response = try! self.connection?.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APPS, jsonBody)
        let apps = try parser.parseJson(GetAppsResponse.self, response!)
        return apps.getApps()!
    }
    
    func getApp(_ appId: Int?) throws -> AppModel {
        do {
            let getAppRequest = GetAppRequest(appId)
            let body = try! parser.parseObject(getAppRequest)
            let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
            let response = try! self.connection?.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody)
            return try parser.parseJson(AppModel.self, response!)
        }
    }
    
    func getApps(_ offset: Int? = 0, _ limit: Int? = 100) throws -> Array<AppModel> {
        do {
            return try _getAppsBy(offset: offset, limit: limit)
        }
    }
    
    func getAppsByIDs(_ ids: [Int]?, _ offset: Int? = 0, _ limit: Int? = 100) throws -> Array<AppModel> {
        do {
            return try _getAppsBy(ids: ids, offset: offset, limit: limit)
        }
    }
    
    func getAppsByCodes(_ codes: [String]?, _ offset: Int? = 0, _ limit: Int? = 100) throws -> Array<AppModel> {
        do {
            return try _getAppsBy(codes: codes, offset: offset, limit: limit)
        }
    }
    
    func getAppsByName(_ name: String?, _ offset: Int? = 0, _ limit: Int? = 100) throws -> Array<AppModel> {
        do {
            return try _getAppsBy(name: name, offset: offset, limit: limit)
        }
    }
    
    func getAppsBySpaceIDs(_ spaceIds: [Int]?, _ offset: Int? = 0, _ limit: Int? = 100) throws -> Array<AppModel> {
        do {
            return try _getAppsBy(spaceIds: spaceIds, offset: offset, limit: limit)
        }
    }
}
