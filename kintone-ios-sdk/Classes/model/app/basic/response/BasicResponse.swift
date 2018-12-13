// Copyright (c) 2018 Cybozu, Inc.

open class BasicResponse: NSObject, Codable {
    private var revision: String?
    
    open func getRevision() -> Int? {
        return Int(self.revision != nil ? self.revision! : "")
    }
    open func setRevision(_ revision: Int?) {
        self.revision = revision != nil ? "\(String(describing: revision!))" : nil
    }
    
    public init(_ revision: Int?) {
        super.init()
        self.setRevision(revision)
    }
}
