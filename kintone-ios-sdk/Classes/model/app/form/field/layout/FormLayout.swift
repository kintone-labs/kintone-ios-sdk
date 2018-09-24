//
//  FormLayout.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class FormLayout: NSObject, Codable {
    private var revision: String?
    private var layout: [ItemLayout]?
    
    /**
     * default constructor
     */
    public override init() {
        super.init()
        self.layout = [ItemLayout]();
    }
    
    /**
     * @return the revision
     */
    public func getRevision() -> String? {
        return self.revision
    }
    
    /**
     * @param revision the revision to set
     */
    public func setRevision(_ revision: String?) {
        self.revision = revision
    }
    
    /**
     * @return the layout
     */
    public func getLayout() -> [ItemLayout]? {
        return self.layout
    }
    
    /**
     * @param layout the layout to set
     */
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
        let container = try decoder.container(keyedBy: LayoutsKey.self)
        var layoutsArrayForType = try container.nestedUnkeyedContainer(forKey: LayoutsKey.layout)
        var layouts = [ItemLayout]()
        var layoutsArray = layoutsArrayForType
        print(layoutsArray)
        while(!layoutsArray.isAtEnd)
        {
            let layout = try layoutsArrayForType.nestedContainer(keyedBy: LayoutTypeKey.self)
            let type = try layout.decode(LayoutType.self, forKey: LayoutTypeKey.type)
            switch type {
            case .ROW:
                print("found row")
                layouts.append(try layoutsArray.decode(RowLayout.self))
            case .SUBTABLE:
                print("found subtable")
                 layouts.append(try layoutsArray.decode(SubTableLayout.self))
            case .GROUP:
                print("found group")
                layouts.append(try layoutsArray.decode(GroupLayout.self))
            }
        }
        self.layout = layouts
        self.revision = try container.decode(String.self, forKey: LayoutsKey.revision)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: LayoutsKey.self)
        for layoutItem in self.layout! {
            switch layoutItem.getType()! {
            case .ROW:
                print("encode row")
                try container.encode(layoutItem, forKey: LayoutsKey.layout)
            case .SUBTABLE:
                print("encode subtable")
                //try container.encode(layoutItem, forKey: LayoutsKey.layout)
            case .GROUP:
                print("encode group")
                //try container.encode(layoutItem, forKey: LayoutsKey.layout)
            }
        }
        if(self.revision != nil){
            try container.encode(revision, forKey: .revision)
        }
    }
}
