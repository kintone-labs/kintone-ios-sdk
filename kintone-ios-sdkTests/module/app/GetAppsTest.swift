//  Copyright © 2018 Cybozu. All rights reserved.

import XCTest
import kintone_ios_sdk

class GetAppsTest: XCTestCase {
    private let USERNAME = "Phien"
    private let PASSWORD = "Phien"
    private let OFFSET = 659
    private let LIMIT = 1
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

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testGetListAppsSuccess() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var expectedAppModel: [String: String] = [String: String]()
        expectedAppModel["appId"] = "1691"
        expectedAppModel["code"] = "GetAppTest"
        expectedAppModel["name"] = "GetApp_Test"
        expectedAppModel["description"] = "<div>A list of great places to go!</div>"
        expectedAppModel["spaceId"] = "130"
        expectedAppModel["threadId"] = "151"
        
        var appsResponse: [AppModel]? = [AppModel]()
        XCTAssertNoThrow(appsResponse = try self.app?.getApps(self.OFFSET, self.LIMIT))
        XCTAssertEqual(1, appsResponse?.count)
        
        let appModel: AppModel = appsResponse![0]
        
        XCTAssertEqual(Int(expectedAppModel["appId"]!), appModel.getAppId()!)
        XCTAssertEqual(expectedAppModel["code"], appModel.getCode()!)
        XCTAssertEqual(expectedAppModel["name"], appModel.getName()!)
        XCTAssertEqual(expectedAppModel["description"], appModel.getDescription()!)
        XCTAssertEqual(Int(expectedAppModel["spaceId"]!), appModel.getSpaceId()!)
        XCTAssertEqual(Int(expectedAppModel["threadId"]!), appModel.getThreadId()!)
        
        XCTAssertNotNil(appModel.getCreator())
        XCTAssertNotNil(appModel.getModifier())
        
    }
    
    func testGetListAppsFailWhenLimitGreaterThanMaxValue() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let limit: Int = 2147483648
        
        XCTAssertThrowsError(try self.app?.getApps(self.OFFSET, limit)){
            error in XCTAssert(type(of: error) == KintoneAPIException.self)
        }
        
    }

}
