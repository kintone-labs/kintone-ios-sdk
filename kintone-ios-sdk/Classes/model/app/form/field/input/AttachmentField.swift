//
//  AttachmentField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

import Foundation


public class AttachmentField: AbstractInputField {
    internal var thumbnailSize: Int?
    
    /**
     * @param code
     */
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.FILE
    }
    
    /**
     * @return the thumbnailSize
     */
    public func getThumbnailSize() -> Int? {
        return self.thumbnailSize
    }
    
    /**
     * @param thumbnailSize
     * the thumbnailSize to set
     */
    public func setThumbnailSize(_ thumbnailSize: Int?) {
        self.thumbnailSize = thumbnailSize
    }
}
