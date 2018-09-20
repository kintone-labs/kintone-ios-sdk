//
//  AddCommentResponse.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/19.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

import UIKit

class AddCommentResponse: NSObject, Codable {
    
    private var id: Int?
    
    /// get the ID of comment
    ///
    /// - Returns: the ID of comment which have just created
    public func getId() -> Int? {
        return self.id;
    }

    /// set the ID of comment
    ///
    /// - Parameter id: the ID of comment which have just created
    public func setId(_ id: Int) {
        self.id = id;
    }

}
