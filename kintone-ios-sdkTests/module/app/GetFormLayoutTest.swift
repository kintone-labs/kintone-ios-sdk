//  Copyright © 2018 Cybozu. All rights reserved.

import XCTest
@testable import kintone_ios_sdk
@testable import Promises

class GetFormLayoutTest: XCTestCase {
    private let USERNAME = TestsConstants.ADMIN_USERNAME
    private let PASSWORD = TestsConstants.ADMIN_PASSWORD
    private let APP_ID = AppTestConstants.GET_FORM_LAYOUT_APP_ID
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

    func testGetAppFormLayoutSuccess()
    {
        self.app?.getFormLayout(self.APP_ID).then{ formLayoutResponse in
            XCTAssertNotNil(formLayoutResponse.getRevision())
            
            var itemLayouts: [ItemLayout]? = [ItemLayout]()
            XCTAssertNotNil(itemLayouts = formLayoutResponse.getLayout())
            XCTAssertGreaterThan(itemLayouts!.count, 0 )
            var fields: [FieldLayout]? = nil
            for itemLayout in itemLayouts!
            {
                var itemLayoutType: LayoutType? = nil
                XCTAssertNotNil(itemLayoutType = itemLayout.getType()!)
                XCTAssertTrue(type(of: itemLayoutType!) == LayoutType.self)
                switch itemLayoutType!
                {
                case LayoutType.ROW:
                    var itemRowLayout: RowLayout? = nil
                    XCTAssertNoThrow(itemRowLayout = itemLayout as? RowLayout)
                    XCTAssertNotNil(fields = itemRowLayout?.getFields())
                    XCTAssertGreaterThanOrEqual((fields?.count)!, 1)
                    break
                case LayoutType.SUBTABLE:
                    var itemSubTableLayout: SubTableLayout? = nil
                    XCTAssertNoThrow(itemSubTableLayout = itemLayout as? SubTableLayout)
                    XCTAssertNotNil(fields = itemSubTableLayout?.getFields())
                    XCTAssertGreaterThanOrEqual((fields?.count)!, 1)
                    XCTAssertNotNil(itemSubTableLayout?.getCode())
                    break
                case LayoutType.GROUP:
                    var layout: [RowLayout]? = nil
                    var itemGroupLayout: GroupLayout? = nil
                    XCTAssertNoThrow(itemGroupLayout = itemLayout as? GroupLayout)
                    XCTAssertNotNil(itemGroupLayout?.getCode())
                    XCTAssertNotNil(layout = itemGroupLayout?.getLayout())
                    XCTAssertGreaterThanOrEqual((layout?.count)!, 0)
                    self.testGroupLayoutSuccess(layout)
                    break
                }
            }
            }.catch{ error in 
                var errorString = ""
                if (type(of: error) == KintoneAPIException.self) {
                    errorString = (error as! KintoneAPIException).toString()!
                } else {
                    errorString = error.localizedDescription
                }
                XCTFail(errorString)
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
    
    func testGetPreLiveAppFormLayoutSuccess()
    {
        let isPreview = true
        self.app?.getFormLayout(self.APP_ID, isPreview).then{ formLayoutResponse in
            XCTAssertNotNil(formLayoutResponse.getRevision())
            var itemLayouts: [ItemLayout]? = [ItemLayout]()
            XCTAssertNotNil(itemLayouts = formLayoutResponse.getLayout())
            XCTAssertGreaterThan(itemLayouts!.count, 0 )
            var fields: [FieldLayout]? = nil
            for itemLayout in itemLayouts!
            {
                var itemLayoutType: LayoutType? = nil
                XCTAssertNotNil(itemLayoutType = itemLayout.getType()!)
                XCTAssertTrue(type(of: itemLayoutType!) == LayoutType.self)
                switch itemLayoutType!
                {
                case LayoutType.ROW:
                    var itemRowLayout: RowLayout? = nil
                    XCTAssertNoThrow(itemRowLayout = itemLayout as? RowLayout)
                    XCTAssertNotNil(fields = itemRowLayout?.getFields())
                    XCTAssertGreaterThanOrEqual((fields?.count)!, 1)
                    break
                case LayoutType.SUBTABLE:
                    var itemSubTableLayout: SubTableLayout? = nil
                    XCTAssertNoThrow(itemSubTableLayout = itemLayout as? SubTableLayout)
                    XCTAssertNotNil(fields = itemSubTableLayout?.getFields())
                    XCTAssertGreaterThanOrEqual((fields?.count)!, 1)
                    XCTAssertNotNil(itemSubTableLayout?.getCode())
                    break
                case LayoutType.GROUP:
                    var layout: [RowLayout]? = nil
                    var itemGroupLayout: GroupLayout? = nil
                    XCTAssertNoThrow(itemGroupLayout = itemLayout as? GroupLayout)
                    XCTAssertNotNil(itemGroupLayout?.getCode())
                    XCTAssertNotNil(layout = itemGroupLayout?.getLayout())
                    XCTAssertGreaterThanOrEqual((layout?.count)!, 0)
                    self.testGroupLayoutSuccess(layout)
                    break
                }
            }
            }.catch{ error in
                var errorString = ""
                if (type(of: error) == KintoneAPIException.self) {
                    errorString = (error as! KintoneAPIException).toString()!
                } else {
                    errorString = error.localizedDescription
                }
                XCTFail(errorString)
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
    
    func testGroupLayoutSuccess(_ rowLayouts: [RowLayout]?)
    {
        var fields: [FieldLayout]? = nil
        for rowLayout in rowLayouts!
        {
            var itemLayoutType: LayoutType? = nil
            XCTAssertNotNil(itemLayoutType = rowLayout.getType()!)
            XCTAssertTrue(type(of: itemLayoutType!) == LayoutType.self)
            switch itemLayoutType!
            {
                case LayoutType.ROW:
                    var itemRowLayout: RowLayout? = nil
                    XCTAssertNoThrow(itemRowLayout = rowLayout as RowLayout)
                    XCTAssertNotNil(fields = itemRowLayout?.getFields())
                    XCTAssertGreaterThanOrEqual((fields?.count)!, 1)
                    break
                case LayoutType.SUBTABLE:
                    XCTFail()
                    break
                case LayoutType.GROUP:
                    XCTFail()
                    break
            }
        }
    }
    
    func testGetAppFormLayoutFailWhenAppIDNotExist()
    {
        let appId = 99999
        self.app?.getFormLayout(appId).then{ response in
            XCTFail("No errors occurred")
            }.catch{ error in
                XCTAssert(type(of: error) == KintoneAPIException.self)
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
}
