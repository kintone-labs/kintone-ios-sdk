// Copyright (c) 2018 Cybozu, Inc.

open class FieldMapping: NSObject, Codable {
    private var field: String?
    private var relatedField: String?
    
    public init(_ field: String?, _ relatedFields: String?) {
        self.field = field
        self.relatedField = relatedFields
    }
   
    open func getField() -> String? {
        return self.field;
    }
  
    open func setField(_ field: String?) {
        self.field = field
    }
    
    open func getRelatedFields() -> String? {
        return self.relatedField
    }
    
    open func setRelatedFields(_ relatedFields: String?) {
        self.relatedField = relatedFields
    }
    
    open func equals(_ obj: AnyObject?) -> Bool {
        if (obj == nil) {
            return false
        }
        if (!(type(of: obj) == FieldMapping.self)) {
            return false
        }
        let other = obj as! FieldMapping
        if (self.field == nil) {
            if (other.field != nil) {
                return false
            }
        } else if (!(self.field == other.field)) {
            return false
        }
        if (self.relatedField == nil) {
            if (other.relatedField != nil) {
                return false
            }
        } else if (!(self.relatedField == other.relatedField)) {
            return false
        }
        return true
    }
}
