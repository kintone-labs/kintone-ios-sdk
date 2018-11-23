//  Copyright © 2018 Cybozu. All rights reserved.

import XCTest
@testable import kintone_ios_sdk
@testable import Promises

class AddFormFieldsTest: XCTestCase {
    private let USERNAME = TestsConstants.ADMIN_USERNAME
    private let PASSWORD = TestsConstants.ADMIN_PASSWORD
    private let APP_ID = AppTestConstants.ADD_FORM_FIELDS_APP_ID
    private let LANG = LanguageSetting.EN
    private let REVISIONs = AppTestConstants.ADD_FORM_FIELDS_REVISION
    private var app: App? = nil
    private var connection: Connection? = nil
    private let fieldCode: String = AppTestConstants.ADD_FORM_FIELDS_FIELDCODE

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        var auth = Auth.init()
        auth = auth.setPasswordAuth(self.USERNAME, self.PASSWORD)
        self.connection = Connection(TestsConstants.DOMAIN, auth)
        self.app = App(self.connection!)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        var fieldWillDelete: [String]? = [String]()
        fieldWillDelete?.append(fieldCode)
        _ = self.app?.deleteFormFields(self.APP_ID, fieldWillDelete)
        _ = waitForPromises(timeout: 5)
    }

    func testAddFormFieldsSuccess()
    {
        // Create Radio field instance and set properties
        let addNewRadioField = RadioButtonField(fieldCode)
        var optionArray = [String: OptionData]()
        optionArray["1"] = OptionData("1","1")
        optionArray["2"] = OptionData("2","2")
        optionArray["3"] = OptionData("3","3")
        addNewRadioField.setOptions(optionArray)
        addNewRadioField.setNoLabel(false)
        addNewRadioField.setRequired(true)
        addNewRadioField.setLabel("Label Radio")
        addNewRadioField.setAlign(AlignLayout.VERTICAL)
        // Add Field object into dictionary with key is Field Code
        var properties = [String: Field]()
        properties[fieldCode] = addNewRadioField
        
        self.app?.addFormFields(self.APP_ID, properties).then{ basicResponse in
            XCTAssertNotNil(basicResponse.getRevision())
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

    func testAddFormFieldsFailWhenAppIDNotExist()
    {
        let appId = 99999
        // Create Radio field instance and set properties
        let addNewRadioField = RadioButtonField(fieldCode)
        var optionArray = [String: OptionData]()
        optionArray["1"] = OptionData("1","1")
        optionArray["2"] = OptionData("2","2")
        optionArray["3"] = OptionData("3","3")
        addNewRadioField.setOptions(optionArray)
        addNewRadioField.setNoLabel(false)
        addNewRadioField.setRequired(true)
        addNewRadioField.setLabel("Label Radio")
        addNewRadioField.setAlign(AlignLayout.VERTICAL)
        
        // Add Field object into dictionary with key is Field Code
        var properties = [String: Field]()
        properties[fieldCode] = addNewRadioField
        self.app?.addFormFields(appId, properties).then{ response in
            XCTFail("No errors occurred")
            }.catch{ error in
                XCTAssert(type(of: error) == KintoneAPIException.self)
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
}
