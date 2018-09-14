//
//  GetRecordRequest.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/05.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

import UIKit

public class GetRecordRequest: NSObject, Codable {
    
    private var app: Int?
    private var id: Int?
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - app: the ID of kintone app
    ///   - id: the ID of record
    public init(app: Int?, id: Int?) {
        self.app = app
        self.id = id
    }
}
