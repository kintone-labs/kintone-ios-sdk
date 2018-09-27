//
//  MemberSelectEntity.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class MemberSelectEntity: NSObject, Codable {
    private var code: String?
    private var type: MemberSelectEntityType?
    
    public override init(){
         super.init()
    }
    
    /**
     * @param code
     * @param type
     */
    public init(_ code: String?, _ type: MemberSelectEntityType?) {
        self.code = code
        self.type = type
    }
    
    /**
     * @return the code
     */
    public func getCode() -> String? {
        return self.code
    }
    
    /**
     * @param code the code to set
     */
    public func setCode(_ code: String?) {
        self.code = code
    }
    
    /**
     * @return the type
     */
    public func getType() -> MemberSelectEntityType? {
        return self.type
    }
    
    /**
     * @param type the type to set
     */
    public func setType(_ type: MemberSelectEntityType?) {
        self.type = type
    }

    public func equals(_ obj: AnyObject?) -> Bool? {
        if (obj == nil) {
            return false
        }
        if (!(obj is MemberSelectEntity)) {
            return false
        }
        
        let other = obj as! MemberSelectEntity
        if (self.code!.isEmpty) {
            if (other.code!.isEmpty) {
                return false
            }
        } else if (!(self.code == other.code)) {
            return false
        }
        if (self.type != other.type) {
            return false
        }
        return true
    }
}

