//  Copyright © 2018 Cybozu. All rights reserved.

import XCTest
import kintone_ios_sdk

class GetFormFieldsTest: XCTestCase {
    private let USERNAME = "Phien"
    private let PASSWORD = "Phien"
    private let APP_ID = 1698
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
    
    func testGetFormFieldsSuccess()
    {
        var formFieldsResponse: FormFields? = nil
        XCTAssertNoThrow(formFieldsResponse = try self.app?.getFormFields(self.APP_ID, self.LANG))
        XCTAssertNotNil(formFieldsResponse)
        
        XCTAssertNotNil(formFieldsResponse?.getRevision())
        XCTAssertNotNil(formFieldsResponse?.getProperties())
        
        let properties: [String: Field] = (formFieldsResponse?.getProperties())!
        for (fieldCode, field) in properties {
            XCTAssertNotNil(field.getCode())
            XCTAssertEqual(fieldCode, field.getCode())
            XCTAssert(type(of: field.getType()!) == FieldType.self)
            switch field.getType()! {
            case FieldType.SINGLE_LINE_TEXT:
                XCTAssert(type(of: field) == SingleLineTextField.self)
                break
            case FieldType.CATEGORY:
                XCTAssert(type(of: field) == CategoryField.self)
                break
            case FieldType.STATUS_ASSIGNEE:
                XCTAssert(type(of: field) == AssigneeField.self)
                break
            case FieldType.STATUS:
                XCTAssert(type(of: field) == StatusField.self)
                break
            case FieldType.RECORD_NUMBER:
                XCTAssert(type(of: field) == RecordNumberField.self)
                break
            case FieldType.CREATED_TIME:
                XCTAssert(type(of: field) == CreatedTimeField.self)
                break
            case FieldType.UPDATED_TIME:
                XCTAssert(type(of: field) == UpdatedTimeField.self)
                break
            case FieldType.CREATOR:
                XCTAssert(type(of: field) == CreatorField.self)
                break
            case FieldType.MODIFIER:
                XCTAssert(type(of: field) == ModifierField.self)
                break
            default:
                break
            }
        }
    }
    
    func testGetFormFieldsFailWhenAppIDNotExist() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let appId: Int = 99999
        
        XCTAssertThrowsError(try self.app?.getFormFields(appId, self.LANG))
        {
            error in XCTAssert(type(of: error) == KintoneAPIException.self)
        }
    }
}
