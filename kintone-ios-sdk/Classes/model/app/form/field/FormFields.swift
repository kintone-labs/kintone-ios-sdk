//
//  FormFields.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/18/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class FormFields: NSObject, Codable {
    private var app: String?
    private var revision: String?
    private var properties: [String: Field]?
    
    public override init() {
        app = nil;
        revision = nil;
        properties = [String: Field]()
    }
    
    
    public init(_ app: String?, _ properties: [String: Field]?, _ revision: String?) {
        super.init()
        self.app = app;
        self.revision = revision;
        self.properties = properties;
    }
    
    public func getApp() -> Int? {
        return Int(self.app!)
    }
   
    public func setApp(_ app: String?) {
        return self.app = app
    }
    
    public func getRevision() -> Int? {
        return  Int(self.revision!)
    }
    
    public func setRevision(_ revision: String? ) {
        self.revision = revision
    }
    
    public func getProperties() -> [String: Field]? {
        return self.properties
    }
    
    public func setProperties(_ properties: [String: Field]?) {
        self.properties = properties
    }
}
