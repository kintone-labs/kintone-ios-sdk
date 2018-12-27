//  Copyright © 2018 Cybozu. All rights reserved.

import XCTest
@testable import kintone_ios_sdk
@testable import Promises

class UpdateFormLayoutTest: XCTestCase {

    private let USERNAME = TestsConstants.ADMIN_USERNAME
    private let PASSWORD = TestsConstants.ADMIN_PASSWORD
    private let APP_ID = AppTestConstants.UPDATE_FORM_LAYOUT_APP_ID
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
    
    func testUpdateAppFormLayoutSuccess()
    {
        var itemLayoutRequest: [ItemLayout] = [ItemLayout]()
     
        // Row Layout
        let rowLayout1: RowLayout? = RowLayout()
        var fieldsRowLayout1: [FieldLayout]? = [FieldLayout]()
        
        let singleFieldRowLayout1: FieldLayout? = FieldLayout()
        singleFieldRowLayout1?.setCode("Text")
        singleFieldRowLayout1?.setType(FieldType.SINGLE_LINE_TEXT.rawValue)
        let singleFieldSizeRowLayout1: FieldSize? = FieldSize()
        singleFieldSizeRowLayout1?.setWidth("193")
        singleFieldRowLayout1?.setSize(singleFieldSizeRowLayout1)
        fieldsRowLayout1?.append(singleFieldRowLayout1!)
     
        let richTextFieldRowLayout1: FieldLayout? = FieldLayout()
        richTextFieldRowLayout1?.setCode("Rich_text")
        richTextFieldRowLayout1?.setType(FieldType.RICH_TEXT.rawValue)
        let richTextFieldSizeRowLayout1: FieldSize? = FieldSize()
        richTextFieldSizeRowLayout1?.setWidth("315")
        richTextFieldSizeRowLayout1?.setInnerHeight("125")
        richTextFieldRowLayout1?.setSize(richTextFieldSizeRowLayout1)
        fieldsRowLayout1?.append(richTextFieldRowLayout1!)
        
        rowLayout1?.setFields(fieldsRowLayout1)
        
        // Subtable Layout
        let subTableLayout: SubTableLayout? = SubTableLayout()
        var fieldSubTableLayout: [FieldLayout]? = [FieldLayout]()
        
        let singleFieldSubTableLayout1: FieldLayout? = FieldLayout()
        singleFieldSubTableLayout1?.setCode("Text_0")
        singleFieldSubTableLayout1?.setType(FieldType.SINGLE_LINE_TEXT.rawValue)
        let singleFieldSizeSubTableLayout1: FieldSize? = FieldSize()
        singleFieldSizeSubTableLayout1?.setWidth("193")
        singleFieldSubTableLayout1?.setSize(singleFieldSizeSubTableLayout1)
        
        fieldSubTableLayout?.append(singleFieldSubTableLayout1!)
        subTableLayout?.setFields(fieldSubTableLayout)
        subTableLayout?.setCode("Table")
        
        // GROUP Layout
        let groupLayout: GroupLayout? = GroupLayout()
        var rowLayoutInGroup: [RowLayout]? = [RowLayout]()
        // Row Layout
        let firstRowLayoutInGroup: RowLayout? = RowLayout()
        var fieldsInRowLayoutInGroup: [FieldLayout]? = [FieldLayout]()
        // Numeric Field Layout
        let numericFieldInRowLayoutInGroup: FieldLayout? = FieldLayout()
        numericFieldInRowLayoutInGroup?.setCode("Number")
        numericFieldInRowLayoutInGroup?.setType(FieldType.NUMBER.rawValue)
        // field size
        let numericFieldSizeInRowLayoutInGroup: FieldSize? = FieldSize()
        numericFieldSizeInRowLayoutInGroup?.setWidth("200")
        numericFieldInRowLayoutInGroup?.setSize(numericFieldSizeInRowLayoutInGroup)
        
        fieldsInRowLayoutInGroup?.append(numericFieldInRowLayoutInGroup!)
        firstRowLayoutInGroup?.setFields(fieldsInRowLayoutInGroup)
        rowLayoutInGroup?.append(firstRowLayoutInGroup!)
        groupLayout?.setLayout(rowLayoutInGroup)
        groupLayout?.setCode("Field_group")
        
        // Append layout
        itemLayoutRequest.append(rowLayout1!)
        itemLayoutRequest.append(subTableLayout!)
        itemLayoutRequest.append(groupLayout!)
        
        self.app?.updateFormLayout(self.APP_ID, itemLayoutRequest).then{ basicResponse in
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
    
    func testUpdateAppFormLayoutFailWhenAppIdNotExist()
    {
        let appId = 99999
        var itemLayoutRequest: [ItemLayout] = [ItemLayout]()
        
        // Row Layout
        let rowLayout1: RowLayout? = RowLayout()
        var fieldsRowLayout1: [FieldLayout]? = [FieldLayout]()
        
        let singleFieldRowLayout1: FieldLayout? = FieldLayout()
        singleFieldRowLayout1?.setCode("Text")
        singleFieldRowLayout1?.setType(FieldType.SINGLE_LINE_TEXT.rawValue)
        let singleFieldSizeRowLayout1: FieldSize? = FieldSize()
        singleFieldSizeRowLayout1?.setWidth("193")
        singleFieldRowLayout1?.setSize(singleFieldSizeRowLayout1)
        fieldsRowLayout1?.append(singleFieldRowLayout1!)
        
        let richTextFieldRowLayout1: FieldLayout? = FieldLayout()
        richTextFieldRowLayout1?.setCode("Rich_text")
        richTextFieldRowLayout1?.setType(FieldType.RICH_TEXT.rawValue)
        let richTextFieldSizeRowLayout1: FieldSize? = FieldSize()
        richTextFieldSizeRowLayout1?.setWidth("315")
        richTextFieldSizeRowLayout1?.setInnerHeight("125")
        richTextFieldRowLayout1?.setSize(richTextFieldSizeRowLayout1)
        fieldsRowLayout1?.append(richTextFieldRowLayout1!)
        
        rowLayout1?.setFields(fieldsRowLayout1)
        
        // Subtable Layout
        let subTableLayout: SubTableLayout? = SubTableLayout()
        var fieldSubTableLayout: [FieldLayout]? = [FieldLayout]()
        
        let singleFieldSubTableLayout1: FieldLayout? = FieldLayout()
        singleFieldSubTableLayout1?.setCode("Text_0")
        singleFieldSubTableLayout1?.setType(FieldType.SINGLE_LINE_TEXT.rawValue)
        let singleFieldSizeSubTableLayout1: FieldSize? = FieldSize()
        singleFieldSizeSubTableLayout1?.setWidth("193")
        singleFieldSubTableLayout1?.setSize(singleFieldSizeSubTableLayout1)
        
        fieldSubTableLayout?.append(singleFieldSubTableLayout1!)
        subTableLayout?.setFields(fieldSubTableLayout)
        subTableLayout?.setCode("Table")
        
        // GROUP Layout
        let groupLayout: GroupLayout? = GroupLayout()
        var rowLayoutInGroup: [RowLayout]? = [RowLayout]()
        // Row Layout
        let firstRowLayoutInGroup: RowLayout? = RowLayout()
        var fieldsInRowLayoutInGroup: [FieldLayout]? = [FieldLayout]()
        // Numeric Field Layout
        let numericFieldInRowLayoutInGroup: FieldLayout? = FieldLayout()
        numericFieldInRowLayoutInGroup?.setCode("Number")
        numericFieldInRowLayoutInGroup?.setType(FieldType.NUMBER.rawValue)
        // field size
        let numericFieldSizeInRowLayoutInGroup: FieldSize? = FieldSize()
        numericFieldSizeInRowLayoutInGroup?.setWidth("200")
        numericFieldInRowLayoutInGroup?.setSize(numericFieldSizeInRowLayoutInGroup)
        
        fieldsInRowLayoutInGroup?.append(numericFieldInRowLayoutInGroup!)
        firstRowLayoutInGroup?.setFields(fieldsInRowLayoutInGroup)
        rowLayoutInGroup?.append(firstRowLayoutInGroup!)
        groupLayout?.setLayout(rowLayoutInGroup)
        groupLayout?.setCode("Field_group")
        
        // Append layout
        itemLayoutRequest.append(rowLayout1!)
        itemLayoutRequest.append(subTableLayout!)
        itemLayoutRequest.append(groupLayout!)
        
        self.app?.updateFormLayout(appId, itemLayoutRequest).then{ response in
            XCTFail("No errors occurred")
            }.catch{ error in
                XCTAssert(type(of: error) == KintoneAPIException.self)
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
}
