//
//  BulksException.swift
//  kintone-ios-sdk
//
//  Created by Ho Kim Cuc on 8/29/19.
//  Copyright © 2019 Cybozu. All rights reserved.
//
import Foundation
open class BulksException: Error {
    private var results: [Any] = [];
    
    open func getResults() -> [Any]{
        return self.results;
    }

    open func getBulkErrorIndex() -> Int? {
        for i in 0..<results.count {
            if (type(of: results[i]) == KintoneAPIException.self) {
                return (i + 1)
            }
        }
        return nil
    }
    
    open func getError() -> String? {
        for item in results {
            if (type(of: item) == KintoneAPIException.self) {
                let error:KintoneAPIException = item as! KintoneAPIException
                return error.toString()
            }
        }
        return nil
    }
    
    public init(_ results: [Any]? = []) {
        self.results = results!
    }
    
}