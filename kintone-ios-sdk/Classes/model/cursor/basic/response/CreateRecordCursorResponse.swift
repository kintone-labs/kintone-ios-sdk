//
//  CreateRecordCursorResponse.swift
//  kintone-ios-sdk
//
//  Created by Ho Kim Cuc on 8/15/19.
//  Copyright © 2019 Cybozu. All rights reserved.
//

open class CreateRecordCursorResponse: NSObject, Codable {
    private var id: String?
    private var totalCount: String?
    
    open func getId() -> String{
        return id!
    }
    open func setId(_ id: String?) {
        self.id = id
    }
    
    open func getTotalCount() -> Int{
        return Int(totalCount!) ?? 0
    }
    
    open func setTotalCount(_ totalCount: Int?){
        self.totalCount =  "\(String(describing: totalCount))"
    }
    
    public init(_ id: String?, _ totalCount: Int?) {
        super.init()
        self.setId(id)
        self.setTotalCount(totalCount)
    }
}
