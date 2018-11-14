// Copyright (c) 2018 Cybozu, Inc.

open class RelatedApp: NSObject, Codable {
    private var app: String?
    private var code: String
    
    public override init() {
        self.code = ""
        super.init()
    }
    
    public init(_ app: String?, _ code: String) {
        self.app = app
        self.code = code
    }
    
    open func getApp() -> Int? {
        return Int(self.app!)
    }
    
    open func setApp(_ app: String?) {
        self.app = app
    }
    
    open func getCode() -> String {
        return self.code
    }
    
    open func setCode(_ code: String) {
        self.code = code
    }
    
    open func equals(_ obj: AnyObject?) -> Bool {
        if (obj == nil) {
            return false
        }
        if (!(type(of: obj) == RelatedApp.self)) {
            return false
        }
        let other = obj as! RelatedApp
        if (self.app == nil) {
            if (other.app != nil) {
                return false
            }
        } else if (!(self.app == other.app)) {
            return false
        }
        if (self.code.isEmpty) {
            if (other.code.isEmpty){
                return false
            } else if (!(self.code == other.code)) {
                return false
            }
        }
         return true
    }
}
