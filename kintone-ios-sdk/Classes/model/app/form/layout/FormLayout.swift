//
//  FormLayout.swift
//  kintone-ios-sdk
//

public class FormLayout: NSObject, Codable {
    private var revision: String?
    private var layout: [ItemLayout]?
    
    public override init() {
        super.init()
        self.layout = [ItemLayout]();
    }
  
    public func getRevision() -> String? {
        return self.revision
    }
  
    public func setRevision(_ revision: String?) {
        self.revision = revision
    }
  
    public func getLayout() -> [ItemLayout]? {
        return self.layout
    }
    
    public func setLayout(_ layout: [ItemLayout]?) {
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
        self.setRevision(try! container.decode(String.self, forKey: FormLayout.LayoutsKey.revision))
    }
}
