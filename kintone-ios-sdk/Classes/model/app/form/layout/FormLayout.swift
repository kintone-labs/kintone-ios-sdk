// Copyright (c) 2018 Cybozu, Inc.

open class FormLayout: NSObject, Codable {
    private var revision: String?
    private var layout: [ItemLayout]?
    
    public override init() {
        super.init()
        self.layout = [ItemLayout]()
    }
  
    open func getRevision() -> String? {
        return self.revision
    }
  
    open func setRevision(_ revision: String?) {
        self.revision = revision
    }
  
    open func getLayout() -> [ItemLayout]? {
        return self.layout
    }
    
    open func setLayout(_ layout: [ItemLayout]?) {
        self.layout = layout
    }
    
    enum LayoutsKey: CodingKey {
        case layout
        case revision
    }
    
    enum LayoutTypeKey: CodingKey {
        case type
    }
    
    required public init(from decoder: Decoder) throws {
        do {
            super.init()
            let container = try decoder.container(keyedBy: LayoutsKey.self)
            var layoutsArrayForType = try container.nestedUnkeyedContainer(forKey: LayoutsKey.layout)
            var layouts = [ItemLayout]()
            
            var layoutsArray = layoutsArrayForType
            while(!layoutsArray.isAtEnd)
            {
                let layout = try layoutsArrayForType.nestedContainer(keyedBy: LayoutTypeKey.self)
                let type = try layout.decode(LayoutType.self, forKey: LayoutTypeKey.type)
                switch type {
                case .ROW:
                    layouts.append(try layoutsArray.decode(RowLayout.self))
                case .SUBTABLE:
                    layouts.append(try layoutsArray.decode(SubTableLayout.self))
                case .GROUP:
                    layouts.append(try layoutsArray.decode(GroupLayout.self))
                }
            }
            self.setLayout(layouts)
            self.setRevision(try container.decode(String.self, forKey: FormLayout.LayoutsKey.revision))
        } catch {
            throw KintoneAPIException("Parse error")
        }
    }
}
