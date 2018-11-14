// Copyright (c) 2018 Cybozu, Inc.

open class AddPreviewAppResponse: NSObject, Codable {
    private var app: String?
    private var revision: String?
    
    open func getApp() -> Int? {
        return Int(self.app!)
    }
    open func setApp(_ app: Int?) {
        self.app = "\(String(describing: app!))"
    }
    open func getRevision() -> Int? {
        return Int(self.revision!)
    }
    open func setRevision(_ revision: Int?) {
        self.revision = "\(String(describing: revision!))"
    }
    
    public init(_ app: Int?, _ revision: Int?) {
        super.init()
        self.setApp(app)
        self.setRevision(revision)
    }
}
