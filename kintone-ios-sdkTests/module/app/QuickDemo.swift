//
//  QuickDemo.swift
//  kintone-ios-sdkTests
//
//  Created by Vu Tran on 4/17/19.
//  Copyright © 2019 Cybozu. All rights reserved.
//

import Quick
import Nimble
@testable import kintone_ios_sdk
@testable import Promises

class QuickDemo: QuickSpec {
    
    private let USERNAME = TestsConstants.ADMIN_USERNAME
    private let PASSWORD = TestsConstants.ADMIN_PASSWORD
    private let APP_ID = AppTestConstants.COMMON_APP_ID
    private let LANG = LanguageSetting.EN
    private var app: App? = nil
    private var connection: Connection? = nil
    
    func getErrorMessage(_ error: Any) -> String {
        if error is KintoneAPIException {
            return (error as! KintoneAPIException).toString()!
        }
        else {
            return (error as! Error).localizedDescription
        }
    }
    
    override func spec() {
        describe("demo describe"){
            context("demo context"){
                var auth = Auth.init()
                auth = auth.setPasswordAuth(self.USERNAME, self.PASSWORD)
                self.connection = Connection(TestsConstants.DOMAIN, auth)
                self.app = App(self.connection!)
                
                it("demo it"){
                    self.app?.getApp(88).then{ appResponse in
                        print(appResponse.getAppId()!)
                        expect(appResponse.getAppId()!).to(equal(88))
                        }.catch{ error in
                            XCTFail(self.getErrorMessage(error))
                    }
                    XCTAssert(waitForPromises(timeout: 10))
                }
            }
        }
    }
}
