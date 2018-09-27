//
//  AttachmentField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class AttachmentField: AbstractInputField {
    internal var thumbnailSize: String?
    
    enum AttachmentFieldCodingKeys: String, CodingKey {
        case thumbnailSize
    }
    /**
     * @param code
     */
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.FILE
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AttachmentFieldCodingKeys.self)
        self.thumbnailSize = try container.decode(String.self, forKey: AttachmentFieldCodingKeys.thumbnailSize)
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AttachmentFieldCodingKeys.self)
        if(self.thumbnailSize != nil){
            try container.encode(self.thumbnailSize, forKey: AttachmentFieldCodingKeys.thumbnailSize)
        }
        try super.encode(to: encoder)
    }
    
    /**
     * @return the thumbnailSize
     */
    public func getThumbnailSize() -> Int? {
        return Int(self.thumbnailSize!)
    }
    
    /**
     * @param thumbnailSize
     * the thumbnailSize to set
     */
    public func setThumbnailSize(_ thumbnailSize: String?) {
        self.thumbnailSize = thumbnailSize
    }
}
