//
//  GetRecordCursorResponse.swift
//  kintone-ios-sdk
//
//  Created by Ho Kim Cuc on 8/15/19.
//  Copyright © 2019 Cybozu. All rights reserved.
//

open class GetRecordCursorResponse: NSObject,Codable {
    private var records: [[String:FieldValue]]?
    private var next: Bool?
    
    open func getRecords()->  [[String:FieldValue]] {
        return self.records ?? []
    }
    open func setRecords(_ records: [[String:FieldValue]]?){
        self.records = records ?? []
    }
    
    open func getNext()-> Bool {
        return self.next ?? false
    }
    open func setNext(_ next: Bool?) {
        self.next = next ?? false
    }

    public init(_ records: [[String:FieldValue]]?, _ next: Bool?) {
        super.init()
        self.setRecords(records)
        self.setNext(next)
    }
}
