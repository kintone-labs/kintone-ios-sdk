//
//  FieldValue.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/05.
//  Copyright © 2018年 Cybozu. All rights reserved.
//


public class FieldValue: NSObject, Codable{
    
    private var type: FieldType?
    private var value: Any?
    
    enum CodingKeys: String, CodingKey {
        case type
        case value
    }
    
    public override init() {
    }
    
    public func getType() -> FieldType? {
        return self.type
    }
    
    public func setType(_ type: FieldType) {
        self.type = type
    }
    
    public func getValue() -> Any? {
        return self.value
    }
    
    public func setValue(_ value: Any?) {
        self.value = value
    }
    
    /// Convert Json to fieldValue.class
    ///
    /// - Parameter decoder:
    /// - Throws:
    public required init(from decoder: Decoder) throws {
        do {
            // Set coding-key for decoding
            let container = try decoder.container(keyedBy: CodingKeys.self)
            // Convert type to FieldType Class
            self.type = try container.decodeIfPresent(FieldType.self, forKey: CodingKeys.type)
            // Convert value to Swift Class corresponding to FieldType
            // ★★★ todo : フィールドの中身がnullだった場合の処理はConnection側の仕様が確定してから実装を行う
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
            throw KintoneAPIException("parse error")
        }
    }
    /// convert fieldValue.class to Json
    ///
    /// - Parameter encoder:
    /// - Throws:
    public func encode(to encoder: Encoder) throws {
        do {
            // Set coding-key for encoding
            var container = encoder.container(keyedBy: CodingKeys.self)
            // Convert type to json-item
            try container.encodeIfPresent(type, forKey: CodingKeys.type)
            // Convert value to json-item corresponding to FieldType
            // ★★★ todo : フィールドの中身がnullだった場合の処理はConnection側の仕様が確定してから実装を行う
            switch self.type! {
            case .CREATOR:
                fallthrough
            case .MODIFIER:
                let value = self.value as! Member
                try container.encodeIfPresent(value, forKey: CodingKeys.value)
                break
                
            case .USER_SELECT:
                fallthrough
            case .ORGANIZATION_SELECT:
                fallthrough
            case .GROUP_SELECT:
                fallthrough
            case .STATUS_ASSIGNEE:
                let value = self.value as! [Member]
                try container.encodeIfPresent(value, forKey: CodingKeys.value)
                break
                
            case .CHECK_BOX:
                fallthrough
            case .MULTI_SELECT:
                fallthrough
            case .CATEGORY:
                let value = self.value as! [String]
                try container.encodeIfPresent(value, forKey: CodingKeys.value)
                break
                
            case .FILE:
                let value = self.value as! FileModel
                try container.encodeIfPresent(value, forKey: CodingKeys.value)
                break
                
            default:
                let value = self.value as! String
                try container.encodeIfPresent(value, forKey: CodingKeys.value)
            }
        } catch {
            throw KintoneAPIException("parse error")
        }
    }
}
