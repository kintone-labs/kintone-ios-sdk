//
//  FormFields.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/18/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class FormFields: NSObject, Codable {
    private var app: String?
    private var revision: String?
    private var properties: [String: Field]?
    
    public override init() {
        app = nil;
        revision = nil;
        properties = [String: Field]()
    }
    
    enum CodingKeys: CodingKey {
        case app
        case revision
        case properties
    }
    
    struct DynamicKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        init?(intValue: Int) {
            self.intValue = intValue
            stringValue = "\(intValue)"
        }
        static func key(named name: String) -> DynamicKeys? {
            return DynamicKeys(stringValue: name)
        }
    }
    
    public init(_ app: String?, _ properties: [String: Field]?, _ revision: String?) {
        super.init()
        self.app = app;
        self.revision = revision;
        self.properties = properties;
    }
    
    public func getApp() -> Int? {
        return Int(self.app!)
    }
   
    public func setApp(_ app: String?) {
        return self.app = app
    }
    
    public func getRevision() -> Int? {
        return  Int(self.revision!)
    }
    
    public func setRevision(_ revision: String? ) {
        self.revision = revision
    }
    
    public func getProperties() -> [String: Field]? {
        return self.properties
    }
    
    public func setProperties(_ properties: [String: Field]?) {
        self.properties = properties
    }
    
    required public init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.setApp(try container.decodeIfPresent(String.self, forKey: .app))
        self.setRevision(try container.decodeIfPresent(String.self, forKey: .revision))
        var properties = [String: Field]()
        
        let fields = try container.decode([String: Field].self, forKey: .properties)
        let nestedContainer = try container.nestedContainer(keyedBy: DynamicKeys.self, forKey:FormFields.CodingKeys.properties)
        for (key, field) in fields {
            switch field.getType()! {
            case .SINGLE_LINE_TEXT:
                let dynamicKey = DynamicKeys.key(named: key)
                let single_line = try nestedContainer.decodeIfPresent(SingleLineTextField.self, forKey: dynamicKey!)
                properties[key] = single_line
            default: break
            }
        }
        
        self.setProperties(properties)
    }
}
