//  Copyright © 2018 Cybozu. All rights reserved.

import XCTest
@testable import kintone_ios_sdk
@testable import Promises

class UpdateFormFieldsTest: XCTestCase {
    private let USERNAME = "Phien"
    private let PASSWORD = "Phien"
    private let APP_ID = 1698
    private let LANG = LanguageSetting.EN
    private let REVISIONs = -1
    private var app: App? = nil
    private var connection: Connection? = nil
    private let fieldCode: String = "Text"

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
    
    func testUpdateFormFieldsSuccess()
    {
        // Create Field Object to Update
        let updateField = SingleLineTextField(fieldCode)
        updateField.setDefaultValue("Hello Kintone")
        updateField.setRequired(true)
        
        // Add Update Field object into dictionary with key is Field Code
        var properties = [String: Field]()
        properties[fieldCode] = updateField
        self.app?.updateFormFields(self.APP_ID, properties).then{ basicResponse in
            XCTAssertNotNil(basicResponse.getRevision())
            }.catch { error in
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
    
    func testUpdateFormFieldsFailWhenAppIDNotExist()
    {
        let appId = 99999
        // Create Field Object to Update
        let updateField = SingleLineTextField(fieldCode)
        updateField.setDefaultValue("Hello Kintone")
        updateField.setRequired(true)
        
        // Add Update Field object into dictionary with key is Field Code
        var properties = [String: Field]()
        properties[fieldCode] = updateField
        
        self.app?.updateFormFields(appId, properties).then{ response in
            XCTFail("No errors occurred")
            }.catch{ error in
                XCTAssert(type(of: error) == KintoneAPIException.self)
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
}
