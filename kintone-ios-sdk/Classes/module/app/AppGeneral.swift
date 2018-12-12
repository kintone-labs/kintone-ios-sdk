// Copyright (c) 2018 Cybozu, Inc.
import Promises
public protocol AppGeneral {
    
    /// Gets the description, name, icon, revision and color theme of an App.
    ///
    /// - Parameters:
    ///   - app: Int | The app ID.
    ///   - lang: LanguageSetting | The localized language to retrieve the data
    ///   - isPreview: isPreview description
    /// - Returns: GeneralSettings Model
    /// - Throws: throws KintoneAPIException
    func getGeneralSettings(_ app: Int?, _ lang: LanguageSetting?, _ isPreview: Bool?) -> Promise<GeneralSettings>
    
    /// Updates the description, name, icon, revision and color theme of an App.
    ///
    /// - Parameters:
    ///   - app: Int | The app ID.
    ///   - generalSettings: GeneralSettings | It will set the description, name, icon, revision and color theme of an App
    ///   - revision: Int | Specify the revision number of the settings that will be deployed.
    /// - Returns: BasicResponse Model
    /// - Throws: throws KintoneAPIException
    func updateGeneralSettings(_ app: Int?, _ generalSettings: GeneralSettings?) -> Promise<BasicResponse>
}

public extension AppGeneral where Self: App {
    func getGeneralSettings(_ app: Int?, _ lang: LanguageSetting? = nil, _ isPreview: Bool? = false) -> Promise<GeneralSettings> {
        return Promise { fulfill, reject in
            do {
                let getGeneralSettingsRequest = GetGeneralSettingsRequest(app, lang ?? LanguageSetting.DEFAULT)
                let body = try self.parser.parseObject(getGeneralSettingsRequest)
                let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
                let url = (isPreview! ? ConnectionConstants.APP_SETTINGS_PREVIEW : ConnectionConstants.APP_SETTINGS)
                self.connection?.request(ConnectionConstants.GET_REQUEST, url, jsonBody).then{ response in
                    let generalSettings = try self.parser.parseJson(GeneralSettings.self, response)
                    fulfill(generalSettings)
                    }.catch{ error in
                        reject(error)
                }
            } catch {
                reject(error)
            }
        }
    }
    
    func updateGeneralSettings(_ app: Int?, _ generalSettings: GeneralSettings?) -> Promise<BasicResponse> {
        return Promise { fulfill, reject in
            do {
                let updateGeneralSettingsRequest = UpdateGeneralSettingsRequest(generalSettings)
                updateGeneralSettingsRequest.setApp(app)
                let body = try self.parser.parseObject(updateGeneralSettingsRequest)
                let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
                self.connection?.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.APP_SETTINGS_PREVIEW, jsonBody).then{ response in
                    let basicResponse = try self.parser.parseJson(BasicResponse.self, response)
                    fulfill(basicResponse)
                    }.catch{ error in
                        reject(error)
                }
            } catch {
                reject(error)
            }
        }
    }
}
