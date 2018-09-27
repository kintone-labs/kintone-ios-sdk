//
//  LookupItem.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class LookupItem: NSObject, Codable {
    private var fieldMappings: [FieldMapping]
    private var filterCond: String?
    private var lookupPickerFields: [String]
    private var relatedApp: RelatedApp?
    private var relatedKeyField: String?
    private var sort: String?
    
    enum LookupItemCodingKeys: String, CodingKey {
        case fieldMappings
        case filterCond
        case lookupPickerFields
        case relatedApp
        case relatedKeyField
        case sort
    }
    
    public override init() {
        self.fieldMappings = [FieldMapping]()
        self.lookupPickerFields = [String]()
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LookupItemCodingKeys.self)
        self.fieldMappings = try container.decode([FieldMapping].self, forKey: LookupItemCodingKeys.fieldMappings)
        self.filterCond = try container.decode(String.self, forKey: LookupItemCodingKeys.filterCond)
        self.filterCond = try container.decode(String.self, forKey: LookupItemCodingKeys.filterCond)
        self.lookupPickerFields = try container.decode([String].self, forKey: LookupItemCodingKeys.lookupPickerFields)
         self.relatedApp = try container.decode(RelatedApp.self, forKey: LookupItemCodingKeys.relatedApp)
        self.relatedKeyField = try container.decode(String.self, forKey: LookupItemCodingKeys.relatedKeyField)
        self.sort = try container.decode(String.self, forKey: LookupItemCodingKeys.sort)
        super.init()
    }
    /**
     * @return the fieldMapping
     */
    public func getFieldMapping() -> [FieldMapping] {
        return self.fieldMappings
    }
    
    /**
     * @param fieldMapping the fieldMapping to set
     */
    public func setFieldMapping(_ fieldMapping: [FieldMapping]) {
        self.fieldMappings = fieldMapping
    }
    
    /**
     * @return the filterCond
     */
    public func getFilterCond() -> String? {
        return self.filterCond
    }
    
    /**
     * @param filterCond the filterCond to set
     */
    public func setFilterCond(_ filterCond: String?) {
        self.filterCond = filterCond
    }
    
    /**
     * @return the lookupPickerFields
     */
    public func getLookupPickerFields() -> [String] {
        return self.lookupPickerFields;
    }
    
    /**
     * @param lookupPickerFields the lookupPickerFields to set
     */
    public func setLookupPickerFields(_ lookupPickerFields: [String]) {
        self.lookupPickerFields = lookupPickerFields
    }
    
    /**
     * @return the relatedApp
     */
    public func getRelatedApp() -> RelatedApp? {
        return self.relatedApp
    }
    
    /**
     * @param relatedApp the relatedApp to set
     */
    public func setRelatedApp(_ relatedApp: RelatedApp?) {
        self.relatedApp = relatedApp
    }
    
    /**
     * @return the relatedKeyField
     */
    public func getRelatedKeyField() -> String? {
        return self.relatedKeyField
    }
    
    /**
     * @param relatedKeyField the relatedKeyField to set
     */
    public func setRelatedKeyField(_ relatedKeyField: String?) {
        self.relatedKeyField = relatedKeyField
    }
    
    /**
     * @return the sort
     */
    public func getSort() -> String? {
        return self.sort
    }
    
    /**
     * @param sort the sort to set
     */
    public func setSort(_ sort: String?) {
        self.sort = sort
    }
    
//    public int hashCode() {
//    final int prime = 31;
//    int result = 1;
//    result = prime * result + ((fieldMappings == null) ? 0 : fieldMappings.hashCode());
//    result = prime * result + ((filterCond == null) ? 0 : filterCond.hashCode());
//    result = prime * result + ((lookupPickerFields == null) ? 0 : lookupPickerFields.hashCode());
//    result = prime * result + ((relatedApp == null) ? 0 : relatedApp.hashCode());
//    result = prime * result + ((relatedKeyField == null) ? 0 : relatedKeyField.hashCode());
//    return result;
//    }
    
    public func equals(_ obj: Any?) -> Bool {
        if (obj == nil) {
            return false;
        }
        if (!(obj is LookupItem)) {
            return false;
        }
        let other =  obj as! LookupItem
        if (self.fieldMappings.isEmpty) {
            if (!(other.fieldMappings.isEmpty)) {
                return false
            }
        } else if (!(self.fieldMappings == other.fieldMappings)) {
            return false
        }
            if (self.filterCond!.isEmpty) {
                if (!(other.filterCond!.isEmpty)) {
                return false
            }
        } else if (!(self.filterCond == other.filterCond)) {
            return false
        }
        if (self.lookupPickerFields.isEmpty) {
            if (!(other.lookupPickerFields.isEmpty)) {
                return false
            }
        } else if (!(self.lookupPickerFields == other.lookupPickerFields)) {
            return false
        }
        if (self.relatedApp == nil) {
            if (other.relatedApp != nil) {
                return false
            }
        } else if (!(self.relatedApp == other.relatedApp)) {
            return false
        }
        if (self.relatedKeyField == nil) {
            if (other.relatedKeyField != nil) {
                return false
            }
        } else if (!(self.relatedKeyField == other.relatedKeyField)) {
            return false
        }
        return true
    }
}
