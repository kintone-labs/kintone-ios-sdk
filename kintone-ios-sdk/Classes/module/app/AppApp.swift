//
//  AppApp.swift
//  kintone-ios-sdk
//

public protocol AppApp {
    func getApp(_ appId: Int?) throws -> AppModel
    func getApps(_ offset: Int?, _ limit: Int?) throws -> Array<AppModel>
    func getAppsByIDs(_ ids: [Int]?, _ offset: Int?, _ limit: Int?) throws -> Array<AppModel>
    func getAppsByCodes(_ codes: [String]?, _ offset: Int?, _ limit: Int?) throws -> Array<AppModel>
    func getAppsByName(_ name: String?, _ offset: Int?, _ limit: Int?) throws -> Array<AppModel>
    func getAppsBySpaceIDs(_ spaceIds: [Int]?, _ offset: Int?, _ limit: Int?) throws -> Array<AppModel>
    func addPreviewApp(_ name: String?, _ space: Int?, _ thread: Int?) throws -> AddPreviewAppResponse
    func deployAppSettings(_ apps: Array<AddPreviewAppResponse>?, _ revert: Bool?) throws
    func getAppDeployStatus(_ apps: [Int]?) throws -> GetAppDeployStatusResponse
}

public extension AppApp where Self: App {
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
    
    func addPreviewApp(_ name: String?, _ space: Int? = nil, _ thread: Int? = nil) throws -> AddPreviewAppResponse {
        do {
            let addPreviewAppRequest = AddPreviewAppRequest(name: name, space: space, thread: thread)
            let body = try! parser.parseObject(addPreviewAppRequest)
            let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
            let response = try! self.connection?.request(ConnectionConstants.POST_REQUEST, ConnectionConstants.APP_PREVIEW, jsonBody)
            let app = try parser.parseJson(AddPreviewAppResponse.self, response!)
            return app
        }
    }
    
    func deployAppSettings(_ apps: Array<AddPreviewAppResponse>?, _ revert: Bool? = nil) throws {
        do {
            let deployAppSettingsRequest = DeployAppSettingsRequest(apps)
            let body = try! parser.parseObject(deployAppSettingsRequest)
            let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
            _ = try! self.connection?.request(ConnectionConstants.POST_REQUEST, ConnectionConstants.APP_DEPLOY_PREVIEW, jsonBody)
        }
    }
    
    func getAppDeployStatus(_ apps: [Int]?) throws -> GetAppDeployStatusResponse {
        do {
            let deployStatusRequest = GetAppDeployStatusRequest(apps)
            let body = try! parser.parseObject(deployStatusRequest)
            let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
            let response = try! self.connection?.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP_DEPLOY_PREVIEW, jsonBody)
            let status = try parser.parseJson(GetAppDeployStatusResponse.self, response!)
            return status
        }
    }
}
