//
//  AppGeneral.swift
//  kintone-ios-sdk
//
//  Created by trung-doan on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

protocol AppGeneral {
    func getGeneralSettings(_ app: Int?, lang: LanguageSetting?, _ isPreview: Bool?) throws -> GeneralSettings
    func updateGeneralSettings(_ generalSettings: UpdateGeneralSettings) throws -> BasicResponse
}

extension AppGeneral where Self: App {
    func getGeneralSettings(_ app: Int?, lang: LanguageSetting? = nil, _ isPreview: Bool? = false) throws -> GeneralSettings {
        let getGeneralSettingsRequest = GetGeneralSettings(app)
        let body = try! parser.parseObject(getGeneralSettingsRequest)
        let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
        
        let url = (isPreview! ? ConnectionConstants.APP_SETTINGS_PREVIEW : ConnectionConstants.APP_SETTINGS)
        let response = try! self.connection?.request(ConnectionConstants.GET_REQUEST, url, jsonBody)
        let generalSettings = try parser.parseJson(GeneralSettings.self, response!)
        return generalSettings
    }
    
    func updateGeneralSettings(_ generalSettings: UpdateGeneralSettings) throws -> BasicResponse {
        let body = try! parser.parseObject(generalSettings)
        let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
        let response = try! self.connection?.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.APP_SETTINGS_PREVIEW, jsonBody)
        let basicResponse = try parser.parseJson(BasicResponse.self, response!)
        return basicResponse
    }
}
