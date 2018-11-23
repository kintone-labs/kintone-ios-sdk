//
//  GetAppsByNameTest.swift
//  kintone-ios-sdkTests
//
//  Created by Pham Anh Quoc Phien on 10/8/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

import XCTest
import kintone_ios_sdk
@testable import Promises

class GetAppsByNameTest: XCTestCase {
    private let USERNAME = TestsConstants.ADMIN_USERNAME
    private let PASSWORD = TestsConstants.ADMIN_PASSWORD
    private let APP_NAME: String = AppTestConstants.GET_APPS_BY_NAME_APP_NAME
    private let OFFSET = AppTestConstants.GET_APPS_BY_NAME_OFFSET
    private let LIMIT = AppTestConstants.GET_APPS_BY_NAME_LIMMIT
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

    func testGetAppsByNameSuccess() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var expectedAppModel: [String: String] = [String: String]()
        expectedAppModel["appId"] = "1691"
        expectedAppModel["code"] = "GetAppTest"
        expectedAppModel["name"] = "GetApp_Test"
        expectedAppModel["description"] = "<div>A list of great places to go!</div>"
        expectedAppModel["spaceId"] = "130"
        expectedAppModel["threadId"] = "151"
        
        self.app?.getAppsByName(self.APP_NAME, self.OFFSET, self.LIMIT).then{appsResponse in
            var appModel: AppModel = AppModel()
            XCTAssertEqual(appsResponse.count, 1)
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
    
    func testGetAppsByNamesFailWhenLimitGreaterThanMaxValue() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let limit: Int = 2147483648
        
        self.app?.getAppsByName(self.APP_NAME, self.OFFSET, limit).then{_ in
            XCTFail(self.getErrorMessage("CAN GET UNEXIST APP"))
            }.catch{ error in
                XCTAssert(type(of: error) == KintoneAPIException.self)
            }
        
            XCTAssert(waitForPromises(timeout: 5))
    }

}
