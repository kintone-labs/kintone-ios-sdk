// Copyright (c) 2018 Cybozu, Inc.

open class OptionData: NSObject, Codable {
    internal var index: String
    internal var label: String

    public init(_ index: String, _ label: String) {
        self.index = index
        self.label = label
    }
    
    open func getIndex() -> Int {
        return Int(self.index)!
    }
    
    open func setIndex(_ index: String) {
        self.index = index
    }
   
    open func getLabel() -> String {
        return self.label
    }
    
    open func setLabel(_ label: String) {
        self.label = label
    }
   
    open func equals(_ obj: AnyObject?) -> Bool {
        if (obj == nil) {
            return false
        }
        if (!(obj is OptionData)) {
            return false
        }
        let other = obj as! OptionData
        if (self.index != other.index) {
            return false
        }
        if (self.label.isEmpty) {
            if (other.label.isEmpty) {
                return false
            }
        } else if (!(self.label == other.label)) {
            return false
        }
        return true
    }
}
