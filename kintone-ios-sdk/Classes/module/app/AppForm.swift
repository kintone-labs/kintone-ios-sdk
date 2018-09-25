//
//  AppForm.swift
//  kintone-ios-sdk
//
//  Created by trung-doan on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

protocol AppForm {
     func getFormFields(_ app: Int?, _ lang: LanguageSetting?,_ isPreview: Bool?) throws -> FormFields
     func getFormLayout(_ app: Int?, _ isPreview: Bool?) throws -> FormLayout
     //func updateFormLayout(_ app: Int?, _ layout: [ItemLayout]?,_ revision: Int?) throws -> BasicResponse
}

extension AppForm where Self: App {
    func getFormFields(_ app: Int?, _ lang: LanguageSetting?,_ isPreview: Bool? = false) throws -> FormFields
    {
        do {
            let getFormFieldsRequest = GetFormFieldsRequest(app!, lang!)
            let body = try! self.parser.parseObject(getFormFieldsRequest)
            let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
            let url = (isPreview! ? ConnectionConstants.APP_FIELDS_PREVIEW : ConnectionConstants.APP_FIELDS)
            let response = try self.connection?.request(ConnectionConstants.GET_REQUEST, url, jsonBody)
            return try self.parser.parseJson(FormFields.self, response!)
        } catch let error as KintoneAPIException {
            throw error
        }
    }
    
    func getFormLayout(_ app: Int?, _ isPreview: Bool?) throws -> FormLayout
    {
        do {
            let getFormLayoutRequest = GetFormLayoutRequest(app!)
            let body = try! self.parser.parseObject(getFormLayoutRequest)
            let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
            let response = try self.connection?.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP_LAYOUT, jsonBody)
            return try self.parser.parseJson(FormLayout.self, response!)
        } catch let error as KintoneAPIException {
            throw error
        }
    }
}
