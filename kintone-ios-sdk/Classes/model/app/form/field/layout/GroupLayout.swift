//
//  GroupLayout.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

import Foundation


public class GroupLayout: ItemLayout {
    private var code: String?
    private var layout: [RowLayout]?
    
    /**
     * default constructor
     */
    public override init() {
        super.init()
        self.type = LayoutType.GROUP
        self.layout = [RowLayout]()
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
     * @return the layout
     */
    public func getLayout() -> [RowLayout]? {
        return self.layout
    }
    
    /**
     * @param layout the layout to set
     */
    public func setLayout(_ layout: [RowLayout]?) {
        self.layout = layout
    }
}
