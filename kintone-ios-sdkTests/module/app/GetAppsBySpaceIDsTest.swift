//  Copyright © 2018 Cybozu. All rights reserved.

import XCTest
import kintone_ios_sdk
@testable import Promises

class GetAppsBySpaceIDsTest: XCTestCase {
    private let USERNAME = TestsConstants.ADMIN_USERNAME
    private let PASSWORD = TestsConstants.ADMIN_PASSWORD
    private let SPACE_IDS: [Int] = AppTestConstants.GET_APPS_BY_SPACE_IDS_SPACE_IDS
    private let OFFSET = AppTestConstants.GET_APPS_BY_SPACE_IDS_OFFSET
    private let LIMIT = AppTestConstants.GET_APPS_BY_SPACE_IDS_LIMMIT
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

    func testGetAppsBySpaceIDsSuccess() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var expectedAppModel: [String: String] = [String: String]()
        expectedAppModel["appId"] = "1691"
        expectedAppModel["code"] = "GetAppTest"
        expectedAppModel["name"] = "GetApp_Test"
        expectedAppModel["description"] = "<div>A list of great places to go!</div>"
        expectedAppModel["spaceId"] = "130"
        expectedAppModel["threadId"] = "151"
        
        self.app?.getAppsBySpaceIDs(self.SPACE_IDS, self.OFFSET, self.LIMIT).then{appsResponse in
            XCTAssertEqual(1, appsResponse.count)
        
            var appModel: AppModel = AppModel()
            XCTAssertNoThrow(appModel = (appsResponse.first)!)
        
            XCTAssertEqual(Int(expectedAppModel["appId"]!), appModel.getAppId()!)
            XCTAssertEqual(expectedAppModel["code"], appModel.getCode()!)
            XCTAssertEqual(expectedAppModel["name"], appModel.getName()!)
            XCTAssertEqual(expectedAppModel["description"], appModel.getDescription()!)
            XCTAssertEqual(Int(expectedAppModel["spaceId"]!), appModel.getSpaceId()!)
            XCTAssertEqual(Int(expectedAppModel["threadId"]!), appModel.getThreadId()!)
        
            XCTAssertNotNil(appModel.getCreator())
            XCTAssertNotNil(appModel.getModifier())
        }.catch{ error in
        XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 5))
        
    }
    
    func testGetAppsBySpaceIDsFailWhenLimitGreaterThanMaxValue() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let limit: Int = 2147483648
        
        self.app?.getAppsBySpaceIDs(self.SPACE_IDS, self.OFFSET, limit).then{_ in
            XCTFail(self.getErrorMessage("CAN GET UNEXIST APP"))
            }.catch{ error in
                XCTAssert(type(of: error) == KintoneAPIException.self)
            }
            XCTAssert(waitForPromises(timeout: 5))
    }

}
