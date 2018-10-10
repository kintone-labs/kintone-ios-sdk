//
//  Copyright © 2018 Cybozu. All rights reserved.

import XCTest
import kintone_ios_sdk

class UpdateViewsTest: XCTestCase {
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

    func testUpdateViewsSuccess() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var updateViewResponse: UpdateViewsResponse? = nil
        var viewEntry: [String: ViewModel] = [String: ViewModel]()
        let updateViewModel: ViewModel = ViewModel()
        updateViewModel.setName("ViewTest")
        updateViewModel.setSort("Record_number desc")
        updateViewModel.setType(ViewModel.ViewType.LIST)
        updateViewModel.setFilterCond("Created_datetime = LAST_WEEK()")
        updateViewModel.setIndex(1)
        let fieldsViews: [String] = ["Text", "Text_Area", "Created_datetime"]
        updateViewModel.setFields(fieldsViews)
        viewEntry["ViewTest"] = updateViewModel
        
        let updateViewModel2: ViewModel = ViewModel()
        updateViewModel2.setName("ViewTest2")
        updateViewModel2.setSort("Record_number asc")
        updateViewModel2.setType(ViewModel.ViewType.LIST)
        updateViewModel2.setFilterCond("Created_datetime > LAST_WEEK()")
        updateViewModel2.setIndex(0)
        
        let fieldsInViews2: [String] = ["Text_Area", "Created_datetime"]
        updateViewModel2.setFields(fieldsInViews2)
        
        viewEntry["ViewTest2"] = updateViewModel2
        XCTAssertNoThrow(updateViewResponse = try self.app?.updateViews(self.APP_ID, viewEntry))
        XCTAssertNotNil(updateViewResponse?.getRevision())

        var viewResultEntry: ViewModel? = nil
        var viewResultDict: [String: ViewModel] = [String: ViewModel]()
        XCTAssertNotNil(viewResultDict = (updateViewResponse?.getViews())!)
        
        XCTAssertNotNil(viewResultEntry = viewResultDict["ViewTest2"])
        XCTAssertNotNil(viewResultEntry?.getId())
    }
    
    func testGetViewsFailWhenAppIDNotExist() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let appId: Int = 99999
        var viewEntry: [String: ViewModel] = [String: ViewModel]()
        let updateViewModel: ViewModel = ViewModel()
        updateViewModel.setName("ViewTest")
        updateViewModel.setSort("Record_number desc")
        updateViewModel.setType(ViewModel.ViewType.LIST)
        updateViewModel.setFilterCond("Created_datetime = LAST_WEEK()")
        updateViewModel.setIndex(1)
        let fieldsViews: [String] = ["Text", "Text_Area", "Created_datetime"]
        updateViewModel.setFields(fieldsViews)
        viewEntry["ViewTest"] = updateViewModel
        
        let updateViewModel2: ViewModel = ViewModel()
        updateViewModel2.setName("ViewTest2")
        updateViewModel2.setSort("Record_number asc")
        updateViewModel2.setType(ViewModel.ViewType.LIST)
        updateViewModel2.setFilterCond("Created_datetime > LAST_WEEK()")
        updateViewModel2.setIndex(0)
        
        let fieldsInViews2: [String] = ["Text_Area", "Created_datetime"]
        updateViewModel2.setFields(fieldsInViews2)
        
        viewEntry["ViewTest2"] = updateViewModel2
        XCTAssertThrowsError(try self.app?.updateViews(appId, viewEntry))
        {
             error in XCTAssert(type(of: error) == KintoneAPIException.self)
        }
    }

}
