// Copyright (c) 2018 Cybozu, Inc.

open class UpdateViewsRequest: NSObject, Codable {
    private var app: Int?
    private var views: [String: ViewModel]?
    private var revision: Int?
    
    open func getApp() -> Int? {
        return self.app
    }
    open func setApp(_ app: Int) {
        self.app = app
    }
    open func getViews() -> [String: ViewModel]? {
        return self.views
    }
    open func setViews(_ views: [String: ViewModel]) {
        self.views = views
    }
    open func getRevision() -> Int? {
        return self.revision
    }
    open func setRevision(_ revision: Int) {
        self.revision = revision
    }
    
    public init(_ app: Int, _ views: [String: ViewModel],_ revision: Int) {
        super.init()
        self.setApp(app)
        self.setViews(views)
        self.setRevision(revision)
    }
}
