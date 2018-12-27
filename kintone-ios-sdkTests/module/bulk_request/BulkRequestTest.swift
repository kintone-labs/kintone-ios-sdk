//
//  BulkRequestTest.swift
//  kintone-ios-sdkTests
//
//  Created by h001218 on 2018/10/01.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

import XCTest
@testable import kintone_ios_sdk
@testable import Promises

class BulkRequestTest: XCTestCase {

    private let USERNAME = BulkRequestTestConstants.USERNAME
    private let PASSWORD = BulkRequestTestConstants.PASSWORD
    private let DOMAIN = BulkRequestTestConstants.DOMAIN
    private let APP_ID = BulkRequestTestConstants.APP_ID
    
    private var bulkRequest: BulkRequest? = nil
    private var connection: Connection? = nil
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        var auth = Auth.init()
        auth = auth.setPasswordAuth(self.USERNAME, self.PASSWORD)
        self.connection = Connection(self.DOMAIN, auth)
        self.bulkRequest = BulkRequest(self.connection!)
    }
    
    override func tearDown() {
        // Put teardown code here. This method isz called after the invocation of each test method in the class.
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
    
    func testAddRecordSuccess() {
        var record: [String: FieldValue] = [:]
        
        let fv = FieldValue()
        fv.setType(FieldType.SINGLE_LINE_TEXT)
        fv.setValue("test_AddRecord")
        
        record["FieldCode1"] = fv
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record))
        
        self.bulkRequest?.execute().then{responses in
            let results: Array<Any>? = responses.getResults()
            print(123)
            print(results!)
            XCTAssertNotNil(results)
            XCTAssertEqual(1, results?.count)
            
            let result1: AddRecordResponse = (results![0] as! AddRecordResponse)
            XCTAssert(type(of: result1.getId()) == Int?.self)
            XCTAssert(type(of: result1.getRevision()) == Int?.self)
            XCTAssertEqual(1, result1.getRevision())
        }.catch{error in
            XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 50))
    }

    func testAddRecordSuccessWhenRecordNull() {
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, nil))
        self.bulkRequest?.execute().then{responses in
            let results: Array<Any>? = responses.getResults()
            
            XCTAssertNotNil(results)
            XCTAssertEqual(1, results?.count)
            
            let result1: AddRecordResponse = (results![0] as! AddRecordResponse)
            XCTAssert(type(of: result1.getId()) == Int?.self)
            XCTAssert(type(of: result1.getRevision()) == Int?.self)
            XCTAssertEqual(1, result1.getRevision())
        }.catch{error in
            XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 50))
    }
    
    func testAddRecordsSuccess() {
    
        var records: Array<[String: FieldValue]?> = [[:]]
        var record1: [String: FieldValue] = [:]
        var record2: [String: FieldValue] = [:]
        
        let fv = FieldValue()
        fv.setType(FieldType.SINGLE_LINE_TEXT)
        fv.setValue("test_AddRecords1")
        
        let fv2 = FieldValue()
        fv2.setType(FieldType.SINGLE_LINE_TEXT)
        fv2.setValue("test_AddRecords2")
        
        record1["FieldCode1"] = fv
        record2["FieldCode2"] = fv2
        
        records.append(record1)
        records.append(record2)
        records.append(nil)
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecords(APP_ID, records))
        self.bulkRequest?.execute().then{responses in
            let results: Array<Any>? = responses.getResults()
            
            XCTAssertNotNil(results)
            XCTAssertEqual(1, results?.count)
            
            let result1: AddRecordsResponse = (results![0] as! AddRecordsResponse)
            
            XCTAssertEqual(3, result1.getIDs()?.count)
            XCTAssert(type(of: result1.getIDs()?[0]) == Int?.self)
            XCTAssert(type(of: result1.getIDs()?[1]) == Int?.self)
            XCTAssert(type(of: result1.getIDs()?[2]) == Int?.self)
            XCTAssertEqual(3, result1.getRevisions()?.count)
            XCTAssert(type(of: result1.getRevisions()?[0]) == Int?.self)
            XCTAssert(type(of: result1.getRevisions()?[1]) == Int?.self)
            XCTAssert(type(of: result1.getRevisions()?[2]) == Int?.self)
            XCTAssertEqual(1, result1.getRevisions()?[0])
            XCTAssertEqual(1, result1.getRevisions()?[1])
            XCTAssertEqual(1, result1.getRevisions()?[2])
        }.catch{error in
            XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
    
    func testUpdateRecordByIdSuccess() {
    
        // Preprocessing
        var record_pre: [String: FieldValue] = [:]
        
        let fv_pre = FieldValue()
        fv_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv_pre.setValue("test_value")
        
        record_pre["FieldCode1"] = fv_pre
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(self.APP_ID, record_pre))
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(self.APP_ID, nil))
        self.bulkRequest?.execute().then{responses_pre -> Promise<BulkRequestResponse> in
            let results_pre: Array<Any>? = responses_pre.getResults()
            
            let result_pre: AddRecordResponse = (results_pre![0] as! AddRecordResponse)
            
            // Main Test processing
            let preId: Int = result_pre.getId()!
            self.bulkRequest = BulkRequest(self.connection!)
            var record: [String: FieldValue] = [:]
            
            let fv = FieldValue()
            fv.setType(FieldType.SINGLE_LINE_TEXT)
            fv.setValue("test_updateRecordById")
            
            record["FieldCode1"] = fv
            
            XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordByID(self.APP_ID, preId, record, 1))
            return (self.bulkRequest?.execute())!
        }.then{responses in
            let results: Array<Any>? = responses.getResults()
            
            XCTAssertNotNil(results)
            XCTAssertEqual(1, results?.count)
            
            let result1: UpdateRecordResponse = (results![0] as! UpdateRecordResponse)
            XCTAssert(type(of: result1.getRevision()) == Int?.self)
            XCTAssertEqual(2, result1.getRevision())
        }.catch{error in
            XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
    
    func testUpdateRecordByIdSuccessWhenRecordNull() {
        
        // Preprocessing
        var record_pre: [String: FieldValue] = [:]
        
        let fv_pre = FieldValue()
        fv_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv_pre.setValue("test_value")
        
        record_pre["FieldCode1"] = fv_pre
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        self.bulkRequest?.execute().then{responses_pre -> Promise<BulkRequestResponse> in
            let results_pre: Array<Any>? = responses_pre.getResults()
            
            let result_pre: AddRecordResponse = (results_pre![0] as! AddRecordResponse)
            
            // Main Test processing
            let preId: Int = result_pre.getId()!
            self.bulkRequest = BulkRequest(self.connection!)
            var record: [String: FieldValue] = [:]
            
            let fv = FieldValue()
            fv.setType(FieldType.SINGLE_LINE_TEXT)
            fv.setValue("test_updateRecordById_recordNull")
            
            record["FieldCode1"] = fv
            
            XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordByID(self.APP_ID, preId, nil, 1))
            return (self.bulkRequest?.execute())!
            
        }.then{responses in
            let results: Array<Any>? = responses.getResults()
            
            XCTAssertNotNil(results)
            XCTAssertEqual(1, results?.count)
            
            let result1: UpdateRecordResponse = (results![0] as! UpdateRecordResponse)
            XCTAssert(type(of: result1.getRevision()) == Int?.self)
            XCTAssertEqual(2, result1.getRevision())
        }.catch{error in
            XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 5))
    }

    func testUpdateRecordByIdSuccessWhenRevisionNull() {
        
        // Preprocessing
        var record_pre: [String: FieldValue] = [:]
        
        let fv_pre = FieldValue()
        fv_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv_pre.setValue("test_value")
        
        record_pre["FieldCode1"] = fv_pre
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        self.bulkRequest?.execute().then{responses_pre -> Promise<BulkRequestResponse> in
            let results_pre: Array<Any>? = responses_pre.getResults()
            
            let result_pre: AddRecordResponse = (results_pre![0] as! AddRecordResponse)
            
            // Main Test processing
            let preId: Int = result_pre.getId()!
            self.bulkRequest = BulkRequest(self.connection!)
            var record: [String: FieldValue] = [:]
            
            let fv = FieldValue()
            fv.setType(FieldType.SINGLE_LINE_TEXT)
            fv.setValue("test_updateRecordById_revisionNull")
            
            record["FieldCode1"] = fv
            
            XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordByID(self.APP_ID, preId, record, nil))
            return (self.bulkRequest?.execute())!
            
        }.then{responses in
            let results: Array<Any>? = responses.getResults()
            
            XCTAssertNotNil(results)
            XCTAssertEqual(1, results?.count)
            
            let result1: UpdateRecordResponse = (results![0] as! UpdateRecordResponse)
            XCTAssert(type(of: result1.getRevision()) == Int?.self)
            XCTAssertEqual(2, result1.getRevision())
        }.catch{error in
            XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
    
    func testUpdateRecordByUpdateKeySuccess() {
        
        // Preprocessing
        var record_pre: [String: FieldValue] = [:]
        
        let fv_pre1 = FieldValue()
        let fv_pre2 = FieldValue()
        fv_pre1.setType(FieldType.SINGLE_LINE_TEXT)
        
        let now = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        
        let unique_value = formatter.string(from: now as Date) + (Int(arc4random_uniform(100000000) + 1)).description
        
        fv_pre1.setValue(unique_value)
        record_pre["文字列__1行__0"] =  fv_pre1
        
        fv_pre2.setValue("test_value")
        record_pre["FieldCode1"] = fv_pre2
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        self.bulkRequest?.execute().then{responses_pre -> Promise<BulkRequestResponse> in
            // Main Test processing
            self.bulkRequest = BulkRequest(self.connection!)
            var record: [String: FieldValue] = [:]
            
            let fv = FieldValue()
            fv.setType(FieldType.SINGLE_LINE_TEXT)
            fv.setValue("test_updateRecordByUpdateKey")
            
            record["FieldCode1"] = fv
            
            let uKey: RecordUpdateKey = RecordUpdateKey("文字列__1行__0", unique_value)
            
            XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordByUpdateKey(self.APP_ID, uKey, record, 1))
            return (self.bulkRequest?.execute())!
        }.then{responses in
            let results: Array<Any>? = responses.getResults()
            
            XCTAssertNotNil(results)
            XCTAssertEqual(1, results?.count)
            
            let result1: UpdateRecordResponse = (results![0] as! UpdateRecordResponse)
            XCTAssert(type(of: result1.getRevision()) == Int?.self)
            XCTAssertEqual(2, result1.getRevision())
        }.catch{error in
            XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
    
    func testUpdateRecordByUpdateKeySuccessWhenRecordNull() {
        
        // Preprocessing
        var record_pre: [String: FieldValue] = [:]
        
        let fv_pre1 = FieldValue()
        let fv_pre2 = FieldValue()
        fv_pre1.setType(FieldType.SINGLE_LINE_TEXT)
        
        let now = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        
        let unique_value = formatter.string(from: now as Date) + (Int(arc4random_uniform(100000000) + 1)).description
        
        fv_pre1.setValue(unique_value)
        record_pre["文字列__1行__0"] =  fv_pre1
        
        fv_pre2.setValue("test_value")
        record_pre["FieldCode1"] = fv_pre2
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        self.bulkRequest?.execute().then{responses_pre -> Promise<BulkRequestResponse> in
            // Main Test processing
            self.bulkRequest = BulkRequest(self.connection!)
            
            let uKey: RecordUpdateKey = RecordUpdateKey("文字列__1行__0", unique_value)
            
            XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordByUpdateKey(self.APP_ID, uKey, nil, 1))
            return (self.bulkRequest?.execute())!
        }.then{responses in
            let results: Array<Any>? = responses.getResults()
            
            XCTAssertNotNil(results)
            XCTAssertEqual(1, results?.count)
            
            let result1: UpdateRecordResponse = (results![0] as! UpdateRecordResponse)
            XCTAssert(type(of: result1.getRevision()) == Int?.self)
            XCTAssertEqual(2, result1.getRevision())
        }.catch{error in
            XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
    
    func testUpdateRecordByUpdateKeySuccessWhenRevisionNull() {
        
        // Preprocessing
        var record_pre: [String: FieldValue] = [:]
        
        let fv_pre1 = FieldValue()
        let fv_pre2 = FieldValue()
        fv_pre1.setType(FieldType.SINGLE_LINE_TEXT)
        
        let now = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        
        let unique_value = formatter.string(from: now as Date) + (Int(arc4random_uniform(100000000) + 1)).description
        
        fv_pre1.setValue(unique_value)
        record_pre["文字列__1行__0"] =  fv_pre1
        
        fv_pre2.setValue("test_value")
        record_pre["FieldCode1"] = fv_pre2
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        self.bulkRequest?.execute().then{responses_pre -> Promise<BulkRequestResponse> in
            // Main Test processing
            self.bulkRequest = BulkRequest(self.connection!)
            var record: [String: FieldValue] = [:]
            
            let fv = FieldValue()
            fv.setType(FieldType.SINGLE_LINE_TEXT)
            fv.setValue("test_updateRecordByUpdateKey_revisionNull")
            
            record["FieldCode1"] = fv
            
            let uKey: RecordUpdateKey = RecordUpdateKey("文字列__1行__0", unique_value)
            
            XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordByUpdateKey(self.APP_ID, uKey, record, nil))
            return (self.bulkRequest?.execute())!
        }.then{responses in
            let results: Array<Any>? = responses.getResults()
            
            XCTAssertNotNil(results)
            XCTAssertEqual(1, results?.count)
            
            let result1: UpdateRecordResponse = (results![0] as! UpdateRecordResponse)
            XCTAssert(type(of: result1.getRevision()) == Int?.self)
            XCTAssertEqual(2, result1.getRevision())
        }.catch{error in
            XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
    
    func testUpdateRecordsSuccess() {
    
        // Preprocessing
        var records_pre: Array<[String: FieldValue]> = []
        var record1_pre: [String: FieldValue] = [:]
        var record2_pre: [String: FieldValue] = [:]
        var record3_pre: [String: FieldValue] = [:]
        var record4_pre: [String: FieldValue] = [:]
        var record5_pre: [String: FieldValue] = [:]
        var record6_pre: [String: FieldValue] = [:]
        
        let fv1_pre = FieldValue()
        fv1_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv1_pre.setValue("test_value1")
        
        let fv2_pre = FieldValue()
        fv2_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv2_pre.setValue("test_value2")
    
        let fv3_pre = FieldValue()
        fv3_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv3_pre.setValue("test_value3")
        
        let fv4_1_pre = FieldValue()
        fv4_1_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv4_1_pre.setValue("test_value4")
        let fv4_2_pre = FieldValue()
        fv4_2_pre.setType(FieldType.SINGLE_LINE_TEXT)
        
        let now = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        let unique_value_4_2 = formatter.string(from: now as Date) + (Int(arc4random_uniform(100000000) + 1)).description
        fv4_2_pre.setValue(unique_value_4_2)
        
        let fv5_1_pre = FieldValue()
        fv5_1_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv5_1_pre.setValue("test_value5")
        let fv5_2_pre = FieldValue()
        fv5_2_pre.setType(FieldType.SINGLE_LINE_TEXT)
        
        let now2 = NSDate()
        let unique_value_5_2 = formatter.string(from: now2 as Date) + (Int(arc4random_uniform(100000000) + 1)).description
        fv5_2_pre.setValue(unique_value_5_2)
    
        let fv6_1_pre = FieldValue()
        fv6_1_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv6_1_pre.setValue("test_value6")
        let fv6_2_pre = FieldValue()
        fv6_2_pre.setType(FieldType.SINGLE_LINE_TEXT)
        
        let now3 = NSDate()
        let unique_value_6_2 = formatter.string(from: now3 as Date) + (Int(arc4random_uniform(100000000) + 1)).description
        fv6_2_pre.setValue(unique_value_6_2)
    
        record1_pre["FieldCode1"] = fv1_pre
        record2_pre["FieldCode1"] = fv2_pre
        record3_pre["FieldCode1"] = fv3_pre
        record4_pre["FieldCode1"] = fv4_1_pre
        record4_pre["文字列__1行__0"] = fv4_2_pre
        record5_pre["FieldCode1"] = fv5_1_pre
        record5_pre["文字列__1行__0"] = fv5_2_pre
        record6_pre["FieldCode1"] = fv6_1_pre
        record6_pre["文字列__1行__0"] = fv6_2_pre

        records_pre.append(record1_pre)
        records_pre.append(record2_pre)
        records_pre.append(record3_pre)
        records_pre.append(record4_pre)
        records_pre.append(record5_pre)
        records_pre.append(record6_pre)
    
        var preId1: Int?
        var preId2: Int?
        var preId3: Int?
        var preId4: Int?
        var preId5: Int?
        var preId6: Int?
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecords(APP_ID, records_pre))
        self.bulkRequest?.execute().then{responses_pre -> Promise<BulkRequestResponse> in
            let results_pre: Array<Any>? = responses_pre.getResults()
            
            let result1_pre: AddRecordsResponse = (results_pre![0] as! AddRecordsResponse)
            
            // Main Test processing
            preId1 = (result1_pre.getIDs()?[0])!
            preId2 = (result1_pre.getIDs()?[1])!
            preId3 = (result1_pre.getIDs()?[2])!
            preId4 = (result1_pre.getIDs()?[3])!
            preId5 = (result1_pre.getIDs()?[4])!
            preId6 = (result1_pre.getIDs()?[5])!
            
            let uKey4: RecordUpdateKey = RecordUpdateKey("文字列__1行__0", unique_value_4_2)
            let uKey5: RecordUpdateKey = RecordUpdateKey("文字列__1行__0", unique_value_5_2)
            let uKey6: RecordUpdateKey = RecordUpdateKey("文字列__1行__0", unique_value_6_2)
            
            self.bulkRequest = BulkRequest(self.connection!)
            var record1: [String: FieldValue] = [:]
            var record2: [String: FieldValue] = [:]
            var record4: [String: FieldValue] = [:]
            var record5: [String: FieldValue] = [:]
            
            let fv1 = FieldValue()
            fv1.setType(FieldType.SINGLE_LINE_TEXT)
            fv1.setValue("test_updateRecords1")
            
            let fv2 = FieldValue()
            fv2.setType(FieldType.SINGLE_LINE_TEXT)
            fv2.setValue("test_updateRecords2")
            
            let fv4 = FieldValue()
            fv4.setType(FieldType.SINGLE_LINE_TEXT)
            fv4.setValue("test_updateRecords4")
            
            let fv5 = FieldValue()
            fv5.setType(FieldType.SINGLE_LINE_TEXT)
            fv5.setValue("test_updateRecords5")
            
            record1["FieldCode1"] = fv1
            record2["FieldCode1"] = fv2
            record4["FieldCode1"] = fv4
            record5["FieldCode1"] = fv5
            
            var records: Array<RecordUpdateItem> = []
            records.append(RecordUpdateItem(preId1, 1, nil, record1))
            records.append(RecordUpdateItem(preId2, nil, nil, record2))
            records.append(RecordUpdateItem(preId3, nil, nil, nil))
            records.append(RecordUpdateItem(nil, 1, uKey4, record4))
            records.append(RecordUpdateItem(nil, nil, uKey5, record5))
            records.append(RecordUpdateItem(nil, nil, uKey6, nil))
            
            XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecords(self.APP_ID, records))
            return (self.bulkRequest?.execute())!
        }.then{responses in
            let results: Array<Any>? = responses.getResults()
            
            XCTAssertNotNil(results)
            XCTAssertEqual(1, results?.count)
            
            let result1: UpdateRecordsResponse = (results![0] as! UpdateRecordsResponse)
            
            XCTAssertEqual(6, result1.getRecords()?.count)
            
            XCTAssert(type(of: (result1.getRecords()![0] as RecordUpdateResponseItem).getID()) == Int?.self)
            XCTAssert(type(of: (result1.getRecords()![1] as RecordUpdateResponseItem).getID()) == Int?.self)
            XCTAssert(type(of: (result1.getRecords()![2] as RecordUpdateResponseItem).getID()) == Int?.self)
            XCTAssert(type(of: (result1.getRecords()![3] as RecordUpdateResponseItem).getID()) == Int?.self)
            XCTAssert(type(of: (result1.getRecords()![4] as RecordUpdateResponseItem).getID()) == Int?.self)
            XCTAssert(type(of: (result1.getRecords()![5] as RecordUpdateResponseItem).getID()) == Int?.self)
            
            XCTAssertEqual(preId1, (result1.getRecords()![0] as RecordUpdateResponseItem).getID())
            XCTAssertEqual(preId2, (result1.getRecords()![1] as RecordUpdateResponseItem).getID())
            XCTAssertEqual(preId3, (result1.getRecords()![2] as RecordUpdateResponseItem).getID())
            XCTAssertEqual(preId4, (result1.getRecords()![3] as RecordUpdateResponseItem).getID())
            XCTAssertEqual(preId5, (result1.getRecords()![4] as RecordUpdateResponseItem).getID())
            XCTAssertEqual(preId6, (result1.getRecords()![5] as RecordUpdateResponseItem).getID())
            
            XCTAssert(type(of: (result1.getRecords()![0] as RecordUpdateResponseItem).getRevision()) == Int?.self)
            XCTAssert(type(of: (result1.getRecords()![1] as RecordUpdateResponseItem).getRevision()) == Int?.self)
            XCTAssert(type(of: (result1.getRecords()![2] as RecordUpdateResponseItem).getRevision()) == Int?.self)
            XCTAssert(type(of: (result1.getRecords()![3] as RecordUpdateResponseItem).getRevision()) == Int?.self)
            XCTAssert(type(of: (result1.getRecords()![4] as RecordUpdateResponseItem).getRevision()) == Int?.self)
            XCTAssert(type(of: (result1.getRecords()![5] as RecordUpdateResponseItem).getRevision()) == Int?.self)
            
            XCTAssertEqual(2, (result1.getRecords()![0] as RecordUpdateResponseItem).getRevision())
            XCTAssertEqual(2, (result1.getRecords()![1] as RecordUpdateResponseItem).getRevision())
            XCTAssertEqual(2, (result1.getRecords()![2] as RecordUpdateResponseItem).getRevision())
            XCTAssertEqual(2, (result1.getRecords()![3] as RecordUpdateResponseItem).getRevision())
            XCTAssertEqual(2, (result1.getRecords()![4] as RecordUpdateResponseItem).getRevision())
            XCTAssertEqual(2, (result1.getRecords()![5] as RecordUpdateResponseItem).getRevision())
        }.catch{error in
            XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
    
    func testDeleteRecordsSuccess() {
    
        // Preprocessing
        var records_pre: Array<[String: FieldValue]> = []
        var record1_pre: [String: FieldValue] = [:]
        var record2_pre: [String: FieldValue] = [:]
        
        let fv_pre = FieldValue()
        fv_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv_pre.setValue("test_value1")
        
        let fv2_pre = FieldValue()
        fv2_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv2_pre.setValue("test_value2")
        
        record1_pre["FieldCode1"] = fv_pre
        record2_pre["FieldCode1"] = fv2_pre
        
        records_pre.append(record1_pre)
        records_pre.append(record2_pre)
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecords(APP_ID, records_pre))
        self.bulkRequest?.execute().then{responses_pre -> Promise<BulkRequestResponse> in
            let results_pre: Array<Any>? = responses_pre.getResults()
            
            let result1_pre: AddRecordsResponse = (results_pre![0] as! AddRecordsResponse)
            
            // Main Test processing
            self.bulkRequest = BulkRequest(self.connection!)
            
            var ids: Array<Int> = []
            ids.append(result1_pre.getIDs()![0])
            ids.append(result1_pre.getIDs()![1])
            
            XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.deleteRecords(self.APP_ID, ids))
            return (self.bulkRequest?.execute())!
        }.then{responses in
            let results: Array<Any>? = responses.getResults()
            
            XCTAssertNotNil(results)
            XCTAssertEqual(1, results?.count)
            
            let result1: [String: String] = (results![0] as! [String: String])
            
            XCTAssertTrue(result1.isEmpty)
        }.catch{error in
            XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
    
    func testDeleteRecordsWithRevisionSuccess() {
        
        // Preprocessing
        var records_pre: Array<[String: FieldValue]> = []
        var record1_pre: [String: FieldValue] = [:]
        var record2_pre: [String: FieldValue] = [:]
        var record3_pre: [String: FieldValue] = [:]
        
        let fv_pre = FieldValue()
        fv_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv_pre.setValue("test_value1")
        
        let fv2_pre = FieldValue()
        fv2_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv2_pre.setValue("test_value2")
        
        let fv3_pre = FieldValue()
        fv3_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv3_pre.setValue("test_value3")
        
        record1_pre["FieldCode1"] = fv_pre
        record2_pre["FieldCode1"] = fv2_pre
        record3_pre["FieldCode1"] = fv3_pre
        
        records_pre.append(record1_pre)
        records_pre.append(record2_pre)
        records_pre.append(record3_pre)
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecords(APP_ID, records_pre))
        self.bulkRequest?.execute().then{responses_pre -> Promise<BulkRequestResponse> in
            let results_pre: Array<Any>? = responses_pre.getResults()
            
            let result1_pre: AddRecordsResponse = (results_pre![0] as! AddRecordsResponse)
            
            // Main Test processing
            self.bulkRequest = BulkRequest(self.connection!)
            
            var idsWithRevision: [Int: Int?]  = [:]
            idsWithRevision[result1_pre.getIDs()![0]] = 1
            idsWithRevision[result1_pre.getIDs()![1]] = nil
            idsWithRevision[result1_pre.getIDs()![2]] = -1
            
            XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.deleteRecordsWithRevision(self.APP_ID, idsWithRevision))
            return (self.bulkRequest?.execute())!
        }.then{responses in
            let results: Array<Any>? = responses.getResults()
            
            XCTAssertNotNil(results)
            XCTAssertEqual(1, results?.count)
            
            let result1: [String: String] = (results![0] as! [String: String])
            
            XCTAssertTrue(result1.isEmpty)
        }.catch{error in
            XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
    
    func testUpdateRecordAssigneesSuccess() {
        
        // Preprocessing
        var record_pre: [String: FieldValue] = [:]
        let fv_pre = FieldValue()
        
        fv_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv_pre.setValue("test_updateRecordAssignees")
        
        record_pre["FieldCode1"] = fv_pre
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        self.bulkRequest?.execute().then{responses_pre -> Promise<BulkRequestResponse> in
            let results_pre: Array<Any>? = responses_pre.getResults()
            
            let result_pre: AddRecordResponse = (results_pre![0] as! AddRecordResponse)
            
            // Main Test processing
            let preId: Int = result_pre.getId()!
            
            self.bulkRequest = BulkRequest(self.connection!)
            var assignees: Array<String> = []
            
            assignees.append("cybozu")
            
            XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordAssignees(self.APP_ID, preId, assignees, 1))
            return (self.bulkRequest?.execute())!
        }.then{responses in
            let results: Array<Any>? = responses.getResults()
            
            XCTAssertNotNil(results)
            XCTAssertEqual(1, results?.count)
            
            let result1: UpdateRecordResponse = (results![0] as! UpdateRecordResponse)
            
            XCTAssertEqual(2, result1.getRevision())
        }.catch{error in
            XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
    
    func testUpdateRecordAssigneesSuccessWhenRevisionNull() {
        
        // Preprocessing
        var record_pre: [String: FieldValue] = [:]
        let fv_pre = FieldValue()
        
        fv_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv_pre.setValue("test_updateRecordAssignees_revisionNull")
        
        record_pre["FieldCode1"] = fv_pre
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        self.bulkRequest?.execute().then{responses_pre -> Promise<BulkRequestResponse> in
            let results_pre: Array<Any>? = responses_pre.getResults()
            
            let result_pre: AddRecordResponse = (results_pre![0] as! AddRecordResponse)
            
            // Main Test processing
            let preId: Int = result_pre.getId()!
            
            self.bulkRequest = BulkRequest(self.connection!)
            var assignees: Array<String> = []
            
            assignees.append("cybozu")
            
            XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordAssignees(self.APP_ID, preId, assignees, nil))
            return (self.bulkRequest?.execute())!
        }.then{responses in
            let results: Array<Any>? = responses.getResults()
            
            XCTAssertNotNil(results)
            XCTAssertEqual(1, results?.count)
            
            let result1: UpdateRecordResponse = (results![0] as! UpdateRecordResponse)
            
            XCTAssertEqual(2, result1.getRevision())
        }.catch{error in
            XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
    
    func testUpdateRecordAssigneesSuccessWhenAssigneesNull() {
        
        // Preprocessing
        var record_pre: [String: FieldValue] = [:]
        let fv_pre = FieldValue()
        
        fv_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv_pre.setValue("test_updateRecordAssignees_assigneesNull")
        
        record_pre["FieldCode1"] = fv_pre
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        self.bulkRequest?.execute().then{responses_pre -> Promise<BulkRequestResponse> in
            let results_pre: Array<Any>? = responses_pre.getResults()
            
            let result_pre: AddRecordResponse = (results_pre![0] as! AddRecordResponse)
            
            // Main Test processing
            let preId: Int = result_pre.getId()!
            
            self.bulkRequest = BulkRequest(self.connection!)
            let assignees: Array<String> = []
            
            XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordAssignees(self.APP_ID, preId, assignees, -1))
            return (self.bulkRequest?.execute())!
        }.then{responses in
            let results: Array<Any>? = responses.getResults()
            
            XCTAssertNotNil(results)
            XCTAssertEqual(1, results?.count)
            
            let result1: UpdateRecordResponse = (results![0] as! UpdateRecordResponse)
            
            XCTAssertEqual(2, result1.getRevision())
        }.catch{error in
            XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
    
    func testUpdateRecordStatusSuccess() {
        
        // Preprocessing
        var record_pre: [String: FieldValue] = [:]
        let fv_pre = FieldValue()
        
        fv_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv_pre.setValue("test_updateRecordStatus")
        
        record_pre["FieldCode1"] = fv_pre
        var preId: Int?
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        self.bulkRequest?.execute().then{responses_pre -> Promise<BulkRequestResponse> in
            let results_pre: Array<Any>? = responses_pre.getResults()
            
            let result_pre: AddRecordResponse = (results_pre![0] as! AddRecordResponse)
            
            // Main Test processing
            preId = result_pre.getId()!
            
            self.bulkRequest = BulkRequest(self.connection!)
            
            XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordStatus(self.APP_ID, preId!, "処理開始", "cybozu", 1))
    
            return (self.bulkRequest?.execute())!
        }.then{responses in
            let results: Array<Any>? = responses.getResults()
            
            XCTAssertNotNil(results)
            XCTAssertEqual(1, results?.count)
            
            let result1: UpdateRecordResponse = (results![0] as! UpdateRecordResponse)
            
            XCTAssertEqual(3, result1.getRevision())
        }.catch{error in
            XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
    
    func testUpdateRecordStatusSuccessWhenRevisionNull() {
        
        // Preprocessing
        var record_pre: [String: FieldValue] = [:]
        let fv_pre = FieldValue()
        
        fv_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv_pre.setValue("test_updateRecordStatus_revisionNull")
        
        record_pre["FieldCode1"] = fv_pre
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        self.bulkRequest?.execute().then{responses_pre -> Promise<BulkRequestResponse> in
            let results_pre: Array<Any>? = responses_pre.getResults()
            
            let result_pre: AddRecordResponse = (results_pre![0] as! AddRecordResponse)
            
            // Main Test processing
            let preId: Int = result_pre.getId()!
            
            self.bulkRequest = BulkRequest(self.connection!)
            
            XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordStatus(self.APP_ID, preId, "処理開始", "cybozu", nil))
            return (self.bulkRequest?.execute())!
        }.then{responses in
            
            let results: Array<Any>? = responses.getResults()
            
            XCTAssertNotNil(results)
            XCTAssertEqual(1, results?.count)
            
            let result1: UpdateRecordResponse = (results![0] as! UpdateRecordResponse)
            
            XCTAssertEqual(3, result1.getRevision())
        }.catch{error in
            XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
    
    func testUpdateRecordStatusSuccessWhenAssigneesNull() {
        
        // Preprocessing
        var record_pre: [String: FieldValue] = [:]
        let fv_pre = FieldValue()
        
        fv_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv_pre.setValue("test_updateRecordStatus_AssigneesNull")
        
        record_pre["FieldCode1"] = fv_pre
        
        var preId: Int?
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        self.bulkRequest?.execute().then{responses_pre -> Promise<BulkRequestResponse> in
            let results_pre: Array<Any>? = responses_pre.getResults()
            
            let result_pre: AddRecordResponse = (results_pre![0] as! AddRecordResponse)
            
            preId = result_pre.getId()!
            self.bulkRequest = BulkRequest(self.connection!)
            
            XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordStatus(self.APP_ID, preId!, "処理開始", "cybozu", nil))
            return (self.bulkRequest?.execute())!
        }.then{_ -> Promise<BulkRequestResponse> in
            // Main Test processing
            self.bulkRequest = BulkRequest(self.connection!)
            
            XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordStatus(self.APP_ID, preId!, "レビューする", nil, nil))
            return (self.bulkRequest?.execute())!
        }.then{responses in
            let results: Array<Any>? = responses.getResults()
            
            XCTAssertNotNil(results)
            XCTAssertEqual(1, results?.count)
            
            let result1: UpdateRecordResponse = (results![0] as! UpdateRecordResponse)
            
            XCTAssertEqual(5, result1.getRevision())
        }.catch{error in
            XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
    
    func testUpdateRecordsStatusSuccess() {
        
        // Preprocessing
        var records_pre: Array<[String: FieldValue]> = []
        var record1_pre: [String: FieldValue] = [:]
        var record2_pre: [String: FieldValue] = [:]
        var record3_pre: [String: FieldValue] = [:]
        
        let fv_pre = FieldValue()
        fv_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv_pre.setValue("test_updateRecordsStatus1")
        
        let fv2_pre = FieldValue()
        fv2_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv2_pre.setValue("test_updateRecordsStatus2")
        
        let fv3_pre = FieldValue()
        fv3_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv3_pre.setValue("test_updateRecordsStatus3")
        
        record1_pre["FieldCode1"] = fv_pre
        record2_pre["FieldCode1"] = fv2_pre
        record3_pre["FieldCode1"] = fv3_pre
        
        records_pre.append(record1_pre)
        records_pre.append(record2_pre)
        records_pre.append(record3_pre)
        
        var results_pre: Array<Any>?
        var result1_pre: AddRecordsResponse?
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecords(APP_ID, records_pre))
        self.bulkRequest?.execute().then{responses_pre -> Promise<BulkRequestResponse> in
            results_pre = responses_pre.getResults()!
            
            result1_pre = (results_pre![0] as! AddRecordsResponse)
            
            // Main Test processing
            self.bulkRequest = BulkRequest(self.connection!)
            
            var rusi: Array<RecordUpdateStatusItem> = []
            rusi.append(RecordUpdateStatusItem("処理開始", "cybozu", result1_pre!.getIDs()?[0], 1))
            rusi.append(RecordUpdateStatusItem("処理開始", "cybozu", result1_pre!.getIDs()?[1], nil))
            rusi.append(RecordUpdateStatusItem("処理開始", "cybozu", result1_pre!.getIDs()?[2], -1))
            
            XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordsStatus(self.APP_ID, rusi))
            return (self.bulkRequest?.execute())!
        }.then{responses in
            let results: Array<Any>? = responses.getResults()
            
            XCTAssertNotNil(results)
            XCTAssertEqual(1, results?.count)
            
            let result1: UpdateRecordsResponse = (results![0] as! UpdateRecordsResponse)
            
            XCTAssertEqual(3, result1.getRecords()?.count)
            
            XCTAssert(type(of: (result1.getRecords()![0] as RecordUpdateResponseItem).getID()) == Int?.self)
            XCTAssert(type(of: (result1.getRecords()![1] as RecordUpdateResponseItem).getID()) == Int?.self)
            XCTAssert(type(of: (result1.getRecords()![2] as RecordUpdateResponseItem).getID()) == Int?.self)
            
            XCTAssertEqual(result1_pre!.getIDs()![0], (result1.getRecords()![0] as RecordUpdateResponseItem).getID())
            XCTAssertEqual(result1_pre!.getIDs()![1], (result1.getRecords()![1] as RecordUpdateResponseItem).getID())
            XCTAssertEqual(result1_pre!.getIDs()![2], (result1.getRecords()![2] as RecordUpdateResponseItem).getID())
            
            XCTAssertEqual(3, (result1.getRecords()![0] as RecordUpdateResponseItem).getRevision())
            XCTAssertEqual(3, (result1.getRecords()![1] as RecordUpdateResponseItem).getRevision())
            XCTAssertEqual(3, (result1.getRecords()![2] as RecordUpdateResponseItem).getRevision())
        }.catch{error in
            XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 5))
        
    }
    
    func testExcuteFail() {
        // Preprocessing
        self.bulkRequest?.execute().then{ response in
            XCTFail("Execute empty bulk")
        }.catch{error in
            XCTAssertTrue(true)
        }
    }
    
    func testExcuteFailWhenRequestOverFlow() {
    
        var record: [String: FieldValue] = [:]
        
        let fv = FieldValue()
        fv.setType(FieldType.SINGLE_LINE_TEXT)
        fv.setValue("test_AddRecord")
        
        record["FieldCode1"] = fv
    
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record))
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record))
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record))
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record))
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record))
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record))
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record))
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record))
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record))
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record))
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record))
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record))
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record))
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record))
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record))
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record))
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record))
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record))
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record))
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record))
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record))
        
        // Preprocessing
        self.bulkRequest?.execute().then{response in
            XCTFail("Bulk Request overflow running")
        }.catch{error in
            XCTAssertTrue(true)
        }
    }
    
    func testUpdateRecordFail() {
        
        var record_pre: [String: FieldValue] = [:]
        
        let fv_pre = FieldValue()
        fv_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv_pre.setValue("test_updateRecordFail1")
        
        record_pre["FieldCode1"] = fv_pre
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        self.bulkRequest?.execute().then{responses_pre -> Promise<BulkRequestResponse> in
            let results_pre: Array<Any>? = responses_pre.getResults()
            
            let result_pre: AddRecordResponse = (results_pre![0] as! AddRecordResponse)
            
            // Main Test processing
            let preId: Int = result_pre.getId()!
            
            self.bulkRequest = BulkRequest(self.connection!)
            
            var record1: [String: FieldValue] = [:]
            
            let fv1 = FieldValue()
            fv1.setType(FieldType.SINGLE_LINE_TEXT)
            fv1.setValue("test_updateRecordFail2")
            
            record1["FieldCode1"] = fv1
            XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(self.APP_ID, record1))
            
            var record2: [String: FieldValue] = [:]
            
            let fv2 = FieldValue()
            fv2.setType(FieldType.SINGLE_LINE_TEXT)
            fv2.setValue("test_updateRecordById")
            
            record2["FieldCode1"] = fv2
            XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordByID(self.APP_ID, preId, record2, 100))
            
            var record3: [String: FieldValue] = [:]
            
            let fv3 = FieldValue()
            fv3.setType(FieldType.SINGLE_LINE_TEXT)
            fv3.setValue("test_updateRecordFail3")
            
            record3["FieldCode1"] = fv3
            XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(self.APP_ID, record3))
            return (self.bulkRequest?.execute())!
        }.then{responses in
            XCTFail("No Error")
        }.catch{error in
            if error is KintoneAPIException {
                let er = (error as! KintoneAPIException).toString()!
                let exinfo = er.split(separator: ",")
                XCTAssertEqual("api_no: 2", exinfo[0].trimmingCharacters(in: .whitespaces))
                XCTAssertEqual("method: PUT", exinfo[1].trimmingCharacters(in: .whitespaces))
                XCTAssertEqual("api_name: /k/v1/record.json", exinfo[2].trimmingCharacters(in: .whitespaces))
                XCTAssertEqual("code: GAIA_CO02", exinfo[4].trimmingCharacters(in: .whitespaces))
                XCTAssertEqual("message: The revision is not the latest. Someone may update a record.", exinfo[5].trimmingCharacters(in: .whitespaces))
                XCTAssertEqual("status: Optional(409)", exinfo[6].trimmingCharacters(in: .whitespaces))
            }
            else {
                XCTFail(self.getErrorMessage(error))
            }
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
}
