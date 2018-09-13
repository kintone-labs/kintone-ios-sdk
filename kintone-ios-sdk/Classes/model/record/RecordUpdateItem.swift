//
//  RecordUpdateItem.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/06.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

import UIKit

class RecordUpdateItem: NSObject {
    private var id: Int?
    private var revision: Int?

    public init(id: Int?, revision: Int?) {
        self.id = id
        self.revision = revision
    }
}
