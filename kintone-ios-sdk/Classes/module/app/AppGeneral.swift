//
//  AppGeneral.swift
//  kintone-ios-sdk
//
//  Created by trung-doan on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

protocol AppGeneral {
    func getGeneralSettings(_ app: Int?, _ lang: LanguageSetting?, _ isPreview: Bool?) throws -> GeneralSettings
    func updateGeneralSettings(_ app: Int?, _ generalSettings: GeneralSettings?, _ revision: Int?) throws -> BasicResponse
}

extension AppGeneral where Self: App {
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
