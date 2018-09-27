//
//  AppForm.swift
//  kintone-ios-sdk
//
//  Created by trung-doan on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public protocol AppForm {
    func getFormFields(_ app: Int?, _ lang: LanguageSetting?,_ isPreview: Bool?) throws -> FormFields
    func addFormFields(_ app: Int?, _ fields: [String: Field]?,_ revision: Int?) throws -> BasicResponse
    func updateFormFields(_ app: Int?, _ fields: [String: Field]?,_ revision: Int?) throws -> BasicResponse
    func deleteFormFields(_ app: Int?, _ fields: [String]?,_ revision: Int?) throws -> BasicResponse
    func getFormLayout(_ app: Int?, _ isPreview: Bool?) throws -> FormLayout
    func updateFormLayout(_ app: Int?, _ layout: [ItemLayout]?,_ revision: Int?) throws -> BasicResponse
}

public extension AppForm where Self: App {
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
    
    func addFormFields(_ app: Int?, _ fields: [String: Field]?,_ revision: Int? = -1) throws -> BasicResponse
    {
        do {
            let addFormFieldsRequest = AddUpdateFormFieldsRequest(app, fields, revision)
            let body = try! self.parser.parseObject(addFormFieldsRequest)
            let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
            let url = ConnectionConstants.APP_FIELDS_PREVIEW
            let response = try self.connection?.request(ConnectionConstants.POST_REQUEST, url, jsonBody)
            let basicResponse = try parser.parseJson(BasicResponse.self, response!)
            return basicResponse
        } catch let error as KintoneAPIException {
            throw error
        }
    }
    
    func updateFormFields(_ app: Int?, _ fields: [String: Field]?,_ revision: Int? = -1) throws -> BasicResponse
    {
        do {
            let updateFormFields = AddUpdateFormFieldsRequest(app, fields, revision)
            let body = try! self.parser.parseObject(updateFormFields)
            let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
            let url = ConnectionConstants.APP_FIELDS_PREVIEW
            let response = try self.connection?.request(ConnectionConstants.PUT_REQUEST, url, jsonBody)
            let basicResponse = try parser.parseJson(BasicResponse.self, response!)
            return basicResponse
        } catch let error as KintoneAPIException {
            throw error
        }
    }
    
    func deleteFormFields(_ app: Int?, _ fields: [String]?,_ revision: Int? = -1) throws -> BasicResponse
    {
        do {
            let deleteFormFields = DeleteFormFieldsRequest(app, fields, revision)
            let body = try! self.parser.parseObject(deleteFormFields)
            let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
            let url = ConnectionConstants.APP_FIELDS_PREVIEW
            let response = try self.connection?.request(ConnectionConstants.DELETE_REQUEST, url, jsonBody)
            let basicResponse = try parser.parseJson(BasicResponse.self, response!)
            return basicResponse
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
            
            let url = (isPreview! ? ConnectionConstants.APP_LAYOUT_PREVIEW : ConnectionConstants.APP_LAYOUT)
            let response = try self.connection?.request(ConnectionConstants.GET_REQUEST, url, jsonBody)
            return try self.parser.parseJson(FormLayout.self, response!)
        } catch let error as KintoneAPIException {
            throw error
        }
    }
    
    func updateFormLayout(_ app: Int?, _ layout: [ItemLayout]?,  _ revision: Int? = -1) throws -> BasicResponse
    {
        do {
            let updateFormLayoutRequest = UpdateFormLayoutRequest(app!, layout!, revision!)
            let body = try! parser.parseObject(updateFormLayoutRequest)
            let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
            let response = try! self.connection?.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.APP_LAYOUT_PREVIEW, jsonBody)
            let basicResponse = try parser.parseJson(BasicResponse.self, response!)
            return basicResponse
        } catch let error as KintoneAPIException {
            throw error
        }
    }
}
