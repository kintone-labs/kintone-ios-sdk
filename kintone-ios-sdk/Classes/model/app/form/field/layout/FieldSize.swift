//
//  FieldSize.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class FieldSize: NSObject, Codable {
    private var width: String?
    private var height: String?
    private var innerHeight: String?
    
    /**
     * @return the width
     */
    public func getWidth() -> String? {
        return self.width
    }
    
    /**
     * @param width
     *            the width to set
     */
    public func setWidth(_ width: String?) {
        self.width = width
    }
    
    /**
     * @return the height
     */
    public func getHeight() -> String? {
        return self.height
    }
    
    /**
     * @param height
     *            the height to set
     */
    public func setHeight(_ height: String?) {
        self.height = height
    }
    
    /**
     * @return the innerHeight
     */
    public func getInnerHeight() -> String? {
        return self.innerHeight
    }
    
    /**
     * @param innerHeight
     *            the innerHeight to set
     */
    public func setInnerHeight(_ innerHeight: String?) {
        self.innerHeight = innerHeight;
    }
}
