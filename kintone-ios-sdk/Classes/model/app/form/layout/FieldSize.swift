// Copyright (c) 2018 Cybozu, Inc.

public class FieldSize: NSObject, Codable {
    private var width: String?
    private var height: String?
    private var innerHeight: String?
    
    public func getWidth() -> String? {
        return self.width
    }
    
    public func setWidth(_ width: String?) {
        self.width = width
    }
  
    public func getHeight() -> String? {
        return self.height
    }
  
    public func setHeight(_ height: String?) {
        self.height = height
    }
    
    public func getInnerHeight() -> String? {
        return self.innerHeight
    }
    
    public func setInnerHeight(_ innerHeight: String?) {
        self.innerHeight = innerHeight;
    }
}
