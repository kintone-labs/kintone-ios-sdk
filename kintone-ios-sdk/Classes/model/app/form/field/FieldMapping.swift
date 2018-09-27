//
//  FieldMapping.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/18/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class FieldMapping: NSObject, Codable {
    private var field: String?
    private var relatedField: String?
    
    public init(_ field: String?, _ relatedFields: String?) {
        self.field = field
        self.relatedField = relatedFields
    }
   
    public func getField() -> String? {
        return self.field;
    }
  
    public func setField(_ field: String?) {
        self.field = field
    }
    
    public func getRelatedFields() -> String? {
        return self.relatedField
    }
    
    public func setRelatedFields(_ relatedFields: String?) {
        self.relatedField = relatedFields
    }
    
//    public int hashCode() {
//    final int prime = 31;
//    int result = 1;
//    result = prime * result + ((field == null) ? 0 : field.hashCode());
//    result = prime * result + ((relatedField == null) ? 0 : relatedField.hashCode());
//    return result;
//    }
    
    public func equals(_ obj: AnyObject?) -> Bool {
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
