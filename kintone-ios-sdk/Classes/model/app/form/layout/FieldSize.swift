// Copyright (c) 2018 Cybozu, Inc.

open class FieldSize: NSObject, Codable {
    private var width: String?
    private var height: String?
    private var innerHeight: String?
    
    open func getWidth() -> String? {
        return self.width
    }
    
    open func setWidth(_ width: String?) {
        self.width = width
    }
  
    open func getHeight() -> String? {
        return self.height
    }
  
    open func setHeight(_ height: String?) {
        self.height = height
    }
    
    open func getInnerHeight() -> String? {
        return self.innerHeight
    }
    
    open func setInnerHeight(_ innerHeight: String?) {
        self.innerHeight = innerHeight;
    }
}
