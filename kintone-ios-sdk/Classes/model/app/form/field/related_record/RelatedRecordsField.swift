//
//  RelatedRecordsField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class RelatedRecordsField: Field {
    internal var label: String?
    internal var noLabel: Bool?
    internal var referenceTable: ReferenceTable?
   
    enum RelatedRecordsFieldCodingKeys: CodingKey {
        case label
        case noLabel
        case referenceTable
    }
    /**
     * @param code
     */
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
    
    /**
     * @return the label
     */
    public func getLabel() -> String? {
        return self.label
    }
    
    /**
     * @param label the label to set
     */
    public func setLabel(_ label: String?) {
        self.label = label
    }
    
    /**
     * @return the noLabel
     */
    public func getNoLabel() -> Bool? {
        return self.noLabel
    }
    
    /**
     * @param noLabel the noLabel to set
     */
    public func setNoLabel(_ noLabel: Bool?) {
        self.noLabel = noLabel
    }
    
    /**
     * @return the referenceTable
     */
    public func getReferenceTable() -> ReferenceTable? {
        return self.referenceTable
    }
    
    /**
     * @param referenceTable the referenceTable to set
     */
    public func setReferenceTable(_ referenceTable: ReferenceTable?) {
        self.referenceTable = referenceTable
    }
}
