//
//  GetRecordCursorRequest.swift
//  kintone-ios-sdk
//
//  Created by Ho Kim Cuc on 8/15/19.
//  Copyright © 2019 Cybozu. All rights reserved.
//

open class GetRecordCursorRequest: NSObject, Codable {
    private var id: String?
    public init(_ id: String?) {
        super.init()
        self.id = id
    }
}
