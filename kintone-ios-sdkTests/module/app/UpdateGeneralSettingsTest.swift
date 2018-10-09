//
//  UpdateGeneralSettingsTest.swift
//  kintone-ios-sdkTests
//
//  Created by Pham Anh Quoc Phien on 10/8/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

import XCTest
import kintone_ios_sdk

class UpdateGeneralSettingsTest: XCTestCase {

    private let USERNAME = "Phien"
    private let PASSWORD = "Phien"
    private let APP_ID = 1686
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

    func testUpdateAppGeneralSettingsSuccess() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let appGeneralSetting: GeneralSettings = GeneralSettings()
        appGeneralSetting.setName("GetViewsApp_Test")
        appGeneralSetting.setDescription("<div>A list of great places to go!</div>")
        let iconModel: Icon = Icon("APP39", Icon.IconType.PRESET)
        appGeneralSetting.setIcon(iconModel)
        appGeneralSetting.setTheme(GeneralSettings.IconTheme.WHITE)
        
        var basicResponse: BasicResponse? = nil
        XCTAssertNoThrow(basicResponse = try self.app?.updateGeneralSettings(self.APP_ID, appGeneralSetting))
        XCTAssertNotNil(basicResponse?.getRevision())
    }
    
    func testUpdateAppGeneralSettingsFailWhenAppIDNotExist() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let appId: Int = 99999
        
        let appGeneralSetting: GeneralSettings = GeneralSettings()
        appGeneralSetting.setName("GetViewsApp_Test")
        appGeneralSetting.setDescription("<div>A list of great places to go!</div>")
        let iconModel: Icon = Icon("APP39", Icon.IconType.PRESET)
        appGeneralSetting.setIcon(iconModel)
        appGeneralSetting.setTheme(GeneralSettings.IconTheme.WHITE)
        
        XCTAssertThrowsError(try self.app?.updateGeneralSettings(appId, appGeneralSetting))
        {
            error in XCTAssert(type(of: error) == KintoneAPIException.self)
        }
    }

}
