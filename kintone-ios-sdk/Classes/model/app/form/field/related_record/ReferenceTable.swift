//
//  ReferenceTable.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class ReferenceTable: NSObject {
    private var condition: FieldMapping?
    private var filterCond: String?
    private var relatedApp: RelatedApp?
    private var size: Int?
    private var displayFields: [String]?
    private var sort: String?
    
    /**
     * default constructor
     */
    public override init() {
        self.displayFields = [String]()
    }
    

    public init(_ condition: FieldMapping?, _ filterCond: String?, _ relatedApp: RelatedApp?, _ size: Int?, _ displayFields: [String]?) {
        self.condition = condition
        self.filterCond = filterCond
        self.relatedApp = relatedApp
        self.size = size
        self.displayFields = displayFields
    }
    
    /**
     * @return the condition
     */
    public func getCondition() -> FieldMapping? {
        return self.condition
    }
    
    /**
     * @param condition the condition to set
     */
    public func setCondition(_ condition: FieldMapping?) {
        self.condition = condition
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
     * @return the size
     */
    public func getSize() -> Int? {
        return self.size
    }
    
    /**
     * @param size the size to set
     */
    public func setSize(_ size: Int?) {
        self.size = size
    }
    
    /**
     * @return the displayFields
     */
    public func getDisplayFields() -> [String]? {
        return self.displayFields
    }
    
    /**
     * @param displayFields the displayFields to set
     */
    public func setDisplayFields(_ displayFields: [String]?) {
        self.displayFields = displayFields
    }
    
    /**
     * @return the sort
     */
    public func getSort() -> String? {
        return self.sort;
    }
    
    /**
     * @param sort the sort to set
     */
    public func setSort(_ sort: String?) {
        self.sort = sort
    }
    
//    /* (non-Javadoc)
//     * @see java.lang.Object#hashCode()
//     */
//    @Override
//    public int hashCode() {
//    final int prime = 31;
//    int result = 1;
//    result = prime * result + ((condition == null) ? 0 : condition.hashCode());
//    result = prime * result + ((filterCond == null) ? 0 : filterCond.hashCode());
//    result = prime * result + ((relatedApp == null) ? 0 : relatedApp.hashCode());
//    return result;
//    }
    

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
