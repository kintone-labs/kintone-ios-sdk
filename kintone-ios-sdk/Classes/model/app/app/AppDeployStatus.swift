// Copyright (c) 2018 Cybozu, Inc.

public class AppDeployStatus: NSObject, Codable {
    private var app: String?
    private var status: Status?
    
    public enum Status: String, Codable {
        case PROCESSING
        case SUCCESS
        case FAIL
        case CANCEL
    }
    
    public func getApp() -> Int? {
        return Int(self.app!)
    }
    public func setApp(_ app: Int?) {
        self.app = "\(String(describing: app!))"
    }
    public func getStatus() -> Status? {
        return self.status
    }
    public func setStatus(_ status: Status?) {
        self.status = status
    }
    
    init(_ app: Int?, _ status: Status?) {
        super.init()
        self.setApp(app)
        self.setStatus(status)
    }
}
