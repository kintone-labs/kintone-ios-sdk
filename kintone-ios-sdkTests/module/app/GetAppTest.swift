//  Copyright © 2018 Cybozu. All rights reserved

import XCTest
import kintone_ios_sdk
@testable import Promises

class GetAppTest: XCTestCase {
    private let USERNAME = TestsConstants.ADMIN_USERNAME
    private let PASSWORD = TestsConstants.ADMIN_PASSWORD
    private let APP_ID = AppTestConstants.COMMON_APP_ID
    private let LANG = LanguageSetting.EN
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
    
    func testGetAppSuccess() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var expectedAppModel: [String: String] = [String: String]()
        expectedAppModel["appId"] = "1691"
        expectedAppModel["code"] = "GetAppTest"
        expectedAppModel["name"] = "GetApp_Test"
        expectedAppModel["description"] = "<div>A list of great places to go!</div>"
        expectedAppModel["spaceId"] = "130"
        expectedAppModel["threadId"] = "151"
        
        self.app?.getApp(self.APP_ID).then{appResponse in
            XCTAssertEqual(Int(expectedAppModel["appId"]!), appResponse.getAppId()!)
            XCTAssertEqual(expectedAppModel["code"], appResponse.getCode()!)
            XCTAssertEqual(expectedAppModel["name"], appResponse.getName()!)
            XCTAssertEqual(expectedAppModel["description"], appResponse.getDescription()!)
            XCTAssertEqual(Int(expectedAppModel["spaceId"]!), appResponse.getSpaceId()!)
            XCTAssertEqual(Int(expectedAppModel["threadId"]!), appResponse.getThreadId()!)
            XCTAssertNotNil(appResponse.getCreator())
            XCTAssertNotNil(appResponse.getModifier())
        }.catch{ error in
                XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 10))
        
        
    }
    
    func testGetAppFailWhenAppIdNotExist() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let appId = 99999
        var expectedAppModel: [String: String] = [String: String]()
        expectedAppModel["appId"] = "1691"
        expectedAppModel["code"] = "GetAppTest"
        expectedAppModel["name"] = "GetApp_Test"
        expectedAppModel["description"] = "<div>A list of great places to go!</div>"
        expectedAppModel["spaceId"] = "130"
        expectedAppModel["threadId"] = "151"

        self.app?.getApp(appId).then{_ in
            XCTFail(self.getErrorMessage("CAN GET UNEXIST APP"))
        }.catch{ error in
            XCTAssert(type(of: error) == KintoneAPIException.self)
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
}
