// Copyright (c) 2018 Cybozu, Inc.

open class UpdateFormLayoutRequest: NSObject, Codable  {
    private var app: Int?
    private var revision: Int?
    private var layout: [ItemLayout]?
    
    open func getApp() -> Int? {
        return self.app
    }
    open func setApp(_ app: Int) {
        self.app = app
    }
    open func getLayout() -> [ItemLayout]? {
        return self.layout
    }
    open func setLayout(_ layout: [ItemLayout]?) {
        self.layout = layout
    }
    open func getRevision() -> Int? {
        return self.revision
    }
    open func setRevision(_ revision: Int) {
        self.revision = revision
    }
    
    public init(_ app: Int, _ layout: [ItemLayout]?,_ revision: Int) {
        super.init()
        self.setApp(app)
        self.setLayout(layout)
        self.setRevision(revision)
    }
}
