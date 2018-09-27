//
//  AddUpdateFormFieldsRequest.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/27/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class AddUpdateFormFieldsRequest: NSObject, Codable {
    private var app: Int?
    private var properties: [String: Field]?
    private var revision: Int?
    
    public func getApp() -> Int? {
        return self.app
    }
    public func setApp(_ app: Int?) {
        self.app = app
    }
    public func getProperties() -> [String: Field]? {
        return self.properties
    }
    public func setProperties(_ properties: [String: Field]?) {
        self.properties = properties
    }
    public func getRevision() -> Int? {
        return self.revision
    }
    public func setRevision(_ revision: Int?) {
        self.revision = revision
    }
    
    public init(_ app: Int?,_ properties: [String: Field]?,_ revision: Int?){
        super.init()
        self.setApp(app)
        self.setProperties(properties)
        self.setRevision(revision)
    }
}
