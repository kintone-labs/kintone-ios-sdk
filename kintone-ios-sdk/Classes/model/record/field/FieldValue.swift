//
//  FieldValue.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/05.
//  Copyright © 2018年 Cybozu. All rights reserved.
//


public class FieldValue: NSObject, Codable{
    
    public var type: FieldType?
    public var value: Any?
    
    enum CodingKeys: String, CodingKey {
        case type
        case value
    }
    
    public override init() {
    }
    
    /// Convert Json to fieldValue.class
    ///
    /// - Parameter decoder: <#decoder description#>
    /// - Throws: <#throws value description#>
    public required init(from decoder: Decoder) throws {
        do {
            // Set coding-key for decoding
            let container = try decoder.container(keyedBy: CodingKeys.self)
            // Convert type to FieldType Class
            self.type = try container.decodeIfPresent(FieldType.self, forKey: CodingKeys.type)
            // Convert value to Swift Class corresponding to FieldType
            switch self.type! {
            case .CREATOR:
                fallthrough
            case .MODIFIER:
                self.value = try container.decodeIfPresent(Member.self, forKey: CodingKeys.value)
                break
                
            case .USER_SELECT:
                fallthrough
            case .ORGANIZATION_SELECT:
                fallthrough
            case .GROUP_SELECT:
                fallthrough
            case .STATUS_ASSIGNEE:
                self.value = try container.decodeIfPresent([Member].self, forKey: .value)
                break
                
            case .CHECK_BOX:
                fallthrough
            case .MULTI_SELECT:
                fallthrough
            case .CATEGORY:
                self.value = try container.decodeIfPresent([String].self, forKey: .value)
                break
                
            case .FILE:
                self.value = try container.decodeIfPresent(FileModel.self, forKey: .value)
                break
                
            default:
                self.value = try container.decodeIfPresent(String.self, forKey: .value)
            }
        } catch {
            print("parse error")
        }
    }
    /// convert fieldValue.class to Json
    ///
    /// - Parameter encoder: <#encoder description#>
    /// - Throws: <#throws value description#>
    public func encode(to encoder: Encoder) throws {
        // Set coding-key for encoding
        var container = encoder.container(keyedBy: CodingKeys.self)
        // Convert type to json-item
        try! container.encodeIfPresent(type, forKey: CodingKeys.type)
        // Convert value to json-item corresponding to FieldType
        switch self.type! {
        case .CREATOR:
            fallthrough
        case .MODIFIER:
            let value = self.value as! Member
            try! container.encodeIfPresent(value, forKey: CodingKeys.value)
            break
            
        case .USER_SELECT:
            fallthrough
        case .ORGANIZATION_SELECT:
            fallthrough
        case .GROUP_SELECT:
            fallthrough
        case .STATUS_ASSIGNEE:
            let value = self.value as! [Member]
            try! container.encodeIfPresent(value, forKey: CodingKeys.value)
            break
            
        case .CHECK_BOX:
            fallthrough
        case .MULTI_SELECT:
            fallthrough
        case .CATEGORY:
            let value = self.value as! [String]
            try! container.encodeIfPresent(value, forKey: CodingKeys.value)
            break
            
        case .FILE:
            let value = self.value as! FileModel
            try! container.encodeIfPresent(value, forKey: CodingKeys.value)
            break
            
        default:
            let value = self.value as! String
            try! container.encodeIfPresent(value, forKey: CodingKeys.value)
        }
    }
}
