//  Copyright © 2018 Cybozu. All rights reserved.

import XCTest
import kintone_ios_sdk

class AddFormFieldsTest: XCTestCase {
    private let USERNAME = "Phien"
    private let PASSWORD = "Phien"
    private let APP_ID = 1698
    private let LANG = LanguageSetting.EN
    private let REVISIONs = -1
    private var app: App? = nil
    private var connection: Connection? = nil
    private let fieldCode: String = "Radio_Text_Field"

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        var auth = Auth.init()
        auth = auth.setPasswordAuth(self.USERNAME, self.PASSWORD)
        self.connection = Connection(TestsConstants.DOMAIN, auth)
        self.app = App(self.connection!)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        do {
            var fieldWillDelete: [String]? = [String]()
            fieldWillDelete?.append(fieldCode)
            try self.app?.deleteFormFields(self.APP_ID, fieldWillDelete)
        } catch {
        }
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
        
        var basicResponse: BasicResponse? = nil
        XCTAssertNoThrow(basicResponse = try self.app?.addFormFields(self.APP_ID, properties))
        XCTAssertNotNil(basicResponse?.getRevision())
        
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
        
        XCTAssertThrowsError(try self.app?.addFormFields(appId, properties))
        {
            error in XCTAssert(type(of: error) == KintoneAPIException.self)
        }
    }

}
