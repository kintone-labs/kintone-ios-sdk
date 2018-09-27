//
//  SubTableLayout.swift
//  kintone-ios-sdk
//

public class SubTableLayout: ItemLayout {
    private var code: String?
    private var fields: [FieldLayout]?
    
    private enum CodingKeys: String, CodingKey {
        case fields
        case code
    }
   
    public override init() {
        super.init()
        self.type = LayoutType.SUBTABLE
    }
   
    public func getCode() -> String? {
        return self.code
    }
 
    public func setCode(_ code: String?) {
        self.code = code
    }
    
    public func getFields() -> [FieldLayout]? {
        return self.fields
    }
   
    public func setFields(_ fields: [FieldLayout]?) {
        self.fields = fields
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(String.self, forKey: SubTableLayout.CodingKeys.code)
        self.fields = try container.decode([FieldLayout].self, forKey: .fields)
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.code, forKey: SubTableLayout.CodingKeys.code)
        try container.encode(self.fields, forKey: SubTableLayout.CodingKeys.fields)
        try super.encode(to: encoder)
    }
}
