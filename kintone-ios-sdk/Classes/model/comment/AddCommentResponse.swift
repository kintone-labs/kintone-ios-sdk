//
//  AddCommentResponse.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/19.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

public class AddCommentResponse: NSObject, Codable {
    
    private var id: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
    }
    
    public override init() {
    }
    
    /// get the ID of comment
    ///
    /// - Returns: the ID of comment which have just created
    public func getId() -> Int? {
        return self.id
    }

    /// set the ID of comment
    ///
    /// - Parameter id: the ID of comment which have just created
    public func setId(_ id: Int) {
        self.id = id
    }
    
    public required init(from decoder: Decoder) throws {
        do {
            let parser = RecordParser()
            let response = try parser.parseJsonToAddCommentResponse(decoder)
            self.id = response.getId()
        }
    }

}
