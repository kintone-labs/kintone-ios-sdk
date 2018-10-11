//  Copyright © 2018 Cybozu. All rights reserved.

import XCTest
import kintone_ios_sdk

class AddPreviewAppTest: XCTestCase {
    private let USERNAME = "Phien"
    private let PASSWORD = "Phien"
    private let APP_NAME: String = "AddPreviewApp_Test"
    private let SPACE_ID: Int = 130
    private let THREAD_ID: Int = 151
    private let REVISION: Int = -1
    private var app: App? = nil
    private var connection: Connection? = nil

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        var auth = Auth.init()
        auth = auth.setPasswordAuth(self.USERNAME, self.PASSWORD)
        self.connection = Connection(TestsConstants.DOMAIN, auth)
        self.app = App(self.connection!)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAdddPreviewAppSuccess() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var addPreviewRespones: AddPreviewAppResponse? = nil
        XCTAssertNoThrow(addPreviewRespones = try self.app?.addPreviewApp(self.APP_NAME, self.SPACE_ID, self.THREAD_ID))
        
        XCTAssertNotNil(addPreviewRespones?.getApp())
        XCTAssertNotNil(addPreviewRespones?.getRevision())
        
    }
    
    func testAdddPreviewAppFailWhenThreadIdNotExist() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let threadId: Int = 99999
        XCTAssertThrowsError(try self.app?.addPreviewApp(self.APP_NAME, self.SPACE_ID, threadId))
        {
            error in XCTAssert(type(of: error) == KintoneAPIException.self)
        }
    }

}
