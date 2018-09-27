//
//  OptionData.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class OptionData: NSObject, Codable {
    internal var index: String
    internal var label: String

    
    /**
     * @param index
     * @param label
     */
    public init(_ index: String, _ label: String) {
        self.index = index
        self.label = label
    }
    
    /**
     * @return the index
     */
    public func getIndex() -> Int {
        return Int(self.index)!
    }
    
    /**
     * @param index
     *            the index to set
     */
    public func setIndex(_ index: String) {
        self.index = index
    }
    
    /**
     * @return the label
     */
    public func getLabel() -> String {
        return self.label
    }
    
    /**
     * @param label
     * the label to set
     */
    public func setLabel(_ label: String) {
        self.label = label
    }
   
    public func equals(_ obj: AnyObject?) -> Bool {
        if (obj == nil) {
            return false
        }
        if (!(obj is OptionData)) {
            return false
        }
        let other = obj as! OptionData
        if (self.index != other.index) {
            return false
        }
        if (self.label.isEmpty) {
            if (other.label.isEmpty) {
                return false
            }
        } else if (!(self.label == other.label)) {
            return false
        }
        return true
    }
}
