// Copyright (c) 2018 Cybozu, Inc.

public class FieldLayout: NSObject, Codable {
    private var type: String?
    private var code: String?
    private var elementId: String?
    private var label: String?
    private var size: FieldSize?
    
    public override init() {
        super.init()
    }

    public func getType() -> String? {
        return self.type
    }
   
    public func setType(_ type: String?) {
        self.type = type
    }
   
    public func getCode() -> String? {
        return self.code
    }
  
    public func setCode(_ code: String?) {
        self.code = code
    }
   
    public func getElementId() -> String? {
        return self.elementId
    }
  
    public func setElementId(_ elementId: String?) {
        self.elementId = elementId
    }
    
    public func getLabel() -> String? {
        return self.label;
    }
    
    public func setLabel(_ label: String?) {
        self.label = label
    }
   
    public func getSize() -> FieldSize? {
        return self.size
    }
   
    public func setSize(_ size: FieldSize?) {
        self.size = size
    }

    public func equals(_ obj: AnyObject? ) -> Bool? {
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
