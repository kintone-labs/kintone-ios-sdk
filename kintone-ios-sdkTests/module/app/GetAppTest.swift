//  Copyright © 2018 Cybozu. All rights reserved

import XCTest
import kintone_ios_sdk

class GetAppTest: XCTestCase {
    private let USERNAME = "Phien"
    private let PASSWORD = "Phien"
    private let APP_ID = 1691
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
        
        var appResponse: AppModel? = AppModel()
        XCTAssertNoThrow(appResponse = try self.app?.getApp(self.APP_ID))
        
        XCTAssertEqual(Int(expectedAppModel["appId"]!), appResponse?.getAppId()!)
        XCTAssertEqual(expectedAppModel["code"], appResponse?.getCode()!)
        XCTAssertEqual(expectedAppModel["name"], appResponse?.getName()!)
        XCTAssertEqual(expectedAppModel["description"], appResponse?.getDescription()!)
        XCTAssertEqual(Int(expectedAppModel["spaceId"]!), appResponse?.getSpaceId()!)
        XCTAssertEqual(Int(expectedAppModel["threadId"]!), appResponse?.getThreadId()!)
        
        XCTAssertNotNil(appResponse?.getCreator())
        XCTAssertNotNil(appResponse?.getModifier())
        
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

        XCTAssertThrowsError(try self.app?.getApp(appId)){
            error in XCTAssert(type(of: error) == KintoneAPIException.self)
        }

        
    }

}
