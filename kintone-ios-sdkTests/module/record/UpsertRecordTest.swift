//
//  UpsertRecordTest.swift
//  kintone-ios-sdkTests
//
//  Created by k000607 on 8/30/19.
//  Copyright © 2019 Cybozu. All rights reserved.
//

import XCTest
@testable import kintone_ios_sdk
@testable import Promises

class UpsertRecordsTest: XCTestCase {
    var kintoneAuth: Auth?
    var connection: Connection?
    var app: App?
    var recordManagement: Record?
    
    override func setUp() {
        super.setUp()
        
        // set auth
        var auth = Auth()
        auth = auth.setPasswordAuth(TestsConstants.ADMIN_USERNAME, TestsConstants.ADMIN_PASSWORD)
        let conn = Connection(TestsConstants.DOMAIN, auth)
        // instance of Record class
        self.recordManagement = Record(conn)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func getErrorMessage(_ error: Any) -> String {
        if error is KintoneAPIException {
            return (error as! KintoneAPIException).toString()!
        }
        else {
            return (error as! Error).localizedDescription
        }
    }
    
    func testUpsertRecordsSuccess() throws {
        let uniqueKey = getUniqueKey()
        var updateKey: RecordUpdateKey = RecordUpdateKey("UPDATE_KEY", uniqueKey)
        var addRecord = createAddData()
        addRecord = addData(addRecord, "UPDATE_KEY", FieldType.SINGLE_LINE_TEXT, uniqueKey)
        addRecord = addData(addRecord, "SINGLE_LINE_TEXT", FieldType.SINGLE_LINE_TEXT, "test upsert record -> add")
        
        self.recordManagement?.upsertRecord(RecordTestConstants.APP_ID, updateKey , addRecord, nil).then{response in
            if let addResponse = response as? AddRecordResponse {
                let revision = addResponse.getRevision()
                updateKey = RecordUpdateKey("UPDATE_KEY", uniqueKey)
                var updateRecord: Dictionary<String, FieldValue> = [:]
                updateRecord = self.addData(updateRecord, "SINGLE_LINE_TEXT", FieldType.SINGLE_LINE_TEXT, "test upsert record -> update")
                self.recordManagement?.upsertRecord(RecordTestConstants.APP_ID, updateKey, updateRecord, nil).then{subResponse in
                    if let updateResponse = subResponse as? UpdateRecordResponse {
                        XCTAssertEqual(revision! + 1, updateResponse.getRevision())
                    }
                    }.catch {error in
                        XCTFail(self.getErrorMessage(error))
                }
            }
            }.catch{error in
                XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
    
    func testUpsertRecordsFail() throws {
        let appId: Int = -99999
        let uniqueKey = getUniqueKey()
        let updateKey: RecordUpdateKey = RecordUpdateKey("UPDATE_KEY", uniqueKey)
        var addRecord = createAddData()
        addRecord = addData(addRecord, "UPDATE_KEY", FieldType.SINGLE_LINE_TEXT, uniqueKey)
        addRecord = addData(addRecord, "SINGLE_LINE_TEXT", FieldType.SINGLE_LINE_TEXT, "test upsert record -> add")
        
        self.recordManagement?.upsertRecord(appId, updateKey, addRecord, nil)
            .then { response in
                XCTFail("No errors occurred")
            }.catch{ error in
                XCTAssert(type(of: error) == KintoneAPIException.self)
        }
        XCTAssert(waitForPromises(timeout: 5))

    }
    
    private func addData(_ recordData: Dictionary<String, FieldValue>, _ code: String, _ type: FieldType, _ value: Any) -> Dictionary<String, FieldValue> {
        var recData = recordData
        let field = FieldValue()
        field.setType(type)
        field.setValue(value)
        recData[code] = field
        return recData
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
    
    private func getUniqueKey() -> String {
        // create unique key
        let now = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        let uniquekey = formatter.string(from: now as Date) + (Int(arc4random_uniform(1000000000) + 1)).description
        return uniquekey
    }
}

