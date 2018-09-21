//
//  FormLayout.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class FormLayout: NSObject, Codable {
    private var revision: String?
    private var layout: [ItemLayout]?
    
    /**
     * default constructor
     */
    public override init() {
        super.init()
        self.layout = [ItemLayout]();
    }
    
    /**
     * @return the revision
     */
    public func getRevision() -> String? {
        return self.revision
    }
    
    /**
     * @param revision the revision to set
     */
    public func setRevision(_ revision: String?) {
        self.revision = revision
    }
    
    /**
     * @return the layout
     */
    public func getLayout() -> [ItemLayout]? {
        return self.layout
    }
    
    /**
     * @param layout the layout to set
     */
    public func setLayout(_ layout: [ItemLayout]?) {
        self.layout = layout
    }
}

