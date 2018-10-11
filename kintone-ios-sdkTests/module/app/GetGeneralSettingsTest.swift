//
//  GetGeneralSettingsTest.swift
//  kintone-ios-sdkTests
//
//  Created by Pham Anh Quoc Phien on 10/8/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

import XCTest
import kintone_ios_sdk

class GetGeneralSettingsTest: XCTestCase {
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

    func testGetPreLiveAppGeneralSettingsSuccess() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let isPreview: Bool = true
        var appGeneralSetting: GeneralSettings? = nil
        
        XCTAssertNoThrow(appGeneralSetting = try self.app?.getGeneralSettings(self.APP_ID, self.LANG, isPreview))
        XCTAssertNotNil(appGeneralSetting)
        
        XCTAssertNotNil(appGeneralSetting?.getName())
        XCTAssertEqual("GetViewsApp_Test", appGeneralSetting?.getName()!)
        
        XCTAssertNotNil(appGeneralSetting?.getDescription())
        XCTAssertEqual("<div>A list of great places to go!</div>", appGeneralSetting?.getDescription()!)
        
        var iconModel: Icon? = nil
        XCTAssertNotNil(iconModel = appGeneralSetting?.getIcon())
        XCTAssertNotNil(iconModel?.getKey())
        XCTAssertEqual("APP39", iconModel?.getKey())
        
        XCTAssertNotNil(iconModel?.getIconType())
        XCTAssertEqual(Icon.IconType.PRESET,  iconModel?.getIconType()!)
        
        XCTAssertNotNil(appGeneralSetting?.getTheme())
        XCTAssertEqual( GeneralSettings.IconTheme.WHITE, appGeneralSetting?.getTheme()!)
      
    }
    
    func testGetPreLiveAppGeneralSettingsFailWhenAppIDNotExist() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let appId: Int = 99999
        let isPreview: Bool = true
        
        XCTAssertThrowsError(try self.app!.getGeneralSettings(appId, self.LANG, isPreview))
        {
            error in XCTAssert(type(of: error) == KintoneAPIException.self)
        }
    }

}
