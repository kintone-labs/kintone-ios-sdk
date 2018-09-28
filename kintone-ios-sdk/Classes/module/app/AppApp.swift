// Copyright (c) 2018 Cybozu, Inc.

public protocol AppApp {
    
    /// Gets general information of an App, including the name, description, related Space, creator and updater information.
    ///
    /// - Parameter appId: Int | The App ID.
    /// - Returns: AppModel Model
    /// - Throws: throws KintoneAPIException
    func getApp(_ appId: Int?) throws -> AppModel
    
    /// Gets general information of multiple Apps
    ///
    /// - Parameters:
    ///   - offset: Int | The number of retrievals that will be skipped
    ///   - limit: Int | The number of Apps to retrieve.
    /// - Returns: Array<AppModel>
    /// - Throws: throws KintoneAPIException
    func getApps(_ offset: Int?, _ limit: Int?) throws -> Array<AppModel>
    
    /// Gets general information of multiple Apps by Array Ids
    ///
    /// - Parameters:
    ///   - ids: [Int] | The App IDs. Up to 100 IDs can be specified.
    ///   - offset: Int | The number of retrievals that will be skipped
    ///   - limit: Int | The number of Apps to retrieve.
    /// - Returns: Array<AppModel>
    /// - Throws: throws KintoneAPIException
    func getAppsByIDs(_ ids: [Int]?, _ offset: Int?, _ limit: Int?) throws -> Array<AppModel>
    
    /// Gets general information of multiple Apps by Array App Code
    ///
    /// - Parameters:
    ///   - codes: The App Code. Up to 100 App Codes can be specified.
    ///   - offset: Int | The number of retrievals that will be skipped
    ///   - limit: Int | The number of Apps to retrieve.
    /// - Returns: Array<AppModel>
    /// - Throws: throws KintoneAPIException
    func getAppsByCodes(_ codes: [String]?, _ offset: Int?, _ limit: Int?) throws -> Array<AppModel>
    
    /// Gets general information of multiple Apps by App Name
    ///
    /// - Parameters:
    ///   - name: String | The App Name.
    ///   - offset: Int | The number of retrievals that will be skipped
    ///   - limit: Int | The number of Apps to retrieve.
    /// - Returns: Array<AppModel>
    /// - Throws: throws KintoneAPIException
    func getAppsByName(_ name: String?, _ offset: Int?, _ limit: Int?) throws -> Array<AppModel>
    
    /// Gets general information of multiple Apps by Array Space Ids
    ///
    /// - Parameters:
    ///   - spaceIds: [Int] | The Space ID of where the App resides in. Up to 100 IDs can be specified.
    ///   - offset: Int | The number of retrievals that will be skipped
    ///   - limit: Int | The number of Apps to retrieve.
    /// - Returns: Array<AppModel>
    /// - Throws: throws KintoneAPIException
    func getAppsBySpaceIDs(_ spaceIds: [Int]?, _ offset: Int?, _ limit: Int?) throws -> Array<AppModel>
    
    /// Creates a preview App. The Deploy App Settings API must be used on the created preview App for the App to become live.
    ///
    /// - Parameters:
    ///   - name: String | The App name.
    ///   - space: Int | The Space ID of where the App will be created
    ///   - thread: Int | The Thread ID of the thread in the Space where the App will be created.
    /// - Returns: AddPreviewAppResponse Model
    /// - Throws: throws KintoneAPIException
    func addPreviewApp(_ name: String?, _ space: Int?, _ thread: Int?) throws -> AddPreviewAppResponse
    
    /// Updates the settings of a pre-live App to the live App.
    ///
    /// - Parameters:
    ///   - apps: [AddPreviewAppResponse] | The list of Apps to deploy the pre-live settings to the live Apps
    ///   - revert: Bool | The pre-live settings will be reverted back to the current settings of the live app.
    /// - Returns: none
    /// - Throws: throws KintoneAPIException
    func deployAppSettings(_ apps: Array<AddPreviewAppResponse>?, _ revert: Bool?) throws
    
    /// Gets the deployment status of the App settings for multiple Apps.
    ///
    /// - Parameter apps: [Int] | The list of Apps
    /// - Returns: GetAppDeployStatusResponse Model
    /// - Throws: throws KintoneAPIException
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
