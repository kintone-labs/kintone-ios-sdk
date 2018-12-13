// Copyright (c) 2018 Cybozu, Inc.

open class UpdateViewsResponse: NSObject, Codable {
    private var revision: String?
    private var views: [String: ViewModel]?
    
    open func getRevision() -> Int? {
        return Int(self.revision != nil ? self.revision! : "")
    }
    open func setRevision(_ revision: Int?) {
        self.revision = revision != nil ? "\(String(describing: revision!))" : nil
    }
    
    open func getViews() -> [String: ViewModel]? {
        return self.views
    }
    open func setViews(_ views: [String: ViewModel]?) {
        self.views = views
    }
    
    public init(_ revision: Int?, _ views: [String: ViewModel]?) {
        super.init()
        self.setRevision(revision)
        self.setViews(views)
    }
}
