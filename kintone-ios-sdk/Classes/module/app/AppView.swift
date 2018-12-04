// Copyright (c) 2018 Cybozu, Inc.
import Promises

public protocol AppView {
    
    /// Gets the View settings of an App.
    ///
    /// - Parameters:
    ///   - app: Int | The app ID.
    ///   - lang: LanguageSetting | The localized language to retrieve the data
    ///   - isPreview: Bool
    /// - Returns: GetViewsResponse Model
    /// - Throws: throws KintoneAPIException
    func getViews(_ app: Int?, _ lang: LanguageSetting?,_ isPreview: Bool?) -> Promise<GetViewsResponse>
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - app: Int | The app ID.
    ///   - lang: LanguageSetting | The localized language to retrieve the data
    ///   - revision: Bool
    /// - Returns: GetViewsResponse
    /// - Throws: throws KintoneAPIException
    func updateViews(_ app: Int?, _ views: [String: ViewModel],_ revision: Int?) -> Promise<UpdateViewsResponse>
}

public extension AppView where Self: App {
    func getViews(_ app: Int?, _ lang: LanguageSetting?,_ isPreview: Bool? = false) -> Promise<GetViewsResponse> {
        return Promise { fulfill, reject in
            do {
                let getViewsRequest = GetViewsRequest(app!, lang!)
                let body = try self.parser.parseObject(getViewsRequest)
                let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
                let apiName = isPreview ?? false ? ConnectionConstants.APP_VIEWS_PREVIEW : ConnectionConstants.APP_VIEWS
                self.connection?.request(ConnectionConstants.GET_REQUEST, apiName, jsonBody)
                    .then { response in
                        // return response as GetRecordResponse class
                        let parseResponse = try self.parser.parseJson(GetViewsResponse.self, response)
                        fulfill(parseResponse)
                    }
                    .catch { error in
                        reject(error)
                }
            } catch {
                reject(error)
            }
        }
    }
    
    func updateViews(_ app: Int?, _ views: [String: ViewModel],_ revision: Int? = -1) -> Promise<UpdateViewsResponse> {
        return Promise { fulfill, reject in
            do {
                let updateViewsRequest = UpdateViewsRequest(app!, views, revision ?? -1)
                let body = try self.parser.parseObject(updateViewsRequest)
                let jsonBody = String(data: body, encoding: String.Encoding.utf8)!
                self.connection?.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.APP_VIEWS_PREVIEW, jsonBody)
                    .then { response in
                        // return response as GetRecordResponse class
                        let parseResponse = try self.parser.parseJson(UpdateViewsResponse.self, response)
                        fulfill(parseResponse)
                    }
                    .catch { error in
                        reject(error)
                }
            } catch {
                reject(error)
            }
        }
    }
}
