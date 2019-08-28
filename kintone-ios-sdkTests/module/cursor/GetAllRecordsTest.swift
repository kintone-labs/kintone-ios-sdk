//
//  CursorRecordTest.swift
//  kintone-ios-sdkTests
//
//  Created by Ho Kim Cuc on 8/15/19.
//  Copyright © 2019 Cybozu. All rights reserved.
//

import XCTest
@testable import kintone_ios_sdk
@testable import Promises

class GetAllRecordsTest: XCTestCase {
    private var recordCursor: RecordCursor?
    
    override func setUp() {
        super.setUp()
        
        // set auth
        var auth = Auth()
        auth = auth.setPasswordAuth(TestsConstants.ADMIN_USERNAME, TestsConstants.ADMIN_PASSWORD)
        let conn = Connection(TestsConstants.DOMAIN, auth, -1)
        
        // instance of Record class
        self.recordCursor = RecordCursor(conn)
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
    
    func testGetAllRecordsSuccess() {
        self.recordCursor?.createCursor(RecordTestConstants.APP_ID, nil, nil, 500).then{createCursorRespone in
            return (self.recordCursor?.getAllRecords(createCursorRespone.getId()))!
            }.then{ getRecordsRespone in
                XCTAssert(type(of: getRecordsRespone.getRecords()!) == [[String: FieldValue]].self)
                XCTAssert(type(of: getRecordsRespone.getTotalCount()!) == Int.self)
            }.catch{ error in
                XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 50))
    }
    
    func testGetAllRecordsFailWhenAppIdNotExist() {
        self.recordCursor?.getAllRecords("wrong_id").then{ rsp in
            XCTFail(self.getErrorMessage("CAN GET UNEXIST APP"))
            }.catch { error in
                XCTAssert(type(of: error) == KintoneAPIException.self)
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
}
