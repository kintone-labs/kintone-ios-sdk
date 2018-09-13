//
//  kintone_ios_sdkTests.swift
//  kintone-ios-sdkTests
//
//  Created by y001112 on 2018/09/04.
//  Copyright © 2018年 y001112. All rights reserved.
//

import XCTest
@testable import kintone_ios_sdk

class kintone_ios_sdkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testYutaro() {
        print("hello,world")
        let req: GetRecordRequest = GetRecordRequest(app: 2, id: 1)
        let data = try! JSONEncoder().encode(req)
        let jsonString = String(data: data, encoding: String.Encoding.utf8)!
        print(jsonString)
        let jsonData = jsonString.data(using: .utf8)
        
        let req2 = try! JSONDecoder().decode(GetRecordRequest.self, from: jsonData!)
        print(req2)
        
        
        let importURL:URL = URL(fileURLWithPath: "/Users/y001112/Sources/kintone-ios-kintone/kintone-ios-sdk/Resources/testRecord.txt")
        do {
            let str = try String( contentsOf: importURL, encoding: String.Encoding.utf8 )
            let  getRecordResp = try! JSONDecoder().decode([String:FieldValue].self, from: str.data(using: .utf8)!)
            print(getRecordResp)
            let fv = getRecordResp["ユーザー選択"]?.value as! [Member]
            print(fv)
        } catch {
            print(error)
        }
        let type = FieldType.SINGLE_LINE_TEXT
        let fv2 = FieldValue()
        fv2.type = type
        let fvData = try! JSONEncoder().encode(fv2)
        let fvString = String(data: fvData, encoding: String.Encoding.utf8)
        print(fvString)
        
    }
}
