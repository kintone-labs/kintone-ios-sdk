//
//  OptionData.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

import Foundation


public class OptionData: NSObject {
    internal var index: Int
    internal var label: String

    
    /**
     * @param index
     * @param label
     */
    public init(_ index: Int, _ label: String) {
        self.index = index
        self.label = label
    }
    
    /**
     * @return the index
     */
    public func getIndex() -> Int {
        return self.index
    }
    
    /**
     * @param index
     *            the index to set
     */
    public func setIndex(_ index: Int) {
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
    
//    /* (non-Javadoc)
//     * @see java.lang.Object#hashCode()
//     */
//    @Override
//    public int hashCode() {
//    final int prime = 31;
//    int result = 1;
//    result = prime * result + index;
//    result = prime * result + ((label == null) ? 0 : label.hashCode());
//    return result;
//    }
    
   
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
