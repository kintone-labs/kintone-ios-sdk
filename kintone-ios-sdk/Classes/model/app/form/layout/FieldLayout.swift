//
//  FieldLayout.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class FieldLayout: NSObject, Codable {
    private var type: String?
    private var code: String?
    private var elementId: String?
    private var label: String?
    private var size: FieldSize?
    
    public override init() {
        super.init()
    }

    
    /**
     * @return the type
     */
    public func getType() -> String? {
        return self.type
    }
    
    /**
     * @param type the type to set
     */
    public func setType(_ type: String?) {
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
     * @return the elementId
     */
    public func getElementId() -> String? {
        return self.elementId
    }
    
    /**
     * @param elementId the elementId to set
     */
    public func setElementId(_ elementId: String?) {
        self.elementId = elementId
    }
    
    /**
     * @return the label
     */
    public func getLabel() -> String? {
        return self.label;
    }
    
    /**
     * @param label the label to set
     */
    public func setLabel(_ label: String?) {
        self.label = label
    }
    
    /**
     * @return the size
     */
    public func getSize() -> FieldSize? {
        return self.size
    }
    
    /**
     * @param size the size to set
     */
    public func setSize(_ size: FieldSize?) {
        self.size = size
    }

    public func equals(_ obj: AnyObject? ) -> Bool? {
        if (obj == nil){
            return false
        }
        if (!(obj is FieldLayout)) {
            return false
        }
        let other = obj as! FieldLayout
        if (self.code!.isEmpty) {
            if (!(other.code!.isEmpty)){
                return false
            } else if (!(self.code == other.code)){
                return false
            }
        }
         return true
    }
}
