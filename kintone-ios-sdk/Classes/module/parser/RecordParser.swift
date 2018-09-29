//
//  recordParser.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/18.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

internal class RecordParser: Parser {
    
    /// Convert Json to AddRecordResponse
    ///
    /// - Parameter decoder: Decoder
    /// - Returns: AddRecordResponse
    /// - Throws: KintoneAPIException
    func parseForAddRecordResponse(_ decoder: Decoder) throws -> AddRecordResponse {
        let  response = AddRecordResponse()
        do {
            // Set coding-key for decoding
            let container = try decoder.container(keyedBy: AddRecordResponse.CodingKeys.self)
            // Convert id to String
            let strId = try container.decode(String.self, forKey: .id)
            // Convert strId to Int
            let id = Int(strId)
            if id != nil {
                response.setId(id!)
            }
            // Convert revision to String
            let strRevision = try container.decode(String.self, forKey: .revision)
            // Convert strRevision to Int
            let revision = Int(strRevision)
            if revision != nil {
                response.setRevision(revision!)
            }
            return response
        } catch  {
            throw KintoneAPIException("parse error")
        }
    }
    
    /// Convert Json to AddRecordsResponse
    ///
    /// - Parameter decoder: Decoder
    /// - Returns: AddRecordsResponse
    /// - Throws: KintoneAPIException
    func parseForAddRecordsResponse(_ decoder: Decoder) throws -> AddRecordsResponse {
        let response = AddRecordsResponse()
        do {
            // Set coding-key for decoding
            let container = try decoder.container(keyedBy: AddRecordsResponse.CodingKeys.self)
            // Convert ids to array of String
            let strIds = try container.decode([String].self, forKey: .ids)
            // Convert strIds to array of Int
            var ids: [Int] = []
            for strId in strIds {
                let id = Int(strId)
                if id != nil {
                    ids.append(id!)
                }
            }
            response.setIDs(ids)
            // Convert revisoins to array of String
            let strRevisions = try container.decode([String].self, forKey: .revisions)
            // Convert strRevisions to array of Int
            var revisions: [Int] = []
            for strRevision in strRevisions {
                let revision = Int(strRevision)
                if revision != nil {
                    revisions.append(revision!)
                }
            }
            response.setRevisions(revisions)
            // return result
            return response
        } catch  {
            throw KintoneAPIException("parse error")
        }
    }
    
    /// Convert Json to GetRecordsResponse
    ///
    /// - Parameter decoder: Decoder
    /// - Returns: GetRecordsResponse
    /// - Throws: KintoneAPIException
    func parseForGetRecordsResponse(_ decoder: Decoder) throws -> GetRecordsResponse {
        let  response = GetRecordsResponse()
        do {
            // Set coding-key for decoding
            let container = try decoder.container(keyedBy: GetRecordsResponse.CodingKeys.self)
            // Convert records to array of dictionary
            let records = try container.decodeIfPresent([[String:FieldValue]].self, forKey: .records)
            if records != nil {
                response.setRecords(records!)
            }
            // Convert totalCount to Int
            let strCount = try container.decodeIfPresent(String.self, forKey: .totalCount)            // Convert revision to String
            // Convert strCount to Int
            var count: Int?
            if strCount != nil {
                count = Int(strCount!)
            }
            if count != nil {
                response.setTotalCount(count!)
            }
            return response
        } catch  {
            throw KintoneAPIException("parse error")
        }
    }
    
    /// Convert Json to RecordUpdateResponseItem
    ///
    /// - Parameter decoder: Decoder
    /// - Returns: RecordUpdateResponseItem
    /// - Throws: KintoneAPIException
    func parseForRecordUpdateResponseItem(_ decoder: Decoder) throws -> RecordUpdateResponseItem {
        let  response = RecordUpdateResponseItem()
        do {
            // Set coding-key for decoding
            let container = try decoder.container(keyedBy: RecordUpdateResponseItem.CodingKeys.self)
            // Convert id to String
            let strId = try container.decode(String.self, forKey: .id)
            // Convert strId to Int
            let id = Int(strId)
            if id != nil {
                response.setID(id!)
            }
            // Convert revision to String
            let strRevision = try container.decode(String.self, forKey: .revision)
            // Convert strRevision to Int
            let revision = Int(strRevision)
            if revision != nil {
                response.setRevision(revision!)
            }
            return response
        } catch  {
            throw KintoneAPIException("parse error")
        }
    }
    
    /// Convert Json to UpdateRecordResponse
    ///
    /// - Parameter decoder: Decoder
    /// - Returns: UpdateRecordResponse
    /// - Throws: KintoneAPIException
    func parseForUpdateRecordResponse(_ decoder: Decoder) throws -> UpdateRecordResponse {
        let  response = UpdateRecordResponse()
        do {
            // Set coding-key for decoding
            let container = try decoder.container(keyedBy: UpdateRecordResponse.CodingKeys.self)
            // Convert revision to String
            let strRevision = try container.decode(String.self, forKey: .revision)
            // Convert strRevision to Int
            let revision = Int(strRevision)
            if revision != nil {
                response.setRevision(revision!)
            }
            return response
        } catch  {
            throw KintoneAPIException("parse error")
        }
    }
    
    /// Convert Json to AddCommentResponse
    ///
    /// - Parameter decoder: Decoder
    /// - Returns: AddCommentResponse
    /// - Throws: KintoneAPIException
    func parseJsonToAddCommentResponse(_ decoder: Decoder) throws -> AddCommentResponse {
        let  response = AddCommentResponse()
        do {
            // Set coding-key for decoding
            let container = try decoder.container(keyedBy: SubTableValueItem.CodingKeys.self)
            // Convert id to String
            let strId = try container.decode(String.self, forKey: .id)
            // Convert strId to Int
            let id = Int(strId)
            if id != nil {
                response.setId(id!)
            }
            return response
        } catch  {
            throw KintoneAPIException("parse error")
        }
    }
    
    /// Convert Json to SubTableValueItem
    ///
    /// - Parameter decoder: Decoder
    /// - Returns: SubTableValueItem
    /// - Throws: KintoneAPIException
    func parseJsonToSubTableItem(_ decoder: Decoder) throws -> SubTableValueItem {
        let  response = SubTableValueItem()
        do {
            // Set coding-key for decoding
            let container = try decoder.container(keyedBy: SubTableValueItem.CodingKeys.self)
            // Convert id to String
            let strId = try container.decode(String.self, forKey: .id)
            // Convert strId to Int
            let id = Int(strId)
            if id != nil {
                response.setID(id!)
            }
            // Convert value to dictionary
            let value = try container.decodeIfPresent([String:FieldValue].self, forKey: .value)
            if value != nil {
                response.setValue(value!)
            }
            return response
        } catch  {
            throw KintoneAPIException("parse error")
        }
    }
    
    /// Convert Json to Comment
    ///
    /// - Parameter decoder: Decoder
    /// - Returns: Comment
    /// - Throws: KintoneAPIException
    func parseJsonToComment(_ decoder: Decoder) throws -> Comment {
        let  response = Comment()
        do {
            // Set coding-key for decoding
            let container = try decoder.container(keyedBy: Comment.CodingKeys.self)
            // Convert id to String
            let strId = try container.decode(String.self, forKey: .id)
            // Convert strId to Int
            let id = Int(strId)
            if id != nil {
                response.setId(id!)
            }
            // Convert text to String
            let text = try container.decodeIfPresent(String.self, forKey: .text)
            if text != nil {
                response.setText(text!)
            }
            // Convert createdAt to Date
            let createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
            if createdAt != nil {
                response.setCreatedAt(createdAt!)
            }
            // Convert creator to String
            let creator = try container.decodeIfPresent(Member.self, forKey: .creator)
            if creator != nil {
                response.setCreator(creator!)
            }
            // Convert mentions to array of CommentMention
            let mentions = try container.decodeIfPresent([CommentMention].self, forKey: .mentions)
            if mentions != nil {
                response.setMentions(mentions!)
            }
            return response
        } catch  {
            throw KintoneAPIException("parse error")
        }
    }
    
    /// Convert Json to FieldValue
    ///
    /// - Parameter decoder: Decoder
    /// - Returns: FieldValue
    /// - Throws: KintoneAPIException
    public func parseJsonToFieldValue(_ decoder: Decoder) throws -> FieldValue {
        let fieldValue = FieldValue()
        do {
            // Set coding-key for decoding
            let container = try decoder.container(keyedBy: FieldValue.CodingKeys.self)
            // Convert type to FieldType Class
            fieldValue.setType((try container.decodeIfPresent(FieldType.self, forKey: .type))!)
            // Convert value to Swift Class corresponding to FieldType
            switch fieldValue.getType()! {
            case .CREATOR:
                fallthrough
            case .MODIFIER:
                fieldValue.setValue(try container.decodeIfPresent(Member.self, forKey: .value))
                break
                
            case .USER_SELECT:
                fallthrough
            case .ORGANIZATION_SELECT:
                fallthrough
            case .GROUP_SELECT:
                fallthrough
            case .STATUS_ASSIGNEE:
                fieldValue.setValue(try container.decodeIfPresent([Member].self, forKey: .value))
                break
                
            case .CHECK_BOX:
                fallthrough
            case .MULTI_SELECT:
                fallthrough
            case .CATEGORY:
                fieldValue.setValue(try container.decodeIfPresent([String].self, forKey: .value))
                break
                
            case .FILE:
                fieldValue.setValue(try container.decodeIfPresent([FileModel].self, forKey: .value))
                break
                
            case .SUBTABLE:
                fieldValue.setValue(try container.decodeIfPresent([SubTableValueItem].self, forKey: .value))
                break
                
            default:
                fieldValue.setValue(try container.decodeIfPresent(String.self, forKey: .value))
            }
            return fieldValue
        } catch {
            // " + (fieldValue.getType()?.rawValue)"の箇所はデバッグ用のためテスト完了後に削除する
            throw KintoneAPIException("parse error" + (fieldValue.getType()?.rawValue)!)
        }
    }
    
    /// Convert FieldValue to Json
    ///
    ///   - encoder: Encoder
    ///   - type: the type of field
    ///   - value: the value of field
    /// - Throws: KintoneAPIException
    public func parseFieldValueToJson(_ encoder: Encoder, _ type: FieldType, _ value: Any?) throws {
        do {
            // Set coding-key for encoding
            var container = encoder.container(keyedBy: FieldValue.CodingKeys.self)
            // Convert type to json-item
            try container.encodeIfPresent(type, forKey: .type)
            // Convert value to json-item corresponding to FieldType
            switch type {
            case .CREATOR:
                fallthrough
            case .MODIFIER:
                if let fv = value as? Member {
                    try container.encodeIfPresent(fv, forKey: .value)
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
                    try container.encodeIfPresent(fv, forKey: .value)
                }
                break
                
            case .CHECK_BOX:
                fallthrough
            case .MULTI_SELECT:
                fallthrough
            case .CATEGORY:
                if let fv = value as? [String] {
                    try container.encodeIfPresent(fv, forKey: .value)
                }
                break
                
            case .FILE:
                if let fv = value as? [FileModel] {
                    try container.encodeIfPresent(fv, forKey: .value)
                }
                break
                
            case .SUBTABLE:
                if let fv = value as? [SubTableValueItem] {
                    try container.encodeIfPresent(fv, forKey: .value)
                }
                break
                
            default:
                if let fv = value as? String {
                    try container.encodeIfPresent(fv, forKey: .value)
                }
            }
        } catch {
            // "+ type.rawValue"の箇所はデバッグ用のためテスト完了後に削除する
            throw KintoneAPIException("parse error" + type.rawValue)
        }
    }

}
