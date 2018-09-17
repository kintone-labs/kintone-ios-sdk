//
//  BulkRequestResponse.swift
//  kintone-ios-sdk
//
//  Created by h001218 on 2018/09/18.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

public class BulkRequestResponse: NSObject {
    private var results: Array<Any>? = []
    
    public func getResults() -> Array<Any>? {
        return results;
    }
    
    public func addResponse(responseObject: Any) {
        self.results?.append(responseObject)
    }
}
