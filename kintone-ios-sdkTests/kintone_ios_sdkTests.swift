//
//  kintone_ios_sdkTests.swift
//  kintone-ios-sdkTests
//
//  Created by y001112 on 2018/09/04.
//  Copyright © 2018年 y001112. All rights reserved.
//

import XCTest
@testable import kintone_ios_sdk
@testable import Promises

class kintone_ios_sdkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetRecordAsync() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var auth = Auth()
        auth = auth.setPasswordAuth("cybozu", "cybozu")
        let conn = Connection( "phienphamf1811-1.cybozu-dev.com", auth )
        conn.setProxy("dc-ty3-squid-1.cb.local", 3128)
        do {
            let recordModule = Record(conn)
//            let record = try recordModule.getRecord(9, 1)
//            print(record.getRecord())
            try recordModule.getRecordAsync(9, 1).then{ response in
                print(response.getRecord()?.count)
            }.catch { error in
                print(error)
//                let parseError = error as! KintoneAPIException
//                print(parseError.toString()!)
            }
            XCTAssert(waitForPromises(timeout: 5))
        } catch {
            print("Invalid Selection.")
        }

    }
    
    func testAddRecordAsync() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var auth = Auth()
        auth = auth.setPasswordAuth("cybozu", "cybozu")
        let conn = Connection( "phienphamf1811-1.cybozu-dev.com", auth )
        conn.setProxy("dc-ty3-squid-1.cb.local", 3128)
        var testData: Dictionary<String, FieldValue> = createAddData()
    
        do {
            let recordModule = Record(conn)
            try recordModule.addRecordAsync(9, testData).then{ response in
                print(response)
                }.catch { error in
                    print(error)
                }
            XCTAssert(waitForPromises(timeout: 5))
        } catch {
            print("Invalid Selection.")
        }
        
    }
    
    func testDeleteRecords() throws {
        var auth = Auth()
        auth = auth.setPasswordAuth("cybozu", "cybozu")
        let conn = Connection( "phienphamf1811-1.cybozu-dev.com", auth )
        conn.setProxy("dc-ty3-squid-1.cb.local", 3128)
        // create test data for delete
        let delRecord1 = createAddData()
        let recordModule = Record(conn)
        try recordModule.addRecordAsync(9, delRecord1).then{ addResponse in
            let delId = [addResponse.getId()!]
            return try recordModule.deleteRecords(9, delId)
        }
         XCTAssert(waitForPromises(timeout: 5))
    }
    
    func testUpdateRecordById() throws {
        // create test data for update
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var auth = Auth()
        auth = auth.setPasswordAuth("cybozu", "cybozu")
        let conn = Connection( "phienphamf1811-1.cybozu-dev.com", auth )
        conn.setProxy("dc-ty3-squid-1.cb.local", 3128)
        var updRecord = createAddData()
        let recordModule = Record(conn)
    
        try recordModule.addRecordAsync(9, updRecord).then{ addResponse -> Promise<UpdateRecordResponse> in
            let updRecNum = addResponse.getId()
            let updRivision = addResponse.getRevision()
            updRecord = self.addData(updRecord, "Text", FieldType.SINGLE_LINE_TEXT, "testUpdateRecordById")
            //try recordModule.updateRecordAsyncByID(9, updRecNum!, updRecord, updRivision)
            return try recordModule.updateRecordAsyncByID(9, updRecNum!, updRecord, updRivision)
            }.then { response in
                print(response)
            }
        XCTAssert(waitForPromises(timeout: 5))
       
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    private func createAddData() -> Dictionary<String, FieldValue> {
        var testRecord: Dictionary<String, FieldValue> = [:]
        // text type
        testRecord = addData(testRecord, "Text", FieldType.SINGLE_LINE_TEXT, "single line text add data")
        testRecord = addData(testRecord, "Text_Area", FieldType.MULTI_LINE_TEXT, "multi line text add data1\nmulti line text add data2")
        
        return testRecord
    }
    private func addData(_ recordData: Dictionary<String, FieldValue>, _ code: String, _ type: FieldType, _ value: Any) -> Dictionary<String, FieldValue> {
        
        var recData = recordData
        let field = FieldValue()
        field.setType(type)
        field.setValue(value)
        recData[code] = field
        return recData
    }

}
