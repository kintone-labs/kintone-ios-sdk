//
//  AppView.swift
//  kintone-ios-sdk
//
//  Created by trung-doan on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

protocol AppView {
    func getViews(_ app: Int?, _ lang: LanguageSetting?,_ isPreview: Bool?) throws -> GetViewsResponse
}

extension AppView where Self: App {
    func getViews(_ app: Int?, _ lang: LanguageSetting?,_ isPreview: Bool?) throws -> GetViewsResponse {
        do {
            let viewRequest = GetViewsRequest(app!, lang!)
            let body = try! self.parser.parseObject(viewRequest)
            let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
            let response = try! self.connection?.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP_VIEWS, jsonBody)
            return try self.parser.parseJson(GetViewsResponse.self, response!)
        }
    }
}
