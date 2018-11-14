// Copyright (c) 2018 Cybozu, Inc.

open class FieldLayout: NSObject, Codable {
    private var type: String?
    private var code: String?
    private var elementId: String?
    private var label: String?
    private var size: FieldSize?
    
    public override init() {
        super.init()
    }

    open func getType() -> String? {
        return self.type
    }
   
    open func setType(_ type: String?) {
        self.type = type
    }
   
    open func getCode() -> String? {
        return self.code
    }
  
    open func setCode(_ code: String?) {
        self.code = code
    }
   
    open func getElementId() -> String? {
        return self.elementId
    }
  
    open func setElementId(_ elementId: String?) {
        self.elementId = elementId
    }
    
    open func getLabel() -> String? {
        return self.label;
    }
    
    open func setLabel(_ label: String?) {
        self.label = label
    }
   
    open func getSize() -> FieldSize? {
        return self.size
    }
   
    open func setSize(_ size: FieldSize?) {
        self.size = size
    }

    open func equals(_ obj: AnyObject? ) -> Bool? {
        if (obj == nil){
            return false
        }
        if (!(obj is FieldLayout)) {
            return false
        }
        let other = obj as! FieldLayout
        if (self.code!.isEmpty) {
            if (!(other.code!.isEmpty)){
                return false
            } else if (!(self.code == other.code)){
                return false
            }
        }
         return true
    }
}
