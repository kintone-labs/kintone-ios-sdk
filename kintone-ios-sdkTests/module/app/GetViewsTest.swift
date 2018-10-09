//
//  Copyright © 2018 Cybozu. All rights reserved.

import XCTest
import kintone_ios_sdk

class GetViewsTest: XCTestCase {
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

    func testGetViewsSuccess() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let isPreview: Bool = true
        var appViewResponse: GetViewsResponse? = nil
        
        XCTAssertNoThrow(appViewResponse = try self.app?.getViews(self.APP_ID, self.LANG, isPreview))
        
        let results: [String:ViewModel]? = appViewResponse?.getViews()!
        
        XCTAssertNotNil(results)
        XCTAssertEqual(2, results?.count)
        
        var viewEntry: ViewModel? = nil
        XCTAssertNotNil(viewEntry = results!["ViewTest"])
        XCTAssertEqual("ViewTest", viewEntry?.getName()!)
        XCTAssertEqual("Record_number desc", viewEntry?.getSort()!)
        XCTAssertEqual("Created_datetime = LAST_WEEK()", viewEntry?.getFilterCond()!)
        XCTAssertNotNil(viewEntry?.getId())
        XCTAssertEqual(ViewModel.ViewType.LIST, viewEntry?.getType()!)
        
        XCTAssertEqual(3, viewEntry?.getFields()!.count)
        
        let fieldsViewsExpected: [String] = ["Text", "Text_Area", "Created_datetime"]
        XCTAssertEqual(fieldsViewsExpected, viewEntry?.getFields()!)
    }
    
    func testGetViewsFailWhenAppIDNotExist() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let appId: Int = 99999
        let isPreview: Bool = true
        
        XCTAssertThrowsError(try self.app!.getViews(appId, self.LANG, isPreview))
        {
            error in XCTAssert(type(of: error) == KintoneAPIException.self)
        }
    }
}
