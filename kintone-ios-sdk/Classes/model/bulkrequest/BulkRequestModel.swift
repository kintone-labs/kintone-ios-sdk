//
//  BulkRequestModel.swift
//  kintone-ios-sdk
//
//  Created by h001218 on 2018/09/17.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

open class BulkRequestModel: NSObject, Codable {
    private var requests: Array<BulkRequestItem>?
    
    open func getRequests() -> Array<BulkRequestItem>? {
        return self.requests
    }
    
    open func addRequest(_ bulkRequestItem: BulkRequestItem) {
        self.requests?.append(bulkRequestItem)
    }
    
    public override init() {
        self.requests = Array<BulkRequestItem>()
        super.init()
    }
}
