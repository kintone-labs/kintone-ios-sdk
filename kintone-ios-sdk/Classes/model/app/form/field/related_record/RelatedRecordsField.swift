//
//  RelatedRecordsField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

import Foundation

public class RelatedRecordsField: Field {
    internal var label: String?
    internal var noLabel: Bool?
    internal var referenceTable: ReferenceTable?
    
    /**
     * @param code
     */
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.REFERENCE_TABLE
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
