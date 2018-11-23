// Copyright (c) 2018 Cybozu, Inc.
import Promises

public protocol AppApp {
    
    /// Gets general information of an App, including the name, description, related Space, creator and updater information.
    ///
    /// - Parameter appId: Int | The App ID.
    /// - Returns: AppModel Model
    /// - Throws: throws KintoneAPIException
    func getApp(_ appId: Int?) -> Promise<AppModel>
    
    /// Gets general information of multiple Apps
    ///
    /// - Parameters:
    ///   - offset: Int | The number of retrievals that will be skipped
    ///   - limit: Int | The number of Apps to retrieve.
    /// - Returns: Array<AppModel>
    /// - Throws: throws KintoneAPIException
    func getApps(_ offset: Int?, _ limit: Int?) -> Promise<Array<AppModel>>
    
    /// Gets general information of multiple Apps by Array Ids
    ///
    /// - Parameters:
    ///   - ids: [Int] | The App IDs. Up to 100 IDs can be specified.
    ///   - offset: Int | The number of retrievals that will be skipped
    ///   - limit: Int | The number of Apps to retrieve.
    /// - Returns: Array<AppModel>
    /// - Throws: throws KintoneAPIException
    func getAppsByIDs(_ ids: [Int]?, _ offset: Int?, _ limit: Int?) -> Promise<Array<AppModel>>
    
    /// Gets general information of multiple Apps by Array App Code
    ///
    /// - Parameters:
    ///   - codes: The App Code. Up to 100 App Codes can be specified.
    ///   - offset: Int | The number of retrievals that will be skipped
    ///   - limit: Int | The number of Apps to retrieve.
    /// - Returns: Array<AppModel>
    /// - Throws: throws KintoneAPIException
    func getAppsByCodes(_ codes: [String]?, _ offset: Int?, _ limit: Int?) -> Promise<Array<AppModel>>
    
    /// Gets general information of multiple Apps by App Name
    ///
    /// - Parameters:
    ///   - name: String | The App Name.
    ///   - offset: Int | The number of retrievals that will be skipped
    ///   - limit: Int | The number of Apps to retrieve.
    /// - Returns: Array<AppModel>
    /// - Throws: throws KintoneAPIException
    func getAppsByName(_ name: String?, _ offset: Int?, _ limit: Int?) -> Promise<Array<AppModel>>
    
    /// Gets general information of multiple Apps by Array Space Ids
    ///
    /// - Parameters:
    ///   - spaceIds: [Int] | The Space ID of where the App resides in. Up to 100 IDs can be specified.
    ///   - offset: Int | The number of retrievals that will be skipped
    ///   - limit: Int | The number of Apps to retrieve.
    /// - Returns: Array<AppModel>
    /// - Throws: throws KintoneAPIException
    func getAppsBySpaceIDs(_ spaceIds: [Int]?, _ offset: Int?, _ limit: Int?) -> Promise<Array<AppModel>>
    
    /// Creates a preview App. The Deploy App Settings API must be used on the created preview App for the App to become live.
    ///
    /// - Parameters:
    ///   - name: String | The App name.
    ///   - space: Int | The Space ID of where the App will be created
    ///   - thread: Int | The Thread ID of the thread in the Space where the App will be created.
    /// - Returns: AddPreviewAppResponse Model
    /// - Throws: throws KintoneAPIException
    func addPreviewApp(_ name: String?, _ space: Int?, _ thread: Int?) -> Promise<PreviewApp>
    
    /// Updates the settings of a pre-live App to the live App.
    ///
    /// - Parameters:
    ///   - apps: [AddPreviewAppResponse] | The list of Apps to deploy the pre-live settings to the live Apps
    ///   - revert: Bool | The pre-live settings will be reverted back to the current settings of the live app.
    /// - Returns: none
    /// - Throws: throws KintoneAPIException
    func deployAppSettings(_ apps: Array<PreviewApp>?, _ revert: Bool?) -> Promise<Void>
    
    /// Gets the deployment status of the App settings for multiple Apps.
    ///
    /// - Parameter apps: [Int] | The list of Apps
    /// - Returns: GetAppDeployStatusResponse Model
    /// - Throws: throws KintoneAPIException
    func getAppDeployStatus(_ apps: [Int]?) -> Promise<GetAppDeployStatusResponse>
}

public extension AppApp where Self: App {
    private func _getAppsBy(ids idsOpt: [Int]? = nil, codes codesOpt: [String]? = nil, name nameOpt: String? = nil, spaceIds spaceIdsOpt: [Int]? = nil, offset offsetOpt: Int? = 0, limit limitOpt: Int? = 100) -> Promise<Array<AppModel>> {
        return Promise { fulfill, reject in
            let getAppsRequest = GetAppsRequest(ids: idsOpt, codes: codesOpt, name: nameOpt, spaceIds:spaceIdsOpt, offset: offsetOpt, limit: limitOpt)
            do {
                let body = try self.parser.parseObject(getAppsRequest)
                let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
                self.connection?.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APPS, jsonBody).then { response in
                    let apps = try self.parser.parseJson(GetAppsResponse.self, response)
                        fulfill(apps.getApps()!)
                    }.catch{ error in
                        reject(error)
                }
            } catch {
                reject(error)
            }
        }
    }
    
    func getApp(_ appId: Int?) -> Promise<AppModel> {
        return Promise { fulfill, reject in
            let getAppRequest = GetAppRequest(appId)
            do {
                let body = try self.parser.parseObject(getAppRequest)
                let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
            self.connection?.request(ConnectionConstants.GET_REQUEST,ConnectionConstants.APP,jsonBody).then { response in
                    let apps = try self.parser.parseJson(AppModel.self, response)
                    fulfill(apps)
                }.catch{ error in
                    reject(error)
                }
            } catch {
                reject(error)
            }
        }
    }
    
    func getApps(_ offset: Int? = 0, _ limit: Int? = 100) -> Promise<Array<AppModel>> {
        return Promise { fulfill, reject in
            self._getAppsBy(offset: offset, limit: limit).then { response in
                fulfill(response)
            }.catch{ error in
                reject(error)
            }
        }
    }
    
    func getAppsByIDs(_ ids: [Int]?, _ offset: Int? = 0, _ limit: Int? = 100) -> Promise<Array<AppModel>> {
        return Promise { fulfill, reject in
            self._getAppsBy(ids: ids, offset: offset, limit: limit).then { response in
                fulfill(response)
                }.catch{ error in
                    reject(error)
            }
        }
    }
    
    func getAppsByCodes(_ codes: [String]?, _ offset: Int? = 0, _ limit: Int? = 100) -> Promise<Array<AppModel>> {
        return Promise { fulfill, reject in
            self._getAppsBy(codes: codes, offset: offset, limit: limit).then { response in
                fulfill(response)
                }.catch{ error in
                    reject(error)
            }
        }
    }
    
    func getAppsByName(_ name: String?, _ offset: Int? = 0, _ limit: Int? = 100) -> Promise<Array<AppModel>> {
        return Promise { fulfill, reject in
            self._getAppsBy(name: name, offset: offset, limit: limit).then { response in
                fulfill(response)
                }.catch{ error in
                    reject(error)
            }
        }
    }
    
    func getAppsBySpaceIDs(_ spaceIds: [Int]?, _ offset: Int? = 0, _ limit: Int? = 100) -> Promise<Array<AppModel>> {
        return Promise { fulfill, reject in
            self._getAppsBy(spaceIds: spaceIds, offset: offset, limit: limit).then { response in
                fulfill(response)
                }.catch{ error in
                    reject(error)
            }
        }
    }
    
    func addPreviewApp(_ name: String?, _ space: Int? = nil, _ thread: Int? = nil) -> Promise<PreviewApp> {
            return Promise { fulfill, reject in
                let addPreviewAppRequest = AddPreviewAppRequest(name: name, space: space, thread: thread)
            do {
                let body = try self.parser.parseObject(addPreviewAppRequest)
                let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
                self.connection?.request(ConnectionConstants.POST_REQUEST, ConnectionConstants.APP_PREVIEW, jsonBody).then{ response in
                    let app = try self.parser.parseJson(PreviewApp.self, response)
                        fulfill(app)
                    }.catch{ error in
                        reject(error)
                }
            } catch let error as KintoneAPIException {
                throw error
            } catch {
                throw KintoneAPIException(error.localizedDescription)
            }
        }
    }
    
    func deployAppSettings(_ apps: Array<PreviewApp>?, _ revert: Bool? = nil) -> Promise<Void>{
        return Promise { fulfill, reject in
            let deployAppSettingsRequest = DeployAppSettingsRequest(apps)
            do {
                let body = try self.parser.parseObject(deployAppSettingsRequest)
                let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
                self.connection?.request(ConnectionConstants.POST_REQUEST, ConnectionConstants.APP_DEPLOY_PREVIEW, jsonBody).then{_ in
                      fulfill(())
                    }
                    .catch{ error in
                    reject(error)
                }
            } catch {
                reject(error)
            }
        }
    }
    
    func getAppDeployStatus(_ apps: [Int]?) -> Promise<GetAppDeployStatusResponse> {
        return Promise { fulfill, reject in
            let deployStatusRequest = GetAppDeployStatusRequest(apps)
            do {
                let body = try self.parser.parseObject(deployStatusRequest)
                let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
                self.connection?.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP_DEPLOY_PREVIEW, jsonBody).then{ response in
                    let status = try self.parser.parseJson(GetAppDeployStatusResponse.self, response)
                    fulfill(status)
                    }.catch{ error in
                        reject(error)
                }
            } catch {
                reject(error)
            }
        }
    }
}
