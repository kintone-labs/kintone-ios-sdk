//  Copyright © 2018 Cybozu. All rights reserved.

import XCTest
import kintone_ios_sdk

class DeployAppSettingsTest: XCTestCase {
    private let USERNAME = "Phien"
    private let PASSWORD = "Phien"
    private let APP_ID: Int = 1693
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

    func testDeployAppSettingsSuccess() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let appPreview: AddPreviewAppResponse? = AddPreviewAppResponse(self.APP_ID, self.REVISION)
        XCTAssertNoThrow(try self.app?.deployAppSettings([appPreview!]))
    }
    
    func testDeployAppSettingsFailWhenAppIDNotExist() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let appID: Int = 99999
        let appPreview: AddPreviewAppResponse? = AddPreviewAppResponse(appID, self.REVISION)
        XCTAssertThrowsError(try self.app?.deployAppSettings([appPreview!]))
        {
            error in XCTAssert(type(of: error) == KintoneAPIException.self)
        }
    }

}
