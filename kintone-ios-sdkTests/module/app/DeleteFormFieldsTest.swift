//  Copyright © 2018 Cybozu. All rights reserved.

import XCTest
import kintone_ios_sdk

class DeleteFormFieldsTest: XCTestCase {
    private let USERNAME = "Phien"
    private let PASSWORD = "Phien"
    private let APP_ID = 1698
    private let LANG = LanguageSetting.EN
    private let REVISIONs = -1
    private var app: App? = nil
    private var connection: Connection? = nil
    private let fieldCodeTest: String = "Delete_Text"
    
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
        do {
            try self.app?.addFormFields(self.APP_ID, properties)
        } catch let error as KintoneAPIException {
            print(error)
        } catch {
            
        }
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        do {
            var fieldCodes: [String] = [String]()
            fieldCodes.append(fieldCodeTest)
            try self.app?.deleteFormFields(self.APP_ID, fieldCodes)
        } catch let error as KintoneAPIException {
            print(error)
        } catch {
            
        }
    }
    
    func testDeleteFormFieldsSuccess()
    {
        var fieldCodes: [String] = [String]()
        fieldCodes.append(fieldCodeTest)
        var basicResponse: BasicResponse? = nil
        XCTAssertNoThrow(basicResponse = try self.app?.deleteFormFields(self.APP_ID, fieldCodes))
        XCTAssertNotNil(basicResponse?.getRevision())
    }
    
    func testDeleteFormFieldsFailWhenAppIDNotExist()
    {
        let appId = 99999
        var fieldCodes: [String] = [String]()
        fieldCodes.append(fieldCodeTest)
        
        XCTAssertThrowsError(try self.app?.deleteFormFields(appId, fieldCodes))
        {
            error in XCTAssert(type(of: error) == KintoneAPIException.self)
        }
    }

}
