//
//  AppView.swift
//  kintone-ios-sdk
//
//  Created by trung-doan on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public protocol AppView {
    func getViews(_ app: Int?, _ lang: LanguageSetting?,_ isPreview: Bool?) throws -> GetViewsResponse
    func updateViews(_ app: Int?, _ lang: [String: ViewModel],_ revision: Int?) throws -> UpdateViewsResponse
}

public extension AppView where Self: App {
    func getViews(_ app: Int?, _ lang: LanguageSetting?,_ isPreview: Bool?) throws -> GetViewsResponse {
        do {
            let getViewsRequest = GetViewsRequest(app!, lang!)
            let body = try! self.parser.parseObject(getViewsRequest)
            let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
            let apiName = isPreview ?? false ? ConnectionConstants.APP_VIEWS : ConnectionConstants.APP_VIEWS_PREVIEW

            let response = try self.connection?.request(ConnectionConstants.GET_REQUEST, apiName, jsonBody)
            return try self.parser.parseJson(GetViewsResponse.self, response!)
        } catch let error as KintoneAPIException {
            throw error
        }
    }
    
    func updateViews(_ app: Int?, _ views: [String: ViewModel],_ revision: Int?) throws -> UpdateViewsResponse {
        do {
            let updateViewsRequest = UpdateViewsRequest(app!, views, revision ?? -1)
            let body = try! self.parser.parseObject(updateViewsRequest)
            let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
            let response = try self.connection?.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.APP_VIEWS_PREVIEW, jsonBody)
            return try self.parser.parseJson(UpdateViewsResponse.self, response!)
        } catch let error as KintoneAPIException {
            throw error
        }
    }
}
