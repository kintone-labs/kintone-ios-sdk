// Copyright (c) 2018 Cybozu, Inc.

open class DeleteFormFieldsRequest: NSObject, Codable {
    private var app: Int
    private var fields: [String]
    private var revision: Int?
    
    open func getApp() -> Int {
        return self.app
    }
    open func setApp(_ app: Int) {
        self.app = app
    }
    open func getFields() -> [String]{
        return self.fields
    }
    open func setFields(_ fields: [String]) {
        self.fields = fields
    }
    open func getRevision() -> Int? {
        return self.revision
    }
    open func setRevision(_ revision: Int?) {
        self.revision = revision
    }
    
    public init(_ app: Int,_ fields: [String],_ revision: Int?){
        self.app = app
        self.fields = fields
        self.revision = revision
        super.init()
    }
}
