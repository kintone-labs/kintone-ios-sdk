// Copyright (c) 2018 Cybozu, Inc.

public class RelatedRecordsField: Field {
    internal var label: String?
    internal var noLabel: Bool?
    internal var referenceTable: ReferenceTable?
   
    enum RelatedRecordsFieldCodingKeys: CodingKey {
        case label
        case noLabel
        case referenceTable
    }
    
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.REFERENCE_TABLE
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RelatedRecordsFieldCodingKeys.self)
        self.label = try container.decode(String.self, forKey: RelatedRecordsFieldCodingKeys.label)
        self.noLabel = try container.decode(Bool.self, forKey: RelatedRecordsFieldCodingKeys.noLabel)
        self.referenceTable = try container.decode(ReferenceTable.self, forKey: RelatedRecordsFieldCodingKeys.referenceTable)
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: RelatedRecordsFieldCodingKeys.self)
        if(self.label != nil){
            try container.encode(self.label, forKey: RelatedRecordsFieldCodingKeys.label)
        }
        if(self.noLabel != nil){
            try container.encode(self.noLabel, forKey: RelatedRecordsFieldCodingKeys.noLabel)
        }
        if(self.referenceTable != nil){
            try container.encode(self.referenceTable, forKey: RelatedRecordsFieldCodingKeys.referenceTable)
        }
        try super.encode(to: encoder)
    }
   
    public func getLabel() -> String? {
        return self.label
    }
    
    public func setLabel(_ label: String?) {
        self.label = label
    }
    
    public func getNoLabel() -> Bool? {
        return self.noLabel
    }

    public func setNoLabel(_ noLabel: Bool?) {
        self.noLabel = noLabel
    }
    
    public func getReferenceTable() -> ReferenceTable? {
        return self.referenceTable
    }
    
    public func setReferenceTable(_ referenceTable: ReferenceTable?) {
        self.referenceTable = referenceTable
    }
}
