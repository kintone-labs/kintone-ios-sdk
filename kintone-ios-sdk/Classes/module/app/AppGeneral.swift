//
//  AppGeneral.swift
//  kintone-ios-sdk
//

public protocol AppGeneral {
    
    /// Gets the description, name, icon, revision and color theme of an App.
    ///
    /// - Parameters:
    ///   - app: Int | The app ID.
    ///   - lang: LanguageSetting | The localized language to retrieve the data
    ///   - isPreview: isPreview description
    /// - Returns: GeneralSettings Model
    /// - Throws: throws KintoneAPIException
    func getGeneralSettings(_ app: Int?, _ lang: LanguageSetting?, _ isPreview: Bool?) throws -> GeneralSettings
    
    /// Updates the description, name, icon, revision and color theme of an App.
    ///
    /// - Parameters:
    ///   - app: Int | The app ID.
    ///   - generalSettings: GeneralSettings | It will set the description, name, icon, revision and color theme of an App
    ///   - revision: Int | Specify the revision number of the settings that will be deployed.
    /// - Returns: BasicResponse Model
    /// - Throws: throws KintoneAPIException
    func updateGeneralSettings(_ app: Int?, _ generalSettings: GeneralSettings?, _ revision: Int?) throws -> BasicResponse
}

public extension AppGeneral where Self: App {
    func getGeneralSettings(_ app: Int?, _ lang: LanguageSetting? = nil, _ isPreview: Bool? = false) throws -> GeneralSettings {
        let getGeneralSettingsRequest = GetGeneralSettingsRequest(app)
        let body = try! parser.parseObject(getGeneralSettingsRequest)
        let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
        
        let url = (isPreview! ? ConnectionConstants.APP_SETTINGS_PREVIEW : ConnectionConstants.APP_SETTINGS)
        let response = try! self.connection?.request(ConnectionConstants.GET_REQUEST, url, jsonBody)
        let generalSettings = try parser.parseJson(GeneralSettings.self, response!)
        return generalSettings
    }
    
    func updateGeneralSettings(_ app: Int?, _ generalSettings: GeneralSettings?, _ revision: Int? = -1) throws -> BasicResponse {
        let updateGeneralSettingsRequest = UpdateGeneralSettingsRequest(generalSettings)
        updateGeneralSettingsRequest.setApp(app)
        updateGeneralSettingsRequest.setRevision(revision)
        let body = try! parser.parseObject(updateGeneralSettingsRequest)
        let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
        let response = try! self.connection?.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.APP_SETTINGS_PREVIEW, jsonBody)
        let basicResponse = try parser.parseJson(BasicResponse.self, response!)
        return basicResponse
    }
}
