// Copyright (c) 2018 Cybozu, Inc.

public class Field: NSObject, Codable {
    internal var code: String = ""
    internal var type: FieldType?
    
    public func getCode() -> String {
        return self.code
    }
    
    public func setCode(_ code: String) {
        self.code = code;
    }
    
    public func getType() -> FieldType? {
        return self.type
    }
   
    public func setType(_ type: FieldType) {
        self.type = type
    }
    
    public func equals(_ obj: AnyObject?) -> Bool {
        if (obj == nil) {
            return false
        }
        if (!(obj is Field)) {
            return false
        }
        let other = obj as! Field
        if (self.code.isEmpty) {
            if (!other.code.isEmpty) {
                return false
            }
        } else if (!(self.code == other.code)) {
            return false
        }
        return true
    }
    
}

