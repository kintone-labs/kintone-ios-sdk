// Copyright (c) 2018 Cybozu, Inc.

open class AppDeployStatus: NSObject, Codable {
    private var app: String?
    private var status: Status?
    
    public enum Status: String, Codable {
        case PROCESSING
        case SUCCESS
        case FAIL
        case CANCEL
    }
    
    open func getApp() -> Int? {
        return Int(self.app!)
    }
    open func setApp(_ app: Int?) {
        self.app = "\(String(describing: app!))"
    }
    open func getStatus() -> Status? {
        return self.status
    }
    open func setStatus(_ status: Status?) {
        self.status = status
    }
    
    init(_ app: Int?, _ status: Status?) {
        super.init()
        self.setApp(app)
        self.setStatus(status)
    }
}
