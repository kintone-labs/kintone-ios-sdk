//
//  RowLayout.swift
//  kintone-ios-sdk
//

public class RowLayout: ItemLayout {
    private var fields: [FieldLayout]?
    
    public override init() {
        super.init()
        self.type = LayoutType.ROW
        self.fields = [FieldLayout]()
    }
    
    private enum CodingKeys: String, CodingKey {
        case fields
    }
   
    public func getFields() -> [FieldLayout]? {
        return self.fields
    }
   
    public func setFields(_ fields: [FieldLayout]?) {
        self.fields = fields
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fields = try container.decode([FieldLayout].self, forKey: .fields)
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(fields, forKey: .fields)
        try super.encode(to: encoder)
    }
}
