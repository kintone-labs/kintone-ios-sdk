//
//  UpsertRecordsTest.swift
//  kintone-ios-sdkTests
//
//  Created by k000607 on 8/29/19.
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
        let numberRecordToAdd = 100
        var recordsToAdd: [RecordUpsertItem] = []
        var i = 0
        while (i < numberRecordToAdd) {
            let recordUpsertItem = createRecordUpsertItemToAddData()
            var record = recordUpsertItem.getRecord()!
            record = addData(record, "SINGLE_LINE_TEXT", FieldType.SINGLE_LINE_TEXT, "test upsert records -> add")
            recordUpsertItem.setRecord(record)
            recordsToAdd.append(recordUpsertItem)
            i += 1
        }
        
        self.recordManagement?.upsertRecords(RecordTestConstants.APP_ID, recordsToAdd)
            .then { response in
                for items in response.getResults()! {
                    let addRecordsResponse = items as! [AddRecordsResponse]
                    for item in addRecordsResponse {
                        var expectID: Int = item.getIDs()?[0] ?? 0
                        for id in item.getIDs()! {
                            XCTAssert(id ==  expectID)
                            expectID += 1;
                        }
                    }
                    
                }
                let numberRecordToUpdate = 100
                var recordsToUpdate: [RecordUpsertItem] = []
                var i = 0
                while (i < numberRecordToUpdate) {
                    let recordUpsertItem = recordsToAdd[i]
                    var record = recordUpsertItem.getRecord()
                    record!.removeValue(forKey: "UPDATE_KEY")
                    record = self.addData(record!, "SINGLE_LINE_TEXT", FieldType.SINGLE_LINE_TEXT, "test upsert records -> update")
                    recordUpsertItem.setRecord(record)
                    recordsToUpdate.append(recordUpsertItem)
                    i += 1
                }
                self.recordManagement?.upsertRecords(RecordTestConstants.APP_ID, recordsToUpdate)
                    .then { response in
                        for items in response.getResults()! {
                            let updateRecordsResponse = items as! [UpdateRecordsResponse]
                            for item in updateRecordsResponse {
                                var expectID: Int = (item.getRecords()![0] as  RecordUpdateResponseItem).getID()!
                                for record in item.getRecords()! {
                                    XCTAssert(record.getID() ==  expectID)
                                    XCTAssert(record.getRevision()! ==  2)
                                    expectID += 1;
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
            }.catch{ error in
                var errorString = ""
                if (type(of: error) == BulksException.self) {
                    errorString = (error as! BulksException).getError()!
                } else {
                    errorString = error.localizedDescription
                }
                XCTFail(errorString)
        }
        XCTAssert(waitForPromises(timeout: 100))
    }
    
    func testUpsertRecordsFail() throws {
        let appId: Int = -99999
        let recordsToAdd: [RecordUpsertItem] = []
        self.recordManagement?.upsertRecords(appId, recordsToAdd)
            .then { response in
                XCTFail("No errors occurred")
            }.catch{ error in
                XCTAssert(type(of: error) == BulksException.self)
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
    
    private func createRecordUpsertItemToAddData() -> RecordUpsertItem {
        let uniquekey = self.getUniqueKey()
        let records = self.createAddData()
        let updateKey = RecordUpdateKey("UPDATE_KEY", uniquekey)
        let recordUpsertItem = RecordUpsertItem(updateKey, records)
        return recordUpsertItem
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
