// Copyright (c) 2018 Cybozu, Inc.

open class PreviewApp: NSObject, Codable {
    private var app: String?
    private var revision: String?
    
    open func getApp() -> Int? {
        return Int(self.app != nil ? self.app! : "")
    }
    open func setApp(_ app: Int?) {
        self.app = app != nil ? "\(String(describing: app!))" : nil
    }
    open func getRevision() -> Int? {
        return Int(self.revision != nil ? self.revision! : "")
    }
    open func setRevision(_ revision: Int?) {
        self.revision = revision != nil ? "\(String(describing: revision!))" : nil
    }
    
    public init(_ app: Int?, _ revision: Int?) {
        super.init()
        self.setApp(app)
        self.setRevision(revision)
    }
}
