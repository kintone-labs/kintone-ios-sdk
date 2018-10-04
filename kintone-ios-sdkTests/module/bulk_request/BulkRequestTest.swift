//
//  BulkRequestTest.swift
//  kintone-ios-sdkTests
//
//  Created by h001218 on 2018/10/01.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

import XCTest
@testable import kintone_ios_sdk

class BulkRequestTest: XCTestCase {
    
    private let DOMAIN = "https://syscon.cybozu.com"
    private let USERNAME = "hiroyuki-sekiyama"
    private let PASSWORD = "2`G`ZadF"
    private let PROXY_HOST = "10.224.136.41"
    private let PROXY_PORT = 3128
    
    private let APP_ID = 1678
    
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
    
    func testAddRecordSuccess() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        var record: [String: FieldValue] = [:]
        
        let fv = FieldValue()
        fv.setType(FieldType.SINGLE_LINE_TEXT)
        fv.setValue("test_AddRecord")
        
        record["FieldCode1"] = fv
        
        var responses: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record))
        XCTAssertNoThrow(responses = (try self.bulkRequest?.execute())!)
        
        let results: Array<Any>? = responses?.getResults()
        
        XCTAssertNotNil(results)
        XCTAssertEqual(1, results?.count)
        
        let result1: AddRecordResponse = (results![0] as! AddRecordResponse)
        XCTAssert(type(of: result1.getId()) == Int?.self)
        XCTAssert(type(of: result1.getRevision()) == Int?.self)
        XCTAssertEqual(1, result1.getRevision())
    }

    func testAddRecordSuccessWhenRecordNull() {
    
        var responses: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, nil))
        XCTAssertNoThrow(responses = (try self.bulkRequest?.execute())!)
        
        let results: Array<Any>? = responses?.getResults()
        
        XCTAssertNotNil(results)
        XCTAssertEqual(1, results?.count)
        
        let result1: AddRecordResponse = (results![0] as! AddRecordResponse)
        XCTAssert(type(of: result1.getId()) == Int?.self)
        XCTAssert(type(of: result1.getRevision()) == Int?.self)
        XCTAssertEqual(1, result1.getRevision())
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
        
        var responses: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecords(APP_ID, records))
        XCTAssertNoThrow(responses = (try self.bulkRequest?.execute())!)
        
        let results: Array<Any>? = responses?.getResults()
        
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
    }
    
    func testUpdateRecordByIdSuccess() {
    
        // Preprocessing
        var record_pre: [String: FieldValue] = [:]
        
        let fv_pre = FieldValue()
        fv_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv_pre.setValue("test_value")
        
        record_pre["FieldCode1"] = fv_pre
        
        var responses_pre: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        XCTAssertNoThrow(responses_pre = (try self.bulkRequest?.execute())!)
        
        let results_pre: Array<Any>? = responses_pre?.getResults()
        
        let result_pre: AddRecordResponse = (results_pre![0] as! AddRecordResponse)
        
        // Main Test processing
        let preId: Int = result_pre.getId()!
        self.bulkRequest = BulkRequest(self.connection!)
        var record: [String: FieldValue] = [:]
        
        let fv = FieldValue()
        fv.setType(FieldType.SINGLE_LINE_TEXT)
        fv.setValue("test_updateRecordById")
        
        record["FieldCode1"] = fv
        
        var responses: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordByID(APP_ID, preId, record, 1))
        XCTAssertNoThrow(responses = (try self.bulkRequest?.execute())!)
        
        let results: Array<Any>? = responses?.getResults()
        
        XCTAssertNotNil(results)
        XCTAssertEqual(1, results?.count)
        
        let result1: UpdateRecordResponse = (results![0] as! UpdateRecordResponse)
        XCTAssert(type(of: result1.getRevision()) == Int?.self)
        XCTAssertEqual(2, result1.getRevision())
    }
    
    func testUpdateRecordByIdSuccessWhenRecordNull() {
        
        // Preprocessing
        var record_pre: [String: FieldValue] = [:]
        
        let fv_pre = FieldValue()
        fv_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv_pre.setValue("test_value")
        
        record_pre["FieldCode1"] = fv_pre
        
        var responses_pre: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        XCTAssertNoThrow(responses_pre = (try self.bulkRequest?.execute())!)
        
        let results_pre: Array<Any>? = responses_pre?.getResults()
        
        let result_pre: AddRecordResponse = (results_pre![0] as! AddRecordResponse)
        
        // Main Test processing
        let preId: Int = result_pre.getId()!
        self.bulkRequest = BulkRequest(self.connection!)
        var record: [String: FieldValue] = [:]
        
        let fv = FieldValue()
        fv.setType(FieldType.SINGLE_LINE_TEXT)
        fv.setValue("test_updateRecordById_recordNull")
        
        record["FieldCode1"] = fv
        
        var responses: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordByID(APP_ID, preId, nil, 1))
        XCTAssertNoThrow(responses = (try self.bulkRequest?.execute())!)
        
        let results: Array<Any>? = responses?.getResults()
        
        XCTAssertNotNil(results)
        XCTAssertEqual(1, results?.count)
        
        let result1: UpdateRecordResponse = (results![0] as! UpdateRecordResponse)
        XCTAssert(type(of: result1.getRevision()) == Int?.self)
        XCTAssertEqual(2, result1.getRevision())
    }

    func testUpdateRecordByIdSuccessWhenRevisionNull() {
        
        // Preprocessing
        var record_pre: [String: FieldValue] = [:]
        
        let fv_pre = FieldValue()
        fv_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv_pre.setValue("test_value")
        
        record_pre["FieldCode1"] = fv_pre
        
        var responses_pre: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        XCTAssertNoThrow(responses_pre = (try self.bulkRequest?.execute())!)
        
        let results_pre: Array<Any>? = responses_pre?.getResults()
        
        let result_pre: AddRecordResponse = (results_pre![0] as! AddRecordResponse)
        
        // Main Test processing
        let preId: Int = result_pre.getId()!
        self.bulkRequest = BulkRequest(self.connection!)
        var record: [String: FieldValue] = [:]
        
        let fv = FieldValue()
        fv.setType(FieldType.SINGLE_LINE_TEXT)
        fv.setValue("test_updateRecordById_revisionNull")
        
        record["FieldCode1"] = fv
        
        var responses: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordByID(APP_ID, preId, record, nil))
        XCTAssertNoThrow(responses = (try self.bulkRequest?.execute())!)
        
        let results: Array<Any>? = responses?.getResults()
        
        XCTAssertNotNil(results)
        XCTAssertEqual(1, results?.count)
        
        let result1: UpdateRecordResponse = (results![0] as! UpdateRecordResponse)
        XCTAssert(type(of: result1.getRevision()) == Int?.self)
        XCTAssertEqual(2, result1.getRevision())
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
        
        var responses_pre: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        XCTAssertNoThrow(responses_pre = (try self.bulkRequest?.execute())!)
        
        // Main Test processing
        self.bulkRequest = BulkRequest(self.connection!)
        var record: [String: FieldValue] = [:]
        
        let fv = FieldValue()
        fv.setType(FieldType.SINGLE_LINE_TEXT)
        fv.setValue("test_updateRecordByUpdateKey")
        
        record["FieldCode1"] = fv
        
        var responses: BulkRequestResponse? = nil
        
        let uKey: RecordUpdateKey = RecordUpdateKey("文字列__1行__0", unique_value)
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordByUpdateKey(APP_ID, uKey, record, 1))
        XCTAssertNoThrow(responses = (try self.bulkRequest?.execute())!)
        
        let results: Array<Any>? = responses?.getResults()
        
        XCTAssertNotNil(results)
        XCTAssertEqual(1, results?.count)
        
        let result1: UpdateRecordResponse = (results![0] as! UpdateRecordResponse)
        XCTAssert(type(of: result1.getRevision()) == Int?.self)
        XCTAssertEqual(2, result1.getRevision())
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
        
        var responses_pre: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        XCTAssertNoThrow(responses_pre = (try self.bulkRequest?.execute())!)
        
        // Main Test processing
        self.bulkRequest = BulkRequest(self.connection!)
        
        var responses: BulkRequestResponse? = nil
        
        let uKey: RecordUpdateKey = RecordUpdateKey("文字列__1行__0", unique_value)
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordByUpdateKey(APP_ID, uKey, nil, 1))
        XCTAssertNoThrow(responses = (try self.bulkRequest?.execute())!)
        
        let results: Array<Any>? = responses?.getResults()
        
        XCTAssertNotNil(results)
        XCTAssertEqual(1, results?.count)
        
        let result1: UpdateRecordResponse = (results![0] as! UpdateRecordResponse)
        XCTAssert(type(of: result1.getRevision()) == Int?.self)
        XCTAssertEqual(2, result1.getRevision())
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
        
        var responses_pre: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        XCTAssertNoThrow(responses_pre = (try self.bulkRequest?.execute())!)
        
        // Main Test processing
        self.bulkRequest = BulkRequest(self.connection!)
        var record: [String: FieldValue] = [:]
        
        let fv = FieldValue()
        fv.setType(FieldType.SINGLE_LINE_TEXT)
        fv.setValue("test_updateRecordByUpdateKey_revisionNull")
        
        record["FieldCode1"] = fv
        
        var responses: BulkRequestResponse? = nil
        
        let uKey: RecordUpdateKey = RecordUpdateKey("文字列__1行__0", unique_value)
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordByUpdateKey(APP_ID, uKey, record, nil))
        XCTAssertNoThrow(responses = (try self.bulkRequest?.execute())!)
        
        let results: Array<Any>? = responses?.getResults()
        
        XCTAssertNotNil(results)
        XCTAssertEqual(1, results?.count)
        
        let result1: UpdateRecordResponse = (results![0] as! UpdateRecordResponse)
        XCTAssert(type(of: result1.getRevision()) == Int?.self)
        XCTAssertEqual(2, result1.getRevision())
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
    
        var responses_pre: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecords(APP_ID, records_pre))
        XCTAssertNoThrow(responses_pre = (try self.bulkRequest?.execute())!)
        
        let results_pre: Array<Any>? = responses_pre?.getResults()
        
        let result1_pre: AddRecordsResponse = (results_pre![0] as! AddRecordsResponse)
        
        // Main Test processing
        let preId1: Int = (result1_pre.getIDs()?[0])!
        let preId2: Int = (result1_pre.getIDs()?[1])!
        let preId3: Int = (result1_pre.getIDs()?[2])!
        let preId4: Int = (result1_pre.getIDs()?[3])!
        let preId5: Int = (result1_pre.getIDs()?[4])!
        let preId6: Int = (result1_pre.getIDs()?[5])!
        
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
        
        var responses: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecords(APP_ID, records))
        XCTAssertNoThrow(responses = (try self.bulkRequest?.execute())!)
        
        let results: Array<Any>? = responses?.getResults()
        
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
        
        var responses_pre: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecords(APP_ID, records_pre))
        XCTAssertNoThrow(responses_pre = (try self.bulkRequest?.execute())!)
        
        let results_pre: Array<Any>? = responses_pre?.getResults()
        
        let result1_pre: AddRecordsResponse = (results_pre![0] as! AddRecordsResponse)
        
        // Main Test processing
        self.bulkRequest = BulkRequest(self.connection!)
        
        var ids: Array<Int> = []
        ids.append(result1_pre.getIDs()![0])
        ids.append(result1_pre.getIDs()![1])
        
        var responses: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.deleteRecords(APP_ID, ids))
        XCTAssertNoThrow(responses = (try self.bulkRequest?.execute())!)
        
        let results: Array<Any>? = responses?.getResults()
        
        XCTAssertNotNil(results)
        XCTAssertEqual(1, results?.count)
        
        let result1: [String: String] = (results![0] as! [String: String])
        
        XCTAssertTrue(result1.isEmpty)
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
        
        var responses_pre: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecords(APP_ID, records_pre))
        XCTAssertNoThrow(responses_pre = (try self.bulkRequest?.execute())!)
        
        let results_pre: Array<Any>? = responses_pre?.getResults()
        
        let result1_pre: AddRecordsResponse = (results_pre![0] as! AddRecordsResponse)
        
        // Main Test processing
        self.bulkRequest = BulkRequest(self.connection!)
        
        var idsWithRevision: [Int: Int?]  = [:]
        idsWithRevision[result1_pre.getIDs()![0]] = 1
        idsWithRevision[result1_pre.getIDs()![1]] = nil
        idsWithRevision[result1_pre.getIDs()![2]] = -1
        
        var responses: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.deleteRecordsWithRevision(APP_ID, idsWithRevision))
        XCTAssertNoThrow(responses = (try self.bulkRequest?.execute())!)
        
        let results: Array<Any>? = responses?.getResults()
        
        XCTAssertNotNil(results)
        XCTAssertEqual(1, results?.count)
        
        let result1: [String: String] = (results![0] as! [String: String])
        
        XCTAssertTrue(result1.isEmpty)
    }
    
    func testUpdateRecordAssigneesSuccess() {
        
        // Preprocessing
        var record_pre: [String: FieldValue] = [:]
        let fv_pre = FieldValue()
        
        fv_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv_pre.setValue("test_updateRecordAssignees")
        
        record_pre["FieldCode1"] = fv_pre
        
        var responses_pre: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        XCTAssertNoThrow(responses_pre = (try self.bulkRequest?.execute())!)
        
        let results_pre: Array<Any>? = responses_pre?.getResults()
        
        let result_pre: AddRecordResponse = (results_pre![0] as! AddRecordResponse)
        
        // Main Test processing
        let preId: Int = result_pre.getId()!
        
        self.bulkRequest = BulkRequest(self.connection!)
        var assignees: Array<String> = []
        
        assignees.append("yutaro-suzuki")
        
        var responses: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordAssignees(APP_ID, preId, assignees, 1))
        XCTAssertNoThrow(responses = (try self.bulkRequest?.execute())!)
        
        let results: Array<Any>? = responses?.getResults()
        
        XCTAssertNotNil(results)
        XCTAssertEqual(1, results?.count)
        
        let result1: UpdateRecordResponse = (results![0] as! UpdateRecordResponse)
        
        XCTAssertEqual(2, result1.getRevision())
    }
    
    func testUpdateRecordAssigneesSuccessWhenRevisionNull() {
        
        // Preprocessing
        var record_pre: [String: FieldValue] = [:]
        let fv_pre = FieldValue()
        
        fv_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv_pre.setValue("test_updateRecordAssignees_revisionNull")
        
        record_pre["FieldCode1"] = fv_pre
        
        var responses_pre: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        XCTAssertNoThrow(responses_pre = (try self.bulkRequest?.execute())!)
        
        let results_pre: Array<Any>? = responses_pre?.getResults()
        
        let result_pre: AddRecordResponse = (results_pre![0] as! AddRecordResponse)
        
        // Main Test processing
        let preId: Int = result_pre.getId()!
        
        self.bulkRequest = BulkRequest(self.connection!)
        var assignees: Array<String> = []
        
        assignees.append("yutaro-suzuki")
        
        var responses: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordAssignees(APP_ID, preId, assignees, nil))
        XCTAssertNoThrow(responses = (try self.bulkRequest?.execute())!)
        
        let results: Array<Any>? = responses?.getResults()
        
        XCTAssertNotNil(results)
        XCTAssertEqual(1, results?.count)
        
        let result1: UpdateRecordResponse = (results![0] as! UpdateRecordResponse)
        
        XCTAssertEqual(2, result1.getRevision())
    }
    
    func testUpdateRecordAssigneesSuccessWhenAssigneesNull() {
        
        // Preprocessing
        var record_pre: [String: FieldValue] = [:]
        let fv_pre = FieldValue()
        
        fv_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv_pre.setValue("test_updateRecordAssignees_assigneesNull")
        
        record_pre["FieldCode1"] = fv_pre
        
        var responses_pre: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        XCTAssertNoThrow(responses_pre = (try self.bulkRequest?.execute())!)
        
        let results_pre: Array<Any>? = responses_pre?.getResults()
        
        let result_pre: AddRecordResponse = (results_pre![0] as! AddRecordResponse)
        
        // Main Test processing
        let preId: Int = result_pre.getId()!
        
        self.bulkRequest = BulkRequest(self.connection!)
        let assignees: Array<String> = []
        
        var responses: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordAssignees(APP_ID, preId, assignees, -1))
        XCTAssertNoThrow(responses = (try self.bulkRequest?.execute())!)
        
        let results: Array<Any>? = responses?.getResults()
        
        XCTAssertNotNil(results)
        XCTAssertEqual(1, results?.count)
        
        let result1: UpdateRecordResponse = (results![0] as! UpdateRecordResponse)
        
        XCTAssertEqual(2, result1.getRevision())
    }
    
    func testUpdateRecordStatusSuccess() {
        
        // Preprocessing
        var record_pre: [String: FieldValue] = [:]
        let fv_pre = FieldValue()
        
        fv_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv_pre.setValue("test_updateRecordStatus")
        
        record_pre["FieldCode1"] = fv_pre
        
        var responses_pre: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        XCTAssertNoThrow(responses_pre = (try self.bulkRequest?.execute())!)
        
        let results_pre: Array<Any>? = responses_pre?.getResults()
        
        let result_pre: AddRecordResponse = (results_pre![0] as! AddRecordResponse)
        
        // Main Test processing
        let preId: Int = result_pre.getId()!
        
        self.bulkRequest = BulkRequest(self.connection!)
        
        var responses: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordStatus(APP_ID, preId, "処理開始", "tomoya-takaki", 1))
        XCTAssertNoThrow(responses = (try self.bulkRequest?.execute())!)
        
        let results: Array<Any>? = responses?.getResults()
        
        XCTAssertNotNil(results)
        XCTAssertEqual(1, results?.count)
        
        let result1: UpdateRecordResponse = (results![0] as! UpdateRecordResponse)
        
        XCTAssertEqual(3, result1.getRevision())
    }
    
    func testUpdateRecordStatusSuccessWhenRevisionNull() {
        
        // Preprocessing
        var record_pre: [String: FieldValue] = [:]
        let fv_pre = FieldValue()
        
        fv_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv_pre.setValue("test_updateRecordStatus_revisionNull")
        
        record_pre["FieldCode1"] = fv_pre
        
        var responses_pre: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        XCTAssertNoThrow(responses_pre = (try self.bulkRequest?.execute())!)
        
        let results_pre: Array<Any>? = responses_pre?.getResults()
        
        let result_pre: AddRecordResponse = (results_pre![0] as! AddRecordResponse)
        
        // Main Test processing
        let preId: Int = result_pre.getId()!
        
        self.bulkRequest = BulkRequest(self.connection!)
        
        var responses: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordStatus(APP_ID, preId, "処理開始", "tomoya-takaki", nil))
        XCTAssertNoThrow(responses = (try self.bulkRequest?.execute())!)
        
        let results: Array<Any>? = responses?.getResults()
        
        XCTAssertNotNil(results)
        XCTAssertEqual(1, results?.count)
        
        let result1: UpdateRecordResponse = (results![0] as! UpdateRecordResponse)
        
        XCTAssertEqual(3, result1.getRevision())
    }
    
    func testUpdateRecordStatusSuccessWhenAssigneesNull() {
        
        // Preprocessing
        var record_pre: [String: FieldValue] = [:]
        let fv_pre = FieldValue()
        
        fv_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv_pre.setValue("test_updateRecordStatus_AssigneesNull")
        
        record_pre["FieldCode1"] = fv_pre
        
        var responses_pre: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        XCTAssertNoThrow(responses_pre = (try self.bulkRequest?.execute())!)
        
        let results_pre: Array<Any>? = responses_pre?.getResults()
        
        let result_pre: AddRecordResponse = (results_pre![0] as! AddRecordResponse)
        
        let preId: Int = result_pre.getId()!
        self.bulkRequest = BulkRequest(self.connection!)
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordStatus(APP_ID, preId, "処理開始", "hiroyuki-sekiyama", nil))
        XCTAssertNoThrow(try self.bulkRequest?.execute())
        
        // Main Test processing
        self.bulkRequest = BulkRequest(self.connection!)
        
        var responses: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordStatus(APP_ID, preId, "レビューする", nil, nil))
        XCTAssertNoThrow(responses = (try self.bulkRequest?.execute())!)
        
        let results: Array<Any>? = responses?.getResults()
        
        XCTAssertNotNil(results)
        XCTAssertEqual(1, results?.count)
        
        let result1: UpdateRecordResponse = (results![0] as! UpdateRecordResponse)
        
        XCTAssertEqual(5, result1.getRevision())
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
        
        var responses_pre: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecords(APP_ID, records_pre))
        XCTAssertNoThrow(responses_pre = (try self.bulkRequest?.execute())!)
        
        let results_pre: Array<Any>? = responses_pre?.getResults()
        
        let result1_pre: AddRecordsResponse = (results_pre![0] as! AddRecordsResponse)
        
        // Main Test processing
        self.bulkRequest = BulkRequest(self.connection!)
        
        var rusi: Array<RecordUpdateStatusItem> = []
        rusi.append(RecordUpdateStatusItem("処理開始", "yutaro-suzuki", result1_pre.getIDs()?[0], 1))
        rusi.append(RecordUpdateStatusItem("処理開始", "yutaro-suzuki", result1_pre.getIDs()?[1], nil))
        rusi.append(RecordUpdateStatusItem("処理開始", "yutaro-suzuki", result1_pre.getIDs()?[2], -1))
        
        var responses: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordsStatus(APP_ID, rusi))
        XCTAssertNoThrow(responses = (try self.bulkRequest?.execute())!)
        
        let results: Array<Any>? = responses?.getResults()
        
        XCTAssertNotNil(results)
        XCTAssertEqual(1, results?.count)
        
        let result1: UpdateRecordsResponse = (results![0] as! UpdateRecordsResponse)
        
        XCTAssertEqual(3, result1.getRecords()?.count)
        
        XCTAssert(type(of: (result1.getRecords()![0] as RecordUpdateResponseItem).getID()) == Int?.self)
        XCTAssert(type(of: (result1.getRecords()![1] as RecordUpdateResponseItem).getID()) == Int?.self)
        XCTAssert(type(of: (result1.getRecords()![2] as RecordUpdateResponseItem).getID()) == Int?.self)
        
        XCTAssertEqual(result1_pre.getIDs()![0], (result1.getRecords()![0] as RecordUpdateResponseItem).getID())
        XCTAssertEqual(result1_pre.getIDs()![1], (result1.getRecords()![1] as RecordUpdateResponseItem).getID())
        XCTAssertEqual(result1_pre.getIDs()![2], (result1.getRecords()![2] as RecordUpdateResponseItem).getID())
        
        XCTAssertEqual(3, (result1.getRecords()![0] as RecordUpdateResponseItem).getRevision())
        XCTAssertEqual(3, (result1.getRecords()![1] as RecordUpdateResponseItem).getRevision())
        XCTAssertEqual(3, (result1.getRecords()![2] as RecordUpdateResponseItem).getRevision())
    }
    
    func testExcuteFail() {
        // Preprocessing
        XCTAssertThrowsError(try self.bulkRequest?.execute())
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
        XCTAssertThrowsError(try self.bulkRequest?.execute())
    }
    
    func testUpdateRecordFail() {
        
        var record_pre: [String: FieldValue] = [:]
        
        let fv_pre = FieldValue()
        fv_pre.setType(FieldType.SINGLE_LINE_TEXT)
        fv_pre.setValue("test_updateRecordFail1")
        
        record_pre["FieldCode1"] = fv_pre
        
        var responses_pre: BulkRequestResponse? = nil
        
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record_pre))
        XCTAssertNoThrow(responses_pre = (try self.bulkRequest?.execute())!)
        
        let results_pre: Array<Any>? = responses_pre?.getResults()
        
        let result_pre: AddRecordResponse = (results_pre![0] as! AddRecordResponse)
        
        // Main Test processing
        let preId: Int = result_pre.getId()!
        
        self.bulkRequest = BulkRequest(self.connection!)
        
        var record1: [String: FieldValue] = [:]
        
        let fv1 = FieldValue()
        fv1.setType(FieldType.SINGLE_LINE_TEXT)
        fv1.setValue("test_updateRecordFail2")
        
        record1["FieldCode1"] = fv1
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record1))
        
        var record2: [String: FieldValue] = [:]
        
        let fv2 = FieldValue()
        fv2.setType(FieldType.SINGLE_LINE_TEXT)
        fv2.setValue("test_updateRecordById")
        
        record2["FieldCode1"] = fv2
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.updateRecordByID(APP_ID, preId, record2, 100))
        
        var record3: [String: FieldValue] = [:]
        
        let fv3 = FieldValue()
        fv3.setType(FieldType.SINGLE_LINE_TEXT)
        fv3.setValue("test_updateRecordFail3")
        
        record3["FieldCode1"] = fv3
        XCTAssertNoThrow(self.bulkRequest = try self.bulkRequest?.addRecord(APP_ID, record3))
        
        do {
            try self.bulkRequest?.execute()
        } catch let error as KintoneAPIException{
            let er = error.toString()!
            let exinfo = er.split(separator: ",")
            XCTAssertEqual("api_no: 2", exinfo[0].trimmingCharacters(in: .whitespaces))
            XCTAssertEqual("method: PUT", exinfo[1].trimmingCharacters(in: .whitespaces))
            XCTAssertEqual("api_name: /k/v1/record.json", exinfo[2].trimmingCharacters(in: .whitespaces))
            XCTAssertEqual("code: GAIA_CO02", exinfo[4].trimmingCharacters(in: .whitespaces))
            XCTAssertEqual("message: The revision is not the latest. Someone may update a record.", exinfo[5].trimmingCharacters(in: .whitespaces))
            XCTAssertEqual("status: Optional(409)", exinfo[6].trimmingCharacters(in: .whitespaces))
        } catch {
            print("例外発生：　\(error)")
        }
    }
}
 
