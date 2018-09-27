//
//  BasicResponse.swift
//  kintone-ios-sdk
//

public class BasicResponse: NSObject, Codable {
    private var revision: String?
    
    public func getRevision() -> Int? {
        return Int(self.revision!)
    }
    public func setRevision(_ revision: Int?) {
        self.revision = "\(String(describing: revision!))"
    }
    
    public init(_ revision: Int?) {
        super.init()
        self.setRevision(revision)
    }
}
