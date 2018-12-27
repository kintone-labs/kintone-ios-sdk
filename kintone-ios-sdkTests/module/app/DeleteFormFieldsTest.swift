//  Copyright © 2018 Cybozu. All rights reserved.

import XCTest
@testable import kintone_ios_sdk
@testable import Promises

class DeleteFormFieldsTest: XCTestCase {
    private let USERNAME = TestsConstants.ADMIN_USERNAME
    private let PASSWORD = TestsConstants.ADMIN_PASSWORD
    private let APP_ID = AppTestConstants.DELETE_FORM_FIELDS_APP_ID
    private let LANG = LanguageSetting.EN
    private let REVISIONs = AppTestConstants.DELETE_FORM_FIELDS_REVISION
    private var app: App? = nil
    private var connection: Connection? = nil
    private let fieldCodeTest: String = AppTestConstants.DELETE_FORM_FIELDS_FIELDCODE
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        var auth = Auth.init()
        auth = auth.setPasswordAuth(self.USERNAME, self.PASSWORD)
        self.connection = Connection(TestsConstants.DOMAIN, auth)
        self.app = App(self.connection!)
        let singleFielđTest = SingleLineTextField(fieldCodeTest)
        singleFielđTest.setDefaultValue("Test Field")
        singleFielđTest.setLabel("Test_Field")
        singleFielđTest.setRequired(true)
        singleFielđTest.setUnique(false)
        singleFielđTest.setExpression("")
        singleFielđTest.setCode(fieldCodeTest)
        
        // Add Update Field object into dictionary with key is Field Code
        var properties = [String: Field]()
        properties[fieldCodeTest] = singleFielđTest
        self.app?.addFormFields(self.APP_ID, properties).catch{ error in
            print((error as! KintoneAPIException).toString()!)
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        var fieldCodes: [String] = [String]()
        fieldCodes.append(fieldCodeTest)
        self.app?.deleteFormFields(self.APP_ID, fieldCodes).catch{ error in
            print((error as! KintoneAPIException).toString()!)
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
    
    func testDeleteFormFieldsSuccess()
    {
        var fieldCodes: [String] = [String]()
        fieldCodes.append(fieldCodeTest)
        self.app?.deleteFormFields(self.APP_ID, fieldCodes).then{ basicResponse in
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
    
    func testDeleteFormFieldsFailWhenAppIDNotExist()
    {
        let appId = 99999
        var fieldCodes: [String] = [String]()
        fieldCodes.append(fieldCodeTest)
        self.app?.deleteFormFields(appId, fieldCodes).then{ response in
            XCTFail("No errors occurred")
            }.catch{ error in
                XCTAssert(type(of: error) == KintoneAPIException.self)
        }
        XCTAssert(waitForPromises(timeout: 5))
    }

}
