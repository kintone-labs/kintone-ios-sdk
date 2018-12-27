//  Copyright © 2018 Cybozu. All rights reserved.

import XCTest
import kintone_ios_sdk
@testable import Promises

class GetAppDeployStatusTest: XCTestCase {
    private let USERNAME = TestsConstants.ADMIN_USERNAME
    private let PASSWORD = TestsConstants.ADMIN_PASSWORD
    private let APP_IDS: [Int] = AppTestConstants.GET_APP_DEPLOY_STATUS_APP_IDS
    private let APP_STATUS: [String] = AppTestConstants.GET_APP_DEPLOY_STATUS_APP_STATUS
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

    func testGetAppDeployStatusSuccess() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        self.app?.getAppDeployStatus(self.APP_IDS).then{deployStatusReponse in
            XCTAssertEqual(2, deployStatusReponse.getApps()!.count)
            
            var listAppsDeployStatus: [AppDeployStatus] = [AppDeployStatus]()
            XCTAssertNotNil(listAppsDeployStatus = (deployStatusReponse.getApps())!)
            
            for appDeployStatus in listAppsDeployStatus {
                XCTAssertTrue(self.APP_IDS.contains(appDeployStatus.getApp()!))
                let deploytStatus = appDeployStatus.getStatus()!.rawValue
                XCTAssertTrue(self.APP_STATUS.contains(deploytStatus))
            }
            }.catch{ error in
                XCTFail(self.getErrorMessage(error))
            }
        XCTAssert(waitForPromises(timeout: 10))
    }
    
    func testGetAppFormLayoutFailWhenAppIDNotExist()
    {
        let appIds: [Int] = [99999]
        self.app?.getAppDeployStatus(appIds).then{_ in
            XCTFail(self.getErrorMessage("CAN GET UNEXIST APP"))
            }.catch{ error in
                XCTAssert(type(of: error) == KintoneAPIException.self)
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
    

}
