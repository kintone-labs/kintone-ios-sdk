//
//  recordParser.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/18.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

public class RecordParser: Parser {
    
    public func parseJsonToFieldValue(_ decoder: Decoder) throws -> FieldValue {
        let fieldValue = FieldValue()
        do {
            // Set coding-key for decoding
            let container = try decoder.container(keyedBy: FieldValue.CodingKeys.self)
            // Convert type to FieldType Class
            fieldValue.setType((try container.decodeIfPresent(FieldType.self, forKey: FieldValue.CodingKeys.type))!)
            // Convert value to Swift Class corresponding to FieldType
            // ★★★ todo : フィールドの中身がnullだった場合の処理はConnection側の仕様が確定してから実装を行う
            switch fieldValue.getType()! {
            case .CREATOR:
                fallthrough
            case .MODIFIER:
                fieldValue.setValue(try container.decodeIfPresent(Member.self, forKey: FieldValue.CodingKeys.value))
                break
                
            case .USER_SELECT:
                fallthrough
            case .ORGANIZATION_SELECT:
                fallthrough
            case .GROUP_SELECT:
                fallthrough
            case .STATUS_ASSIGNEE:
                fieldValue.setValue(try container.decodeIfPresent([Member].self, forKey: FieldValue.CodingKeys.value))
                break
                
            case .CHECK_BOX:
                fallthrough
            case .MULTI_SELECT:
                fallthrough
            case .CATEGORY:
                fieldValue.setValue(try container.decodeIfPresent([String].self, forKey: FieldValue.CodingKeys.value))
                break
                
            case .FILE:
                fieldValue.setValue(try container.decodeIfPresent([FileModel].self, forKey: FieldValue.CodingKeys.value))
                break
                
            case .SUBTABLE:
                fieldValue.setValue(try container.decodeIfPresent([SubTableValueItem].self, forKey: FieldValue.CodingKeys.value))
                break
                
            default:
                fieldValue.setValue(try container.decodeIfPresent(String.self, forKey: FieldValue.CodingKeys.value))
            }
            return fieldValue
        } catch {
            // " + (fieldValue.getType()?.rawValue)"の箇所はデバッグ用のためテスト完了後に削除する
            throw KintoneAPIException("parse error" + (fieldValue.getType()?.rawValue)!)
        }
    }
    
    public func parseFieldValueToJson(_ encoder: Encoder, _ type: FieldType, _ value: Any?) throws {
        do {
            // Set coding-key for encoding
            var container = encoder.container(keyedBy: FieldValue.CodingKeys.self)
            // Convert type to json-item
            try container.encodeIfPresent(type, forKey: FieldValue.CodingKeys.type)
            // Convert value to json-item corresponding to FieldType
            // ★★★ todo : フィールドの中身がnullだった場合の処理はConnection側の仕様が確定してから実装を行う
            switch type {
            case .CREATOR:
                fallthrough
            case .MODIFIER:
                if let fv = value as? Member {
                    try container.encodeIfPresent(fv, forKey: FieldValue.CodingKeys.value)
                }
                break
                
            case .USER_SELECT:
                fallthrough
            case .ORGANIZATION_SELECT:
                fallthrough
            case .GROUP_SELECT:
                fallthrough
            case .STATUS_ASSIGNEE:
                if let fv = value as? [Member] {
                    try container.encodeIfPresent(fv, forKey: FieldValue.CodingKeys.value)
                }
                break
                
            case .CHECK_BOX:
                fallthrough
            case .MULTI_SELECT:
                fallthrough
            case .CATEGORY:
                if let fv = value as? [String] {
                    try container.encodeIfPresent(fv, forKey: FieldValue.CodingKeys.value)
                }
                break
                
            case .FILE:
                if let fv = value as? [FileModel] {
                    try container.encodeIfPresent(fv, forKey: FieldValue.CodingKeys.value)
                }
                break
                
            case .SUBTABLE:
                if let fv = value as? [SubTableValueItem] {
                    try container.encodeIfPresent(fv, forKey: FieldValue.CodingKeys.value)
                }
                break
                
            default:
                if let fv = value as? String {
                    try container.encodeIfPresent(fv, forKey: FieldValue.CodingKeys.value)
                }
            }
        } catch {
            // "+ type.rawValue"の箇所はデバッグ用のためテスト完了後に削除する
            throw KintoneAPIException("parse error" + type.rawValue)
        }
    }

}
