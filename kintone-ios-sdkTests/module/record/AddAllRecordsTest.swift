//
//  AddAllRecordsTest.swift
//  kintone-ios-sdkTests
//
//  Created by Ho Kim Cuc on 8/29/19.
//  Copyright © 2019 Cybozu. All rights reserved.
//

import XCTest
@testable import kintone_ios_sdk
@testable import Promises

class AddAllRecordsTest: XCTestCase {
    private let USERNAME = TestsConstants.ADMIN_USERNAME
    private let PASSWORD = TestsConstants.ADMIN_PASSWORD
    private let APP_ID = 1
    private let LANG = LanguageSetting.EN
    private var record: Record? = nil
    private var connection: Connection? = nil
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        var auth = Auth.init()
        auth = auth.setPasswordAuth(self.USERNAME, self.PASSWORD)
        self.connection = Connection(TestsConstants.DOMAIN, auth)
        self.record = Record(self.connection!)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAddAllRecordsSuccess()
    {
        let limitNumBulkPerRequest = 100
        let numberRecordToAdd = 2500;
        let numBulkRequest = 2;
        var recordsToAdd: [[String:FieldValue]] = []
        var i = 0
        while (i < numberRecordToAdd) {
            var record = createAddData()
            record = addData(record, "SINGLE_LINE_TEXT", FieldType.SINGLE_LINE_TEXT, "add record")
            recordsToAdd.append(record)
            i += 1
        }
        
        self.record?.addAllRecords(APP_ID, recordsToAdd).then{ addResponse in
            var numRequest = numberRecordToAdd / limitNumBulkPerRequest
            if (numberRecordToAdd % limitNumBulkPerRequest > 0) {
                numRequest += 1
            }
            XCTAssert(addResponse.getResults()?.count == numBulkRequest)
            for items in addResponse.getResults()! {
                let addRecordsResponse = items as! [AddRecordsResponse]
                for item in addRecordsResponse {
                    var expectID: Int = item.getIDs()?[0] ?? 0
                    for id in item.getIDs()! {
                        XCTAssert(id ==  expectID)
                        expectID += 1
                    }
                }
                
            }
        }.catch{ error in
                var errorString = ""
                if (type(of: error) == BulksException.self) {
                    errorString = (error as! BulksException).getError()!
                } else {
                    errorString = error.localizedDescription
                }
                XCTFail(errorString)
        }
        XCTAssert(waitForPromises(timeout: 50))
    }
    
    func testAddAllRecordsWhenAppIDNotExist() {
        let appId: Int = -99999
        self.record?.addAllRecords(appId, []).then{ response in
            XCTFail("No errors occurred")
        }.catch{ error in
            XCTAssert(type(of: error) == BulksException.self)
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
    
    private func createAddData() -> Dictionary<String, FieldValue> {
        var testRecord: Dictionary<String, FieldValue> = [:]
        
        // text type
        testRecord = addData(testRecord, "SINGLE_LINE_TEXT", FieldType.SINGLE_LINE_TEXT, "single line text add data")
        testRecord = addData(testRecord, "UPDATE_KEY", FieldType.SINGLE_LINE_TEXT, "")
        testRecord = addData(testRecord, "MULTI_LINE_TEXT", FieldType.MULTI_LINE_TEXT, "multi line text add data1\nmulti line text add data2")
        testRecord = addData(testRecord, "RICH_TEXT", FieldType.RICH_TEXT, "<div><strong>rich text test add</strong></div>")
        
        let uniqunum = arc4random() % 10
        testRecord = addData(testRecord, "NUMBER", FieldType.NUMBER, uniqunum.description)
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
