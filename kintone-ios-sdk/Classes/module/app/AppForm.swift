// Copyright (c) 2018 Cybozu, Inc.

public protocol AppForm {
    
    /// Gets the list of fields and field settings of an App.
    ///
    /// - Parameters:
    ///   - app: Int | The App ID.
    ///   - lang: LanguageSetting | The localized language to retrieve the data in
    ///   - isPreview: isPreview
    /// - Returns: FormFields Model
    /// - Throws: throws KintoneAPIException
    func getFormFields(_ app: Int?, _ lang: LanguageSetting?,_ isPreview: Bool?) throws -> FormFields
    
    /// Adds fields to a form of an App.
    /// This API updates the pre-live settings.
    ///
    /// - Parameters:
    ///   - app: Int | The App ID.
    ///   - fields: [String: Field] | An object with data of the field settings.
    ///   - revision: Int | The revision number of the settings that will be deployed
    /// - Returns: BasicResponse Model
    /// - Throws: throws KintoneAPIException
    func addFormFields(_ app: Int?, _ fields: [String: Field]?,_ revision: Int?) throws -> BasicResponse
    
    /// Updates the field settings of fields in a form of an App.
    /// This API updates the pre-live settings.
    ///
    /// - Parameters:
    ///   - app: Int | The App ID.
    ///   - fields: [String: Field] | An object with data of the field settings for update.
    ///   - revision: Int | The revision number of the settings that will be deployed
    /// - Returns: BasicResponse Model
    /// - Throws: throws KintoneAPIException
    func updateFormFields(_ app: Int?, _ fields: [String: Field]?,_ revision: Int?) throws -> BasicResponse
    
    /// Deletes fields from a form of an App.
    /// This API updates the pre-live settings.
    ///
    /// - Parameters:
    ///   - app:  Int | The App ID.
    ///   - fields: [String] | The list of field codes of the fields to delete.
    ///   - revision: Int | The revision number of the settings that will be deployed
    /// - Returns: BasicResponse Model
    /// - Throws: throws KintoneAPIException
    func deleteFormFields(_ app: Int?, _ fields: [String]?,_ revision: Int?) throws -> BasicResponse
    
    /// Gets the field layout info of a form in an App.
    ///
    /// - Parameters:
    ///   - app: Int | The App ID.
    ///   - isPreview: isPreview description
    /// - Returns: FormLayout Model
    /// - Throws: throws KintoneAPIException
    func getFormLayout(_ app: Int?, _ isPreview: Bool?) throws -> FormLayout
    
    /// Updates the field layout info of a form in an App.
    /// This API updates the pre-live settings.
    ///
    /// - Parameters:
    ///   - app:  Int | The App ID.
    ///   - layout: [ItemLayout] | A list of field layouts for each row.
    ///   - revision: Int | The revision number of the settings that will be deployed
    /// - Returns: BasicResponse Model
    /// - Throws: throws KintoneAPIException
    func updateFormLayout(_ app: Int?, _ layout: [ItemLayout]?,_ revision: Int?) throws -> BasicResponse
}

public extension AppForm where Self: App {
    func getFormFields(_ app: Int?, _ lang: LanguageSetting?,_ isPreview: Bool? = false) throws -> FormFields
    {
        do {
            let getFormFieldsRequest = GetFormFieldsRequest(app!, lang!)
            let body = try self.parser.parseObject(getFormFieldsRequest)
            let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
            let url = (isPreview! ? ConnectionConstants.APP_FIELDS_PREVIEW : ConnectionConstants.APP_FIELDS)
            let response = try self.connection?.request(ConnectionConstants.GET_REQUEST, url, jsonBody)
            return try self.parser.parseJson(FormFields.self, response!)
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    func addFormFields(_ app: Int?, _ fields: [String: Field]?,_ revision: Int? = -1) throws -> BasicResponse
    {
        do {
            let addFormFieldsRequest = AddUpdateFormFieldsRequest(app, fields, revision)
            let body = try self.parser.parseObject(addFormFieldsRequest)
            let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
            let url = ConnectionConstants.APP_FIELDS_PREVIEW
            let response = try self.connection?.request(ConnectionConstants.POST_REQUEST, url, jsonBody)
            let basicResponse = try parser.parseJson(BasicResponse.self, response!)
            return basicResponse
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    func updateFormFields(_ app: Int?, _ fields: [String: Field]?,_ revision: Int? = -1) throws -> BasicResponse
    {
        do {
            let updateFormFields = AddUpdateFormFieldsRequest(app, fields, revision)
            let body = try self.parser.parseObject(updateFormFields)
            let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
            let url = ConnectionConstants.APP_FIELDS_PREVIEW
            let response = try self.connection?.request(ConnectionConstants.PUT_REQUEST, url, jsonBody)
            let basicResponse = try parser.parseJson(BasicResponse.self, response!)
            return basicResponse
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    func deleteFormFields(_ app: Int?, _ fields: [String]?,_ revision: Int? = -1) throws -> BasicResponse
    {
        do {
            let deleteFormFields = DeleteFormFieldsRequest(app, fields, revision)
            let body = try self.parser.parseObject(deleteFormFields)
            let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
            let url = ConnectionConstants.APP_FIELDS_PREVIEW
            let response = try self.connection?.request(ConnectionConstants.DELETE_REQUEST, url, jsonBody)
            let basicResponse = try parser.parseJson(BasicResponse.self, response!)
            return basicResponse
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    func getFormLayout(_ app: Int?, _ isPreview: Bool? = false) throws -> FormLayout
    {
        do {
            let getFormLayoutRequest = GetFormLayoutRequest(app!)
            let body = try self.parser.parseObject(getFormLayoutRequest)
            let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
            let url = (isPreview! ? ConnectionConstants.APP_LAYOUT_PREVIEW : ConnectionConstants.APP_LAYOUT)
            let response = try self.connection?.request(ConnectionConstants.GET_REQUEST, url, jsonBody)
            return try self.parser.parseJson(FormLayout.self, response!)
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
    
    func updateFormLayout(_ app: Int?, _ layout: [ItemLayout]?,  _ revision: Int? = -1) throws -> BasicResponse
    {
        do {
            let updateFormLayoutRequest = UpdateFormLayoutRequest(app!, layout!, revision!)
            let body = try parser.parseObject(updateFormLayoutRequest)
            let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
            let response = try self.connection?.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.APP_LAYOUT_PREVIEW, jsonBody)
            let basicResponse = try parser.parseJson(BasicResponse.self, response!)
            return basicResponse
        } catch let error as KintoneAPIException {
            throw error
        } catch {
            throw KintoneAPIException(error.localizedDescription)
        }
    }
}
