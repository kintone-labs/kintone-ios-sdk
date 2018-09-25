//
//  GroupLayout.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/20/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class GroupLayout: ItemLayout {
    private var code: String?
    private var layout: [RowLayout]?
    
    private enum CodingKeys: String, CodingKey {
        case layout
        case code
    }
    /**
     * default constructor
     */
    public override init() {
        super.init()
        self.type = LayoutType.GROUP
        self.layout = [RowLayout]()
    }
    
    /**
     * @return the code
     */
    public func getCode() -> String? {
        return self.code
    }
    
    /**
     * @param code the code to set
     */
    public func setCode(_ code: String?) {
        self.code = code
    }
    
    /**
     * @return the layout
     */
    public func getLayout() -> [RowLayout]? {
        return self.layout
    }
    
    /**
     * @param layout the layout to set
     */
    public func setLayout(_ layout: [RowLayout]?) {
        self.layout = layout
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.layout = try container.decode([RowLayout].self, forKey: GroupLayout.CodingKeys.layout)
        self.code = try container.decode(String.self, forKey: GroupLayout.CodingKeys.code)
        try super.init(from: decoder)
    }
}
