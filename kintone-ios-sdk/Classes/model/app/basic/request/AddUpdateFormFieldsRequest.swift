// Copyright (c) 2018 Cybozu, Inc.

open class AddUpdateFormFieldsRequest: NSObject, Codable {
    private var app: Int?
    private var properties: [String: Field]?
    private var revision: Int?
    
    open func getApp() -> Int? {
        return self.app
    }
    open func setApp(_ app: Int?) {
        self.app = app
    }
    open func getProperties() -> [String: Field]? {
        return self.properties
    }
    open func setProperties(_ properties: [String: Field]?) {
        self.properties = properties
    }
    open func getRevision() -> Int? {
        return self.revision
    }
    open func setRevision(_ revision: Int?) {
        self.revision = revision
    }
    
    public init(_ app: Int?,_ properties: [String: Field]?,_ revision: Int?){
        super.init()
        self.setApp(app)
        self.setProperties(properties)
        self.setRevision(revision)
    }
}
