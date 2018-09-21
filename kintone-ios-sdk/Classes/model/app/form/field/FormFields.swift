//
//  FormFields.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/18/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

import UIKit

public class FormFields: NSObject {
    private var app: Int?
    private var revision: Int?
    private var properties: [String: Field]?
    
    public override init() {
        app = nil;
        revision = nil;
        properties = [String: Field]()
    }
    
    
    public init(_ app: Int, _ properties: [String: Field]?, _ revision: Int?) {
        self.app = app;
        self.revision = revision;
        self.properties = properties;
    }
    
    public func getApp() -> Int? {
        return self.app;
    }
   
    public func setApp(_ app: Int?) {
        return self.app = app;
    }
    
    public func getRevision() -> Int? {
        return self.revision;
    }
    
    public func setRevision(_ revision: Int? ) {
        self.revision = revision;
    }
    
    public func getProperties() -> [String: Field]? {
        return self.properties;
    }
    
    public func setProperties(_ properties: [String: Field]?) {
        self.properties = properties;
    }
}
