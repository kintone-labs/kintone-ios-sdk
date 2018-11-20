// Copyright (c) 2018 Cybozu, Inc.
import Promises
public protocol AppForm {
    
    /// Gets the list of fields and field settings of an App.
    ///
    /// - Parameters:
    ///   - app: Int | The App ID.
    ///   - lang: LanguageSetting | The localized language to retrieve the data in
    ///   - isPreview: isPreview
    /// - Returns: FormFields Model
    /// - Throws: throws KintoneAPIException
    func getFormFields(_ app: Int?, _ lang: LanguageSetting?,_ isPreview: Bool?) -> Promise<FormFields>
    
    /// Adds fields to a form of an App.
    /// This API updates the pre-live settings.
    ///
    /// - Parameters:
    ///   - app: Int | The App ID.
    ///   - fields: [String: Field] | An object with data of the field settings.
    ///   - revision: Int | The revision number of the settings that will be deployed
    /// - Returns: BasicResponse Model
    /// - Throws: throws KintoneAPIException
    func addFormFields(_ app: Int?, _ fields: [String: Field]?,_ revision: Int?) -> Promise<BasicResponse>
    
    /// Updates the field settings of fields in a form of an App.
    /// This API updates the pre-live settings.
    ///
    /// - Parameters:
    ///   - app: Int | The App ID.
    ///   - fields: [String: Field] | An object with data of the field settings for update.
    ///   - revision: Int | The revision number of the settings that will be deployed
    /// - Returns: BasicResponse Model
    /// - Throws: throws KintoneAPIException
    func updateFormFields(_ app: Int?, _ fields: [String: Field]?,_ revision: Int?) -> Promise<BasicResponse>
    
    /// Deletes fields from a form of an App.
    /// This API updates the pre-live settings.
    ///
    /// - Parameters:
    ///   - app:  Int | The App ID.
    ///   - fields: [String] | The list of field codes of the fields to delete.
    ///   - revision: Int | The revision number of the settings that will be deployed
    /// - Returns: BasicResponse Model
    /// - Throws: throws KintoneAPIException
    func deleteFormFields(_ app: Int?, _ fields: [String]?,_ revision: Int?) -> Promise<BasicResponse>
    
    /// Gets the field layout info of a form in an App.
    ///
    /// - Parameters:
    ///   - app: Int | The App ID.
    ///   - isPreview: isPreview description
    /// - Returns: FormLayout Model
    /// - Throws: throws KintoneAPIException
    func getFormLayout(_ app: Int?, _ isPreview: Bool?) -> Promise<FormLayout>
    
    /// Updates the field layout info of a form in an App.
    /// This API updates the pre-live settings.
    ///
    /// - Parameters:
    ///   - app:  Int | The App ID.
    ///   - layout: [ItemLayout] | A list of field layouts for each row.
    ///   - revision: Int | The revision number of the settings that will be deployed
    /// - Returns: BasicResponse Model
    /// - Throws: throws KintoneAPIException
    func updateFormLayout(_ app: Int?, _ layout: [ItemLayout]?,_ revision: Int?) -> Promise<BasicResponse>
}

public extension AppForm where Self: App {
    func getFormFields(_ app: Int?, _ lang: LanguageSetting?,_ isPreview: Bool? = false) -> Promise<FormFields>
    {
        return Promise{ fulfill, reject in
            do {
                let getFormFieldsRequest = GetFormFieldsRequest(app!, lang!)
                let body = try self.parser.parseObject(getFormFieldsRequest)
                let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
                let url = (isPreview! ? ConnectionConstants.APP_FIELDS_PREVIEW : ConnectionConstants.APP_FIELDS)
                self.connection?.requestAsync(ConnectionConstants.GET_REQUEST, url, jsonBody).then{ response in
                    let parsedResponse = try self.parser.parseJson(FormFields.self, response)
                    fulfill(parsedResponse)
                    }.catch{ error in
                        reject(error)
                }
            } catch {
                reject(error)
            }
        }
    }
    
    func addFormFields(_ app: Int?, _ fields: [String: Field]?,_ revision: Int? = -1) -> Promise<BasicResponse>
    {
        return Promise{ fulfill, reject in
            do {
                let addFormFieldsRequest = AddUpdateFormFieldsRequest(app, fields, revision)
                let body = try self.parser.parseObject(addFormFieldsRequest)
                let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
                let url = ConnectionConstants.APP_FIELDS_PREVIEW
                self.connection?.requestAsync(ConnectionConstants.POST_REQUEST, url, jsonBody).then{ response in
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
    
    func updateFormFields(_ app: Int?, _ fields: [String: Field]?,_ revision: Int? = -1) -> Promise<BasicResponse>
    {
        return Promise{ fulfill, reject in
            do {
                let updateFormFields = AddUpdateFormFieldsRequest(app, fields, revision)
                let body = try self.parser.parseObject(updateFormFields)
                let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
                let url = ConnectionConstants.APP_FIELDS_PREVIEW
                self.connection?.requestAsync(ConnectionConstants.PUT_REQUEST, url, jsonBody).then{ response in
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
    
    func deleteFormFields(_ app: Int?, _ fields: [String]?,_ revision: Int? = -1) -> Promise<BasicResponse>
    {
        return Promise{ fulfill, reject in
            do {
                let deleteFormFields = DeleteFormFieldsRequest(app, fields, revision)
                let body = try self.parser.parseObject(deleteFormFields)
                let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
                let url = ConnectionConstants.APP_FIELDS_PREVIEW
                self.connection?.requestAsync(ConnectionConstants.DELETE_REQUEST, url, jsonBody).then{ response in
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
    
    func getFormLayout(_ app: Int?, _ isPreview: Bool? = false) -> Promise<FormLayout>
    {
        return Promise{ fulfill, reject in
            do {
                let getFormLayoutRequest = GetFormLayoutRequest(app!)
                let body = try self.parser.parseObject(getFormLayoutRequest)
                let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
                let url = (isPreview! ? ConnectionConstants.APP_LAYOUT_PREVIEW : ConnectionConstants.APP_LAYOUT)
                self.connection?.requestAsync(ConnectionConstants.GET_REQUEST, url, jsonBody).then{ response in
                    let parsedResponse = try self.parser.parseJson(FormLayout.self, response)
                    fulfill(parsedResponse)
                    }.catch{ error in
                        reject(error)
                }
            } catch {
                reject(error)
            }
        }
    }
    
    func updateFormLayout(_ app: Int?, _ layout: [ItemLayout]?,  _ revision: Int? = -1) -> Promise<BasicResponse>
    {
        return Promise{ fulfill, reject in
            do {
                let updateFormLayoutRequest = UpdateFormLayoutRequest(app!, layout!, revision!)
                let body = try self.parser.parseObject(updateFormLayoutRequest)
                let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
                self.connection?.requestAsync(ConnectionConstants.PUT_REQUEST, ConnectionConstants.APP_LAYOUT_PREVIEW, jsonBody).then{ response in
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
