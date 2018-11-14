//
//  BulkRequestResponse.swift
//  kintone-ios-sdk
//
//  Created by h001218 on 2018/09/18.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

open class BulkRequestResponse: NSObject {
    private var results: Array<Any>? = []
    
    /// Get result
    ///
    /// - Returns: results
    open func getResults() -> Array<Any>? {
        return results;
    }
    
    
    /// Add response Object to the results.
    ///
    /// - Parameter responseObject: <#responseObject description#>
    open func addResponse(_ responseObject: Any) {
        self.results?.append(responseObject)
    }
}
