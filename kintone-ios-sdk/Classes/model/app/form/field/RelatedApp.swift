//
//  RelatedApp.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/18/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class RelatedApp: NSObject, Codable {
    private var app: String?
    private var code: String
    
    public init(_ app: String?, _ code: String) {
        self.app = app
        self.code = code
    }
    
    public func getApp() -> Int? {
        return Int(self.app!)
    }
    
    public func setApp(_ app: String?) {
        self.app = app
    }
    
    public func getCode() -> String {
        return self.code
    }
    
    public func setCode(_ code: String) {
        self.code = code
    }
   
//    public func hashCode() -> Int {
//        let prime = 31;
//        var result: Int = 1;
//        result = prime * result + ((app == nil) ? 0 : app!.hashCode());
//        result = prime * result + ((code == nil) ? 0 : code!.hashCode());
//        return result;
//    }
    
    public func equals(_ obj: AnyObject?) -> Bool {
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
