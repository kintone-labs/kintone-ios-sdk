// Copyright (c) 2018 Cybozu, Inc.

public class AddPreviewAppResponse: NSObject, Codable {
    private var app: String?
    private var revision: String?
    
    public func getApp() -> Int? {
        return Int(self.app!)
    }
    public func setApp(_ app: Int?) {
        self.app = "\(String(describing: app!))"
    }
    public func getRevision() -> Int? {
        return Int(self.revision!)
    }
    public func setRevision(_ revision: Int?) {
        self.revision = "\(String(describing: revision!))"
    }
    
    public init(_ app: Int?, _ revision: Int?) {
        super.init()
        self.setApp(app)
        self.setRevision(revision)
    }
}
