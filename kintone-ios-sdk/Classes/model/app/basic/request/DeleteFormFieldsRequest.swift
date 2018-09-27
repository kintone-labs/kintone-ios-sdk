//
//  DeleteFormFieldsRequest.swift
//  kintone-ios-sdk
//


public class DeleteFormFieldsRequest: NSObject, Codable {
    private var app: Int?
    private var fields: [String]?
    private var revision: Int?
    
    public func getApp() -> Int? {
        return self.app
    }
    public func setApp(_ app: Int?) {
        self.app = app
    }
    public func getFields() -> [String]? {
        return self.fields
    }
    public func setFields(_ fields: [String]?) {
        self.fields = fields
    }
    public func getRevision() -> Int? {
        return self.revision
    }
    public func setRevision(_ revision: Int?) {
        self.revision = revision
    }
    
    public init(_ app: Int?,_ fields: [String]?,_ revision: Int?){
        super.init()
        self.setApp(app)
        self.setFields(fields)
        self.setRevision(revision)
    }
}
