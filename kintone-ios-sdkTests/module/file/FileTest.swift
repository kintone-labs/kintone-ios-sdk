//
//  FileTest.swift
//  kintone-ios-sdkTests
//
//  Created by t000572 on 2018/10/10.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

import XCTest
@testable import kintone_ios_sdk

class FileTest: XCTestCase {
    
    private let API_TOKEN = "ZH7DTY4uURdMBvobSGDp9qTpxIPwAuBzHhO23J2h"
    private let APP_ID = 1692
    
    private var fileManagement: File?
    private var recordManagement: Record?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // set auth
        let auth = Auth()
        auth.setApiToken(self.API_TOKEN)
        let con = Connection(TestsConstants.DOMAIN, auth)
        
        // instance of Record and file class
        self.fileManagement = File(con)
        self.recordManagement = Record(con)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUploadSuccessForSingleFile() throws {
        // create test data for file upload
        var fileTestRecord: Dictionary<String, FieldValue> = [:]
        fileTestRecord = addData(fileTestRecord, "SINGLE_LINE_TEXT", FieldType.SINGLE_LINE_TEXT, "testUploadSuccessForSingleFile")
        
        // exec upload and result check
        var fileResponse: FileModel? = nil
        let testBundle = Bundle(for: type(of: self))
        if let upload_file_path = testBundle.url(forResource: "test", withExtension: "txt"){
            XCTAssertNoThrow(fileResponse = (try self.fileManagement?.upload(upload_file_path.absoluteString)))
        }
        
        // exec add record
        let fileList = [fileResponse]
        fileTestRecord = addData(fileTestRecord, "ATTACH_FILE_1", FieldType.FILE, fileList)
        let addResponse: AddRecordResponse? = try self.recordManagement?.addRecord(self.APP_ID, fileTestRecord)
        
        // exec get record
        let recId = addResponse?.getId()
        let getResponse: GetRecordResponse? = try self.recordManagement?.getRecord(self.APP_ID, recId!)
        
        // result check
        let fileResult: [FileModel] = getResponse?.getRecord()!["ATTACH_FILE_1"]!.getValue() as! [FileModel]
        XCTAssertEqual(1, fileResult.count)
        XCTAssertNotNil(fileResult[0].getSize())
        XCTAssertEqual("test.txt", fileResult[0].getName())
        XCTAssertNotNil(fileResult[0].getFileKey())
        XCTAssertNotNil(fileResult[0].getContentType()!)
    }
    
    func testUploadSuccessForMultiFile() throws {
        // create test data for file upload
        var fileTestRecord: Dictionary<String, FieldValue> = [:]
        fileTestRecord = addData(fileTestRecord, "SINGLE_LINE_TEXT", FieldType.SINGLE_LINE_TEXT, "testUploadSuccessForMultiFile")
        
        // exec upload and result check
        var fileResponse1: FileModel? = nil
        var fileResponse2: FileModel? = nil
        var fileResponse3: FileModel? = nil
        let testBundle = Bundle(for: type(of: self))
        if let upload_file_path1 = testBundle.url(forResource: "test", withExtension: "txt"){
            XCTAssertNoThrow(fileResponse1 = (try self.fileManagement?.upload(upload_file_path1.absoluteString)))
        }
        if let upload_file_path2 = testBundle.url(forResource: "test", withExtension: "pptx"){
            XCTAssertNoThrow(fileResponse2 = (try self.fileManagement?.upload(upload_file_path2.absoluteString)))
        }
        if let upload_file_path3 = testBundle.url(forResource: "test", withExtension: "xlsx"){
            XCTAssertNoThrow(fileResponse3 = (try self.fileManagement?.upload(upload_file_path3.absoluteString)))
        }
        
        // exec add record
        let fileList = [fileResponse1, fileResponse2, fileResponse3]
        fileTestRecord = addData(fileTestRecord, "ATTACH_FILE_1", FieldType.FILE, fileList)
        let addResponse: AddRecordResponse? = try self.recordManagement?.addRecord(self.APP_ID, fileTestRecord)
        
        // exec get record
        let recId = addResponse?.getId()
        let getResponse: GetRecordResponse? = try self.recordManagement?.getRecord(self.APP_ID, recId!)
        
        // result check
        let fileResults: [FileModel] = getResponse?.getRecord()!["ATTACH_FILE_1"]!.getValue() as! [FileModel]
        XCTAssertEqual(3, fileResults.count)
        for fileResult in fileResults {
            XCTAssertNotNil(fileResult.getSize())
            XCTAssertNotNil(fileResult.getName())
            XCTAssertNotNil(fileResult.getFileKey())
            XCTAssertNotNil(fileResult.getContentType()!)
        }
    }
    
    func testUploadSuccessForSingleFileToMultiField() throws {
        // create test data for file upload
        var fileTestRecord: Dictionary<String, FieldValue> = [:]
        fileTestRecord = addData(fileTestRecord, "SINGLE_LINE_TEXT", FieldType.SINGLE_LINE_TEXT, "testUploadSuccessForSingleFileToMultiField")
        
        // exec upload and result check
        var fileResponse1: FileModel? = nil
        var fileResponse2: FileModel? = nil
        var fileResponse3: FileModel? = nil
        let testBundle = Bundle(for: type(of: self))
        if let upload_file_path1 = testBundle.url(forResource: "test", withExtension: "txt"){
            XCTAssertNoThrow(fileResponse1 = (try self.fileManagement?.upload(upload_file_path1.absoluteString)))
        }
        if let upload_file_path2 = testBundle.url(forResource: "test", withExtension: "pptx"){
            XCTAssertNoThrow(fileResponse2 = (try self.fileManagement?.upload(upload_file_path2.absoluteString)))
        }
        if let upload_file_path3 = testBundle.url(forResource: "test", withExtension: "xlsx"){
            XCTAssertNoThrow(fileResponse3 = (try self.fileManagement?.upload(upload_file_path3.absoluteString)))
        }
        
        // exec add record
        let fileList1 = [fileResponse1]
        let fileList2 = [fileResponse2]
        let fileList3 = [fileResponse3]
        fileTestRecord = addData(fileTestRecord, "ATTACH_FILE_1", FieldType.FILE, fileList1)
        fileTestRecord = addData(fileTestRecord, "ATTACH_FILE_2", FieldType.FILE, fileList2)
        fileTestRecord = addData(fileTestRecord, "ATTACH_FILE_3", FieldType.FILE, fileList3)
        let addResponse: AddRecordResponse? = try self.recordManagement?.addRecord(self.APP_ID, fileTestRecord)
        
        // exec get record
        let recId = addResponse?.getId()
        let getResponse: GetRecordResponse? = try self.recordManagement?.getRecord(self.APP_ID, recId!)
        
        // result check
        let fileResult1: [FileModel] = getResponse?.getRecord()!["ATTACH_FILE_1"]!.getValue() as! [FileModel]
        let fileResult2: [FileModel] = getResponse?.getRecord()!["ATTACH_FILE_2"]!.getValue() as! [FileModel]
        let fileResult3: [FileModel] = getResponse?.getRecord()!["ATTACH_FILE_3"]!.getValue() as! [FileModel]
        XCTAssertEqual(1, fileResult1.count)
        XCTAssertEqual(1, fileResult2.count)
        XCTAssertEqual(1, fileResult3.count)
        XCTAssertNotNil(fileResult1[0].getSize())
        XCTAssertNotNil(fileResult2[0].getSize())
        XCTAssertNotNil(fileResult3[0].getSize())
        XCTAssertEqual("test.txt", fileResult1[0].getName())
        XCTAssertEqual("test.pptx", fileResult2[0].getName())
        XCTAssertEqual("test.xlsx", fileResult3[0].getName())
        XCTAssertNotNil(fileResult1[0].getFileKey())
        XCTAssertNotNil(fileResult2[0].getFileKey())
        XCTAssertNotNil(fileResult3[0].getFileKey())
        XCTAssertNotNil(fileResult1[0].getContentType()!)
        XCTAssertNotNil(fileResult2[0].getContentType()!)
        XCTAssertNotNil(fileResult3[0].getContentType()!)
    }
    
    func testUploadSuccessForMultiFileToMultiField() throws {
        // create test data for file upload
        var fileTestRecord: Dictionary<String, FieldValue> = [:]
        fileTestRecord = addData(fileTestRecord, "SINGLE_LINE_TEXT", FieldType.SINGLE_LINE_TEXT, "testUploadSuccessForMultiFileToMultiField")
        
        // exec upload and result check
        var fileResponse1_1: FileModel? = nil
        var fileResponse1_2: FileModel? = nil
        var fileResponse1_3: FileModel? = nil
        var fileResponse2_1: FileModel? = nil
        var fileResponse2_2: FileModel? = nil
        var fileResponse2_3: FileModel? = nil
        var fileResponse3_1: FileModel? = nil
        var fileResponse3_2: FileModel? = nil
        var fileResponse3_3: FileModel? = nil
        let testBundle = Bundle(for: type(of: self))
        if let upload_file_path1_1 = testBundle.url(forResource: "test", withExtension: "txt"){
            XCTAssertNoThrow(fileResponse1_1 = (try self.fileManagement?.upload(upload_file_path1_1.absoluteString)))
        }
        if let upload_file_path1_2 = testBundle.url(forResource: "test", withExtension: "pptx"){
            XCTAssertNoThrow(fileResponse1_2 = (try self.fileManagement?.upload(upload_file_path1_2.absoluteString)))
        }
        if let upload_file_path1_3 = testBundle.url(forResource: "test", withExtension: "xlsx"){
            XCTAssertNoThrow(fileResponse1_3 = (try self.fileManagement?.upload(upload_file_path1_3.absoluteString)))
        }
        if let upload_file_path2_1 = testBundle.url(forResource: "test", withExtension: "txt"){
            XCTAssertNoThrow(fileResponse2_1 = (try self.fileManagement?.upload(upload_file_path2_1.absoluteString)))
        }
        if let upload_file_path2_2 = testBundle.url(forResource: "test", withExtension: "pptx"){
            XCTAssertNoThrow(fileResponse2_2 = (try self.fileManagement?.upload(upload_file_path2_2.absoluteString)))
        }
        if let upload_file_path2_3 = testBundle.url(forResource: "test", withExtension: "xlsx"){
            XCTAssertNoThrow(fileResponse2_3 = (try self.fileManagement?.upload(upload_file_path2_3.absoluteString)))
        }
        if let upload_file_path3_1 = testBundle.url(forResource: "test", withExtension: "txt"){
            XCTAssertNoThrow(fileResponse3_1 = (try self.fileManagement?.upload(upload_file_path3_1.absoluteString)))
        }
        if let upload_file_path3_2 = testBundle.url(forResource: "test", withExtension: "pptx"){
            XCTAssertNoThrow(fileResponse3_2 = (try self.fileManagement?.upload(upload_file_path3_2.absoluteString)))
        }
        if let upload_file_path3_3 = testBundle.url(forResource: "test", withExtension: "xlsx"){
            XCTAssertNoThrow(fileResponse3_3 = (try self.fileManagement?.upload(upload_file_path3_3.absoluteString)))
        }
        
        // exec add record
        let fileList1 = [fileResponse1_1, fileResponse1_2, fileResponse1_3]
        let fileList2 = [fileResponse2_1, fileResponse2_2, fileResponse2_3]
        let fileList3 = [fileResponse3_1, fileResponse3_2, fileResponse3_3]
        fileTestRecord = addData(fileTestRecord, "ATTACH_FILE_1", FieldType.FILE, fileList1)
        fileTestRecord = addData(fileTestRecord, "ATTACH_FILE_2", FieldType.FILE, fileList2)
        fileTestRecord = addData(fileTestRecord, "ATTACH_FILE_3", FieldType.FILE, fileList3)
        let addResponse: AddRecordResponse? = try self.recordManagement?.addRecord(self.APP_ID, fileTestRecord)
        
        // exec get record
        let recId = addResponse?.getId()
        let getResponse: GetRecordResponse? = try self.recordManagement?.getRecord(self.APP_ID, recId!)
        
        // result check
        let fileResults1: [FileModel] = getResponse?.getRecord()!["ATTACH_FILE_1"]!.getValue() as! [FileModel]
        let fileResults2: [FileModel] = getResponse?.getRecord()!["ATTACH_FILE_2"]!.getValue() as! [FileModel]
        let fileResults3: [FileModel] = getResponse?.getRecord()!["ATTACH_FILE_3"]!.getValue() as! [FileModel]
        XCTAssertEqual(3, fileResults1.count)
        XCTAssertEqual(3, fileResults2.count)
        XCTAssertEqual(3, fileResults3.count)
        
        for fileResult1 in fileResults1 {
            XCTAssertNotNil(fileResult1.getSize())
            XCTAssertNotNil(fileResult1.getName())
            XCTAssertNotNil(fileResult1.getFileKey())
            XCTAssertNotNil(fileResult1.getContentType()!)
        }
        for fileResult2 in fileResults2 {
            XCTAssertNotNil(fileResult2.getSize())
            XCTAssertNotNil(fileResult2.getName())
            XCTAssertNotNil(fileResult2.getFileKey())
            XCTAssertNotNil(fileResult2.getContentType()!)
        }
        for fileResult3 in fileResults3 {
            XCTAssertNotNil(fileResult3.getSize())
            XCTAssertNotNil(fileResult3.getName())
            XCTAssertNotNil(fileResult3.getFileKey())
            XCTAssertNotNil(fileResult3.getContentType()!)
        }
    }
    
    func testUploadFailForUnexistFileKey() throws {
        do {
            try self.fileManagement?.upload("xxxxxxxxxxxxxxxxxxxxxxxxx")
        } catch let error as KintoneAPIException {
            XCTAssertNotNil(error)
        }
    }
    
    func testDownloadSuccessForSingleFile() throws {
        // create test data for file download
        var fileTestRecord: Dictionary<String, FieldValue> = [:]
        fileTestRecord = addData(fileTestRecord, "SINGLE_LINE_TEXT", FieldType.SINGLE_LINE_TEXT, "testDownloadSuccessForSingleFile")
        
        // exec upload and result check
        var fileResponse: FileModel? = nil
        let testBundle = Bundle(for: type(of: self))
        if let upload_file_path = testBundle.url(forResource: "test", withExtension: "txt"){
            fileResponse = (try self.fileManagement?.upload(upload_file_path.absoluteString))
        }
        
        // exec add record
        let fileList = [fileResponse]
        fileTestRecord = addData(fileTestRecord, "ATTACH_FILE_1", FieldType.FILE, fileList)
        let addResponse: AddRecordResponse? = try self.recordManagement?.addRecord(self.APP_ID, fileTestRecord)
        
        // exec get record
        let recId = addResponse?.getId()
        let getResponse: GetRecordResponse? = try self.recordManagement?.getRecord(self.APP_ID, recId!)
        
        // exec download file and result check
        let fileResult: [FileModel] = getResponse?.getRecord()!["ATTACH_FILE_1"]!.getValue() as! [FileModel]
        if let dowloadDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let pathFileName = dowloadDir.absoluteString + fileResult[0].getName()!
            XCTAssertNoThrow(try self.fileManagement?.download(fileResult[0].getFileKey()!, pathFileName))
        }
    }
    
    func testDownloadSuccessForMultiFile() throws {
        // create test data for file upload
        var fileTestRecord: Dictionary<String, FieldValue> = [:]
        fileTestRecord = addData(fileTestRecord, "SINGLE_LINE_TEXT", FieldType.SINGLE_LINE_TEXT, "testDownloadSuccessForMultiFile")
        
        // exec upload and result check
        var fileResponse1: FileModel? = nil
        var fileResponse2: FileModel? = nil
        var fileResponse3: FileModel? = nil
        let testBundle = Bundle(for: type(of: self))
        if let upload_file_path1 = testBundle.url(forResource: "test", withExtension: "txt"){
            XCTAssertNoThrow(fileResponse1 = (try self.fileManagement?.upload(upload_file_path1.absoluteString)))
        }
        if let upload_file_path2 = testBundle.url(forResource: "test", withExtension: "pptx"){
            XCTAssertNoThrow(fileResponse2 = (try self.fileManagement?.upload(upload_file_path2.absoluteString)))
        }
        if let upload_file_path3 = testBundle.url(forResource: "test", withExtension: "xlsx"){
            XCTAssertNoThrow(fileResponse3 = (try self.fileManagement?.upload(upload_file_path3.absoluteString)))
        }
        
        // exec add record
        let fileList = [fileResponse1, fileResponse2, fileResponse3]
        fileTestRecord = addData(fileTestRecord, "ATTACH_FILE_1", FieldType.FILE, fileList)
        let addResponse: AddRecordResponse? = try self.recordManagement?.addRecord(self.APP_ID, fileTestRecord)
        
        // exec get record
        let recId = addResponse?.getId()
        let getResponse: GetRecordResponse? = try self.recordManagement?.getRecord(self.APP_ID, recId!)
        
        // exec download file and result check
        let fileResults: [FileModel] = getResponse?.getRecord()!["ATTACH_FILE_1"]!.getValue() as! [FileModel]
        for fileResult in fileResults {
            if let dowloadDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let pathFileName = dowloadDir.absoluteString + fileResult.getName()!
                XCTAssertNoThrow(try self.fileManagement?.download(fileResult.getFileKey()!, pathFileName))
            }
        }
    }
    
    func testDownloadSuccessForSingleFileToMultiField() throws {
        // create test data for file upload
        var fileTestRecord: Dictionary<String, FieldValue> = [:]
        fileTestRecord = addData(fileTestRecord, "SINGLE_LINE_TEXT", FieldType.SINGLE_LINE_TEXT, "testDownloadSuccessForSingleFileToMultiField")
        
        // exec upload and result check
        var fileResponse1: FileModel? = nil
        var fileResponse2: FileModel? = nil
        var fileResponse3: FileModel? = nil
        let testBundle = Bundle(for: type(of: self))
        if let upload_file_path1 = testBundle.url(forResource: "test", withExtension: "txt"){
            XCTAssertNoThrow(fileResponse1 = (try self.fileManagement?.upload(upload_file_path1.absoluteString)))
        }
        if let upload_file_path2 = testBundle.url(forResource: "test", withExtension: "pptx"){
            XCTAssertNoThrow(fileResponse2 = (try self.fileManagement?.upload(upload_file_path2.absoluteString)))
        }
        if let upload_file_path3 = testBundle.url(forResource: "test", withExtension: "xlsx"){
            XCTAssertNoThrow(fileResponse3 = (try self.fileManagement?.upload(upload_file_path3.absoluteString)))
        }
        
        // exec add record
        let fileList1 = [fileResponse1]
        let fileList2 = [fileResponse2]
        let fileList3 = [fileResponse3]
        fileTestRecord = addData(fileTestRecord, "ATTACH_FILE_1", FieldType.FILE, fileList1)
        fileTestRecord = addData(fileTestRecord, "ATTACH_FILE_2", FieldType.FILE, fileList2)
        fileTestRecord = addData(fileTestRecord, "ATTACH_FILE_3", FieldType.FILE, fileList3)
        let addResponse: AddRecordResponse? = try self.recordManagement?.addRecord(self.APP_ID, fileTestRecord)
        
        // exec get record
        let recId = addResponse?.getId()
        let getResponse: GetRecordResponse? = try self.recordManagement?.getRecord(self.APP_ID, recId!)
        
        // exec download file and result check
        let fileResult1: [FileModel] = getResponse?.getRecord()!["ATTACH_FILE_1"]!.getValue() as! [FileModel]
        let fileResult2: [FileModel] = getResponse?.getRecord()!["ATTACH_FILE_2"]!.getValue() as! [FileModel]
        let fileResult3: [FileModel] = getResponse?.getRecord()!["ATTACH_FILE_3"]!.getValue() as! [FileModel]
        if let dowloadDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let pathFileName1 = dowloadDir.absoluteString + fileResult1[0].getName()!
            XCTAssertNoThrow(try self.fileManagement?.download(fileResult1[0].getFileKey()!, pathFileName1))
            let pathFileName2 = dowloadDir.absoluteString + fileResult2[0].getName()!
            XCTAssertNoThrow(try self.fileManagement?.download(fileResult2[0].getFileKey()!, pathFileName2))
            let pathFileName3 = dowloadDir.absoluteString + fileResult3[0].getName()!
            XCTAssertNoThrow(try self.fileManagement?.download(fileResult3[0].getFileKey()!, pathFileName3))
        }
    }
    
    func testDownloadSuccessForMultiFileToMultiField() throws {
        // create test data for file upload
        var fileTestRecord: Dictionary<String, FieldValue> = [:]
        fileTestRecord = addData(fileTestRecord, "SINGLE_LINE_TEXT", FieldType.SINGLE_LINE_TEXT, "testDownloadSuccessForMultiFileToMultiField")
        
        // exec upload and result check
        var fileResponse1_1: FileModel? = nil
        var fileResponse1_2: FileModel? = nil
        var fileResponse1_3: FileModel? = nil
        var fileResponse2_1: FileModel? = nil
        var fileResponse2_2: FileModel? = nil
        var fileResponse2_3: FileModel? = nil
        var fileResponse3_1: FileModel? = nil
        var fileResponse3_2: FileModel? = nil
        var fileResponse3_3: FileModel? = nil
        let testBundle = Bundle(for: type(of: self))
        if let upload_file_path1_1 = testBundle.url(forResource: "test", withExtension: "txt"){
            XCTAssertNoThrow(fileResponse1_1 = (try self.fileManagement?.upload(upload_file_path1_1.absoluteString)))
        }
        if let upload_file_path1_2 = testBundle.url(forResource: "test", withExtension: "pptx"){
            XCTAssertNoThrow(fileResponse1_2 = (try self.fileManagement?.upload(upload_file_path1_2.absoluteString)))
        }
        if let upload_file_path1_3 = testBundle.url(forResource: "test", withExtension: "xlsx"){
            XCTAssertNoThrow(fileResponse1_3 = (try self.fileManagement?.upload(upload_file_path1_3.absoluteString)))
        }
        if let upload_file_path2_1 = testBundle.url(forResource: "test", withExtension: "txt"){
            XCTAssertNoThrow(fileResponse2_1 = (try self.fileManagement?.upload(upload_file_path2_1.absoluteString)))
        }
        if let upload_file_path2_2 = testBundle.url(forResource: "test", withExtension: "pptx"){
            XCTAssertNoThrow(fileResponse2_2 = (try self.fileManagement?.upload(upload_file_path2_2.absoluteString)))
        }
        if let upload_file_path2_3 = testBundle.url(forResource: "test", withExtension: "xlsx"){
            XCTAssertNoThrow(fileResponse2_3 = (try self.fileManagement?.upload(upload_file_path2_3.absoluteString)))
        }
        if let upload_file_path3_1 = testBundle.url(forResource: "test", withExtension: "txt"){
            XCTAssertNoThrow(fileResponse3_1 = (try self.fileManagement?.upload(upload_file_path3_1.absoluteString)))
        }
        if let upload_file_path3_2 = testBundle.url(forResource: "test", withExtension: "pptx"){
            XCTAssertNoThrow(fileResponse3_2 = (try self.fileManagement?.upload(upload_file_path3_2.absoluteString)))
        }
        if let upload_file_path3_3 = testBundle.url(forResource: "test", withExtension: "xlsx"){
            XCTAssertNoThrow(fileResponse3_3 = (try self.fileManagement?.upload(upload_file_path3_3.absoluteString)))
        }
        
        // exec add record
        let fileList1 = [fileResponse1_1, fileResponse1_2, fileResponse1_3]
        let fileList2 = [fileResponse2_1, fileResponse2_2, fileResponse2_3]
        let fileList3 = [fileResponse3_1, fileResponse3_2, fileResponse3_3]
        fileTestRecord = addData(fileTestRecord, "ATTACH_FILE_1", FieldType.FILE, fileList1)
        fileTestRecord = addData(fileTestRecord, "ATTACH_FILE_2", FieldType.FILE, fileList2)
        fileTestRecord = addData(fileTestRecord, "ATTACH_FILE_3", FieldType.FILE, fileList3)
        let addResponse: AddRecordResponse? = try self.recordManagement?.addRecord(self.APP_ID, fileTestRecord)
        
        // exec get record
        let recId = addResponse?.getId()
        let getResponse: GetRecordResponse? = try self.recordManagement?.getRecord(self.APP_ID, recId!)
        
        // exec file download and result check
        let fileResults1: [FileModel] = getResponse?.getRecord()!["ATTACH_FILE_1"]!.getValue() as! [FileModel]
        let fileResults2: [FileModel] = getResponse?.getRecord()!["ATTACH_FILE_2"]!.getValue() as! [FileModel]
        let fileResults3: [FileModel] = getResponse?.getRecord()!["ATTACH_FILE_3"]!.getValue() as! [FileModel]
        
        for fileResult1 in fileResults1 {
            if let dowloadDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let pathFileName = dowloadDir.absoluteString + "attach1/" + fileResult1.getName()!
                XCTAssertNoThrow(try self.fileManagement?.download(fileResult1.getFileKey()!, pathFileName))
            }
        }
        for fileResult2 in fileResults2 {
            if let dowloadDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let pathFileName = dowloadDir.absoluteString + "attach2/" + fileResult2.getName()!
                XCTAssertNoThrow(try self.fileManagement?.download(fileResult2.getFileKey()!, pathFileName))
            }
        }
        for fileResult3 in fileResults3 {
            if let dowloadDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let pathFileName = dowloadDir.absoluteString + "attach3/" + fileResult3.getName()!
                XCTAssertNoThrow(try self.fileManagement?.download(fileResult3.getFileKey()!, pathFileName))
            }
        }
    }
    
    func testDownloadFailForUnexistFileKey() throws {
        do {
            if let dowloadDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                try self.fileManagement?.download("12345678890", dowloadDir.absoluteString + "test.xtx")
            }
        } catch let error as KintoneAPIException {
            XCTAssertNotNil(error)
        }
    }
    
    private func addData(_ recData: Dictionary<String, FieldValue>, _ code: String, _ type: FieldType, _ value: Any) -> Dictionary<String, FieldValue> {
        
        var data = recData
        var field = FieldValue()
        field.setType(type)
        field.setValue(value)
        data[code] = field
        return data
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
