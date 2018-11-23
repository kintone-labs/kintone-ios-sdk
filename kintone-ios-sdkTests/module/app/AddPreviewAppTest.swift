//  Copyright © 2018 Cybozu. All rights reserved.

import XCTest
import kintone_ios_sdk
@testable import Promises

class AddPreviewAppTest: XCTestCase {
    private let USERNAME = TestsConstants.ADMIN_USERNAME
    private let PASSWORD = TestsConstants.ADMIN_PASSWORD
    private let APP_NAME: String = AppTestConstants.ADD_PREVIEW_APP_APP_NAME
    private let SPACE_ID: Int = AppTestConstants.ADD_PREVIEW_APP_SPACE_ID
    private let THREAD_ID: Int = AppTestConstants.ADD_PREVIEW_APP_THREAD_ID
    private let REVISION: Int = AppTestConstants.ADD_PREVIEW_APP_REVISION
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
    
    func getErrorMessage(_ error: Any) -> String {
        if error is KintoneAPIException {
            return (error as! KintoneAPIException).toString()!
        }
        else {
            return (error as! Error).localizedDescription
        }
    }

    func testAdddPreviewAppSuccess() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        self.app?.addPreviewApp(self.APP_NAME, self.SPACE_ID, self.THREAD_ID).then{ addPreviewRespones in
            XCTAssertNotNil(addPreviewRespones.getApp())
            XCTAssertNotNil(addPreviewRespones.getRevision())
        }.catch{ error in
            XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
    
    func testAdddPreviewAppFailWhenThreadIdNotExist() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let threadId: Int = 99999
        self.app?.addPreviewApp(self.APP_NAME, self.SPACE_ID, threadId).then{_ in
            XCTFail(self.getErrorMessage("CAN GET UNEXIST APP"))
            }.catch{ error in
                XCTAssert(type(of: error) == KintoneAPIException.self)
            }
            XCTAssert(waitForPromises(timeout: 10))
    }

}
