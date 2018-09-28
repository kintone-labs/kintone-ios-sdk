// Copyright (c) 2018 Cybozu, Inc.

public class ReferenceTable: NSObject, Codable {
    private var condition: FieldMapping?
    private var filterCond: String?
    private var relatedApp: RelatedApp?
    private var size: String?
    private var displayFields: [String]?
    private var sort: String?
    
    
    enum ReferenceTableCodingKeys: CodingKey {
        case condition
        case filterCond
        case relatedApp
        case size
        case displayFields
        case sort
    }
    
    public override init() {
        self.displayFields = [String]()
    }
    
    public init(_ condition: FieldMapping?, _ filterCond: String?, _ relatedApp: RelatedApp?, _ size: String?, _ displayFields: [String]?) {
        self.condition = condition
        self.filterCond = filterCond
        self.relatedApp = relatedApp
        self.size = size
        self.displayFields = displayFields
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ReferenceTableCodingKeys.self)
        self.condition = try container.decode(FieldMapping.self, forKey: ReferenceTableCodingKeys.condition)
        self.filterCond = try container.decode(String.self, forKey: ReferenceTableCodingKeys.filterCond)
        self.relatedApp = try container.decode(RelatedApp.self, forKey: ReferenceTableCodingKeys.relatedApp)
        self.size = try container.decode(String.self, forKey: ReferenceTableCodingKeys.size)
        self.displayFields = try container.decode([String].self, forKey: ReferenceTableCodingKeys.displayFields)
        self.sort = try container.decode(String.self, forKey: ReferenceTableCodingKeys.sort)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ReferenceTableCodingKeys.self)
        if(self.condition != nil){
            try container.encode(self.condition, forKey: ReferenceTableCodingKeys.condition)
        }
        if(self.filterCond != nil){
            try container.encode(self.filterCond, forKey: ReferenceTableCodingKeys.filterCond)
        }
        if(self.relatedApp != nil){
            try container.encode(self.relatedApp, forKey: ReferenceTableCodingKeys.relatedApp)
        }
        if(self.size != nil){
            try container.encode(self.size, forKey: ReferenceTableCodingKeys.size)
        }
        if(self.displayFields != nil){
            try container.encode(self.displayFields, forKey: ReferenceTableCodingKeys.displayFields)
        }
        if(self.sort != nil){
            try container.encode(self.sort, forKey: ReferenceTableCodingKeys.sort)
        }
    }
    
    public func getCondition() -> FieldMapping? {
        return self.condition
    }
    
    public func setCondition(_ condition: FieldMapping?) {
        self.condition = condition
    }
    
    public func getFilterCond() -> String? {
        return self.filterCond
    }
    
    public func setFilterCond(_ filterCond: String?) {
        self.filterCond = filterCond
    }
    
    public func getRelatedApp() -> RelatedApp? {
        return self.relatedApp
    }
    
    public func setRelatedApp(_ relatedApp: RelatedApp?) {
        self.relatedApp = relatedApp
    }
    
    public func getSize() -> Int? {
        return Int(self.size!)
    }
    
    public func setSize(_ size: String?) {
        self.size = size
    }
   
    public func getDisplayFields() -> [String]? {
        return self.displayFields
    }
    
    public func setDisplayFields(_ displayFields: [String]?) {
        self.displayFields = displayFields
    }
    
    public func getSort() -> String? {
        return self.sort;
    }
    
    public func setSort(_ sort: String?) {
        self.sort = sort
    }

    public func equals(_ obj: AnyObject?) -> Bool {
        if (obj == nil) {
            return false
        }
        if (!(obj is ReferenceTable)) {
            return false
        }
        let other = obj as! ReferenceTable
        if (self.condition == nil) {
            if (other.condition != nil) {
                return false
            }
        } else if (!(self.condition == other.condition)) {
            return false
        }
        if (self.filterCond == nil) {
            if (other.filterCond != nil) {
                return false
            }
        } else if (!(self.filterCond == other.filterCond)) {
            return false
        }
        if (self.relatedApp == nil) {
            if (other.relatedApp != nil) {
                return false
            }
        } else if (!(self.relatedApp == other.relatedApp)) {
            return false
        }
        return true
    }
}
