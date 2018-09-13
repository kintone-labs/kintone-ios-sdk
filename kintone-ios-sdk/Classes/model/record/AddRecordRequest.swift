//
//  AddRecordRequest.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/06.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

import UIKit

class AddRecordRequest: NSObject, Decodable {
    private var app: Int?
    private var record: [String: FieldValue]?
}
