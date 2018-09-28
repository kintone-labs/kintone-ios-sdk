// Copyright (c) 2018 Cybozu, Inc.

public class UpdateFormLayoutRequest: NSObject, Codable  {
    private var app: Int?
    private var revision: Int?
    private var layout: [ItemLayout]?
    
    public func getApp() -> Int? {
        return self.app
    }
    public func setApp(_ app: Int) {
        self.app = app
    }
    public func getLayout() -> [ItemLayout]? {
        return self.layout
    }
    public func setLayout(_ layout: [ItemLayout]?) {
        self.layout = layout
    }
    public func getRevision() -> Int? {
        return self.revision
    }
    public func setRevision(_ revision: Int) {
        self.revision = revision
    }
    
    public init(_ app: Int, _ layout: [ItemLayout]?,_ revision: Int) {
        super.init()
        self.setApp(app)
        self.setLayout(layout)
        self.setRevision(revision)
    }
}
