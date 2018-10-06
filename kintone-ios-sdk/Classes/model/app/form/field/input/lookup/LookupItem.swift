// Copyright (c) 2018 Cybozu, Inc.

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
        do {
            let container = try decoder.container(keyedBy: LookupItemCodingKeys.self)
            self.fieldMappings = try container.decode([FieldMapping].self, forKey: LookupItemCodingKeys.fieldMappings)
            self.filterCond = try container.decode(String.self, forKey: LookupItemCodingKeys.filterCond)
            self.lookupPickerFields = try container.decode([String].self, forKey: LookupItemCodingKeys.lookupPickerFields)
            self.relatedApp = try container.decode(RelatedApp.self, forKey: LookupItemCodingKeys.relatedApp)
            self.relatedKeyField = try container.decode(String.self, forKey: LookupItemCodingKeys.relatedKeyField)
            self.sort = try container.decode(String.self, forKey: LookupItemCodingKeys.sort)
            super.init()
        } catch {
            throw KintoneAPIException("Encode error")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        do {
            var container = encoder.container(keyedBy: LookupItemCodingKeys.self)
            if(self.fieldMappings.count > 0){
                try container.encode(self.fieldMappings, forKey: LookupItemCodingKeys.fieldMappings)
            }
            if(self.filterCond != nil){
                try container.encode(self.filterCond, forKey: LookupItemCodingKeys.filterCond)
            }
            if(self.lookupPickerFields.count > 0){
                try container.encode(self.lookupPickerFields, forKey: LookupItemCodingKeys.lookupPickerFields)
            }
            if(self.relatedApp != nil){
                try container.encode(self.relatedApp, forKey: LookupItemCodingKeys.relatedApp)
            }
            if(self.relatedKeyField != nil){
                try container.encode(self.relatedKeyField, forKey: LookupItemCodingKeys.relatedKeyField)
            }
            if(self.sort != nil){
                try container.encode(self.sort, forKey: LookupItemCodingKeys.sort)
            }
        } catch {
            throw KintoneAPIException("Parse error")
        }
    }
    
    public func getFieldMapping() -> [FieldMapping] {
        return self.fieldMappings
    }
   
    public func setFieldMapping(_ fieldMapping: [FieldMapping]) {
        self.fieldMappings = fieldMapping
    }
    
    public func getFilterCond() -> String? {
        return self.filterCond
    }
    
    public func setFilterCond(_ filterCond: String?) {
        self.filterCond = filterCond
    }
    
    public func getLookupPickerFields() -> [String] {
        return self.lookupPickerFields;
    }
    
    public func setLookupPickerFields(_ lookupPickerFields: [String]) {
        self.lookupPickerFields = lookupPickerFields
    }
    
    public func getRelatedApp() -> RelatedApp? {
        return self.relatedApp
    }
    
    public func setRelatedApp(_ relatedApp: RelatedApp?) {
        self.relatedApp = relatedApp
    }
    
    public func getRelatedKeyField() -> String? {
        return self.relatedKeyField
    }
    
    public func setRelatedKeyField(_ relatedKeyField: String?) {
        self.relatedKeyField = relatedKeyField
    }
    
    public func getSort() -> String? {
        return self.sort
    }
    
    public func setSort(_ sort: String?) {
        self.sort = sort
    }
    
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
