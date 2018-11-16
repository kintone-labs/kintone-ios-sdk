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
        auth = auth.setPasswordAuth("cybozu1", "cybozu")
        let conn = Connection( "phienphamf1811-1.cybozu-dev.com", auth )
        conn.setProxy("dc-ty3-squid-1.cb.local", 3128)
        do {
            let recordModule = Record(conn)
//            let record = try recordModule.getRecord(9, 1)
//            print(record.getRecord())
            try recordModule.getRecordAsync(9, 1).then{ response in
                print(response.getRecord()?.count)
            }.catch { error in
                let parseError = error as! KintoneAPIException
                print(parseError.toString()!)
            }
            XCTAssert(waitForPromises(timeout: 5))
        } catch {
            print("Invalid Selection.")
        }

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
