// Copyright (c) 2018 Cybozu, Inc.

open class UpdateFormLayoutRequest: NSObject, Codable  {
    private var app: Int
    private var layout: [ItemLayout]
    private var revision: Int?
    
    open func getApp() -> Int{
        return self.app
    }
    open func setApp(_ app: Int) {
        self.app = app
    }
    open func getLayout() -> [ItemLayout] {
        return self.layout
    }
    open func setLayout(_ layout: [ItemLayout]) {
        self.layout = layout
    }
    open func getRevision() -> Int? {
        return self.revision
    }
    open func setRevision(_ revision: Int?) {
        self.revision = revision
    }
    
    public init(_ app: Int, _ layout: [ItemLayout],_ revision: Int?) {
        self.app = app
        self.layout = layout
        self.revision = revision
        super.init()
    }
}
