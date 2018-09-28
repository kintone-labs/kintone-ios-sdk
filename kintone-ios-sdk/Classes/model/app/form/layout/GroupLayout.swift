// Copyright (c) 2018 Cybozu, Inc.

public class GroupLayout: ItemLayout {
    private var code: String?
    private var layout: [RowLayout]?
    
    private enum CodingKeys: String, CodingKey {
        case layout
        case code
    }
   
    public override init() {
        super.init()
        self.type = LayoutType.GROUP
        self.layout = [RowLayout]()
    }
    
    public func getCode() -> String? {
        return self.code
    }
   
    public func setCode(_ code: String?) {
        self.code = code
    }
    
    public func getLayout() -> [RowLayout]? {
        return self.layout
    }
  
    public func setLayout(_ layout: [RowLayout]?) {
        self.layout = layout
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.layout = try container.decode([RowLayout].self, forKey: GroupLayout.CodingKeys.layout)
        self.code = try container.decode(String.self, forKey: GroupLayout.CodingKeys.code)
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.layout, forKey: GroupLayout.CodingKeys.layout)
        try container.encode(self.code, forKey: GroupLayout.CodingKeys.code)
        try super.encode(to: encoder)
    }
    
}
