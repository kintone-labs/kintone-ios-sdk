//
//  FileTest.swift
//  kintone-ios-sdkTests
//
//  Created by t000572 on 2018/10/10.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

import XCTest
@testable import kintone_ios_sdk
@testable import Promises

class FileTest: XCTestCase {
    
    private let API_TOKEN = "ZH7DTY4uURdMBvobSGDp9qTpxIPwAuBzHhO23J2h"
    private let APP_ID = 1692
    
    private var fileManagement: File?
    private var recordManagement: Record?
    private var connectionManagement: Connection?
    func addData(_ recData: Dictionary<String, FieldValue>, _ code: String, _ type: FieldType, _ value: Any) -> Dictionary<String, FieldValue> {
        var data = recData
        let field = FieldValue()
        field.setType(type)
        field.setValue(value)
        data[code] = field
        return data
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // set auth
        let auth = Auth()
        auth.setApiToken(self.API_TOKEN)
        connectionManagement = Connection(TestsConstants.DOMAIN, auth)
        
        // instance of Record and file class
        self.fileManagement = File(connectionManagement!)
        self.recordManagement = Record(connectionManagement!)
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
        let testBundle = Bundle(for: type(of: self))
        if let upload_file_path = testBundle.url(forResource: "test", withExtension: "txt"){
            self.fileManagement?.upload(upload_file_path.absoluteString).then{ fileResponse in
                // exec add record
                let fileList = [fileResponse]
                fileTestRecord = self.addData(fileTestRecord, "ATTACH_FILE_1", FieldType.FILE, fileList)
                self.recordManagement?.addRecord(self.APP_ID, fileTestRecord)
                    .then{ addResponse -> Promise<GetRecordResponse> in
                        let recId = addResponse.getId()
                        return (self.recordManagement?.getRecord(self.APP_ID, recId!))!
                    }.then { getResponse in
                        // result check
                        let fileResult: [FileModel] = getResponse.getRecord()!["ATTACH_FILE_1"]!.getValue() as! [FileModel]
                        XCTAssertEqual(1, fileResult.count)
                        XCTAssertNotNil(fileResult[0].getSize())
                        XCTAssertEqual("test.txt", fileResult[0].getName())
                        XCTAssertNotNil(fileResult[0].getFileKey())
                        XCTAssertNotNil(fileResult[0].getContentType()!)
                }
            }.catch{ error in
                XCTFail()
            }
            XCTAssert(waitForPromises(timeout: 50))
        }
        
    }
    
    func testUploadSuccessForMultiFile() throws {
        // create test data for file upload
        var fileTestRecord: Dictionary<String, FieldValue> = [:]
        fileTestRecord = addData(fileTestRecord, "SINGLE_LINE_TEXT", FieldType.SINGLE_LINE_TEXT, "testUploadSuccessForMultiFile")
        
        let testBundle = Bundle(for: type(of: self))
        guard let upload_file_path1 = testBundle.url(forResource: "test", withExtension: "txt") else {
            return XCTFail()
        }
        guard let upload_file_path2 = testBundle.url(forResource: "test", withExtension: "pptx")else {
            return XCTFail()
        }
        guard let upload_file_path3 = testBundle.url(forResource: "test", withExtension: "xlsx")else {
           return XCTFail()
        }
        all(
            (self.fileManagement?.upload(upload_file_path1.absoluteString))!,
            (self.fileManagement?.upload(upload_file_path2.absoluteString))!,
            (self.fileManagement?.upload(upload_file_path3.absoluteString))!
        ).then { fileResponse1, fileResponse2, fileResponse3 -> Promise<AddRecordResponse> in
            // exec add record
            let fileList = [fileResponse1, fileResponse2, fileResponse3]
            fileTestRecord = self.addData(fileTestRecord, "ATTACH_FILE_1", FieldType.FILE, fileList)
            return (self.recordManagement?.addRecord(self.APP_ID, fileTestRecord))!
        }.then{ addResponse -> Promise<GetRecordResponse> in
            // exec get record
            let recId = addResponse.getId()!
            return (self.recordManagement?.getRecord(self.APP_ID, recId))!
        }.then { getResponse in
            // result check
            let fileResults: [FileModel] = getResponse.getRecord()!["ATTACH_FILE_1"]!.getValue() as! [FileModel]
            XCTAssertEqual(3, fileResults.count)
            for fileResult in fileResults {
                XCTAssertNotNil(fileResult.getSize())
                XCTAssertNotNil(fileResult.getName())
                XCTAssertNotNil(fileResult.getFileKey())
                XCTAssertNotNil(fileResult.getContentType()!)
            }
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
    
    func testUploadSuccessForSingleFileToMultiField() throws {
        // create test data for file upload
        var fileTestRecord: Dictionary<String, FieldValue> = [:]
        fileTestRecord = addData(fileTestRecord, "SINGLE_LINE_TEXT", FieldType.SINGLE_LINE_TEXT, "testUploadSuccessForSingleFileToMultiField")
        
        let testBundle = Bundle(for: type(of: self))
        // exec upload and result check
        guard let upload_file_path1 = testBundle.url(forResource: "test", withExtension: "txt") else {
            return XCTFail()
        }
        guard let upload_file_path2 = testBundle.url(forResource: "test", withExtension: "pptx")else {
            return XCTFail()
        }
        guard let upload_file_path3 = testBundle.url(forResource: "test", withExtension: "xlsx")else {
            return XCTFail()
        }
        
        all(
            (self.fileManagement?.upload(upload_file_path1.absoluteString))!,
            (self.fileManagement?.upload(upload_file_path2.absoluteString))!,
            (self.fileManagement?.upload(upload_file_path3.absoluteString))!
        ).then { fileResponse1, fileResponse2, fileResponse3 -> Promise<AddRecordResponse> in
            // exec add record
            let fileList1 = [fileResponse1]
            let fileList2 = [fileResponse2]
            let fileList3 = [fileResponse3]
            fileTestRecord = self.addData(fileTestRecord, "ATTACH_FILE_1", FieldType.FILE, fileList1)
            fileTestRecord = self.addData(fileTestRecord, "ATTACH_FILE_2", FieldType.FILE, fileList2)
            fileTestRecord = self.addData(fileTestRecord, "ATTACH_FILE_3", FieldType.FILE, fileList3)
            return (self.recordManagement?.addRecord(self.APP_ID, fileTestRecord))!
        }.then { addResponse -> Promise<GetRecordResponse> in
            // exec get record
            let recId = addResponse.getId()
            return (self.recordManagement?.getRecord(self.APP_ID, recId!))!
        }.then{ getResponse in
            // result check
            let fileResult1: [FileModel] = getResponse.getRecord()!["ATTACH_FILE_1"]!.getValue() as! [FileModel]
            let fileResult2: [FileModel] = getResponse.getRecord()!["ATTACH_FILE_2"]!.getValue() as! [FileModel]
            let fileResult3: [FileModel] = getResponse.getRecord()!["ATTACH_FILE_3"]!.getValue() as! [FileModel]
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
        XCTAssert(waitForPromises(timeout: 5))
    }
    
    func testUploadSuccessForMultiFileToMultiField() throws {
        // create test data for file upload
        var fileTestRecord: Dictionary<String, FieldValue> = [:]
        fileTestRecord = addData(fileTestRecord, "SINGLE_LINE_TEXT", FieldType.SINGLE_LINE_TEXT, "testUploadSuccessForMultiFileToMultiField")
        
        // exec upload and result check
        let testBundle = Bundle(for: type(of: self))
        guard let upload_file_path1_1 = testBundle.url(forResource: "test", withExtension: "txt") else {
            return XCTFail()
        }
        guard let upload_file_path1_2 = testBundle.url(forResource: "test", withExtension: "pptx")else {
           return XCTFail()
        }
        guard let upload_file_path1_3 = testBundle.url(forResource: "test", withExtension: "xlsx")else {
            return XCTFail()
        }
        guard let upload_file_path2_1 = testBundle.url(forResource: "test", withExtension: "txt")else {
            return XCTFail()
        }
        guard let upload_file_path2_2 = testBundle.url(forResource: "test", withExtension: "pptx")else {
           return XCTFail()
        }
        guard let upload_file_path2_3 = testBundle.url(forResource: "test", withExtension: "xlsx")else {
           return XCTFail()
        }
        guard let upload_file_path3_1 = testBundle.url(forResource: "test", withExtension: "txt")else {
            return XCTFail()
        }
        guard let upload_file_path3_2 = testBundle.url(forResource: "test", withExtension: "pptx")else {
           return XCTFail()
        }
        guard let upload_file_path3_3 = testBundle.url(forResource: "test", withExtension: "xlsx")else {
            return XCTFail()
        }
        all(
            (self.fileManagement?.upload(upload_file_path1_1.absoluteString))!,
            (self.fileManagement?.upload(upload_file_path1_2.absoluteString))!,
            (self.fileManagement?.upload(upload_file_path1_3.absoluteString))!,
            (self.fileManagement?.upload(upload_file_path2_1.absoluteString))!,
            (self.fileManagement?.upload(upload_file_path2_2.absoluteString))!,
            (self.fileManagement?.upload(upload_file_path2_3.absoluteString))!,
            (self.fileManagement?.upload(upload_file_path3_1.absoluteString))!,
            (self.fileManagement?.upload(upload_file_path3_2.absoluteString))!,
            (self.fileManagement?.upload(upload_file_path3_3.absoluteString))!
         ).then { fileResponses -> Promise<AddRecordResponse> in
            // exec add record
            let fileList1 = [fileResponses[0], fileResponses[1], fileResponses[2]]
            let fileList2 = [fileResponses[3], fileResponses[4], fileResponses[5]]
            let fileList3 = [fileResponses[6], fileResponses[7], fileResponses[8]]
            fileTestRecord = self.addData(fileTestRecord, "ATTACH_FILE_1", FieldType.FILE, fileList1)
            fileTestRecord = self.addData(fileTestRecord, "ATTACH_FILE_2", FieldType.FILE, fileList2)
            fileTestRecord = self.addData(fileTestRecord, "ATTACH_FILE_3", FieldType.FILE, fileList3)
            return (self.recordManagement?.addRecord(self.APP_ID, fileTestRecord))!
        }.then { addResponse -> Promise<GetRecordResponse> in
            let recId = addResponse.getId()
            return (self.recordManagement?.getRecord(self.APP_ID, recId!))!
        }.then { getResponse in
            // result check
            let fileResults1: [FileModel] = getResponse.getRecord()!["ATTACH_FILE_1"]!.getValue() as! [FileModel]
            let fileResults2: [FileModel] = getResponse.getRecord()!["ATTACH_FILE_2"]!.getValue() as! [FileModel]
            let fileResults3: [FileModel] = getResponse.getRecord()!["ATTACH_FILE_3"]!.getValue() as! [FileModel]
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
        XCTAssert(waitForPromises(timeout: 50))
    }
    
    func testUploadFailForUnexistFileKey() throws {
        self.fileManagement?.upload("xxxxxxxxxxxxxxxxxxxxxxxxx").catch{ error in
            XCTAssertNotNil(error)
        }
    }
    
    func testDownloadSuccessForSingleFile() throws {
        // create test data for file download
        var fileTestRecord: Dictionary<String, FieldValue> = [:]
        fileTestRecord = addData(fileTestRecord, "SINGLE_LINE_TEXT", FieldType.SINGLE_LINE_TEXT, "testDownloadSuccessForSingleFile")
        
        // exec upload and result check
        let testBundle = Bundle(for: type(of: self))
        guard let upload_file_path = testBundle.url(forResource: "test", withExtension: "txt") else {
            return XCTFail()
        }
        self.fileManagement?.upload(upload_file_path.absoluteString).then{ fileResponse -> Promise<AddRecordResponse> in
            // exec add record
            let fileList = [fileResponse]
            fileTestRecord = self.addData(fileTestRecord, "ATTACH_FILE_1", FieldType.FILE, fileList)
            return (self.recordManagement?.addRecord(self.APP_ID, fileTestRecord))!
        }.then { addResponse -> Promise<GetRecordResponse> in
            let recId = addResponse.getId()
            return (self.recordManagement?.getRecord(self.APP_ID, recId!))!
        }.then { getResponse in
            // exec download file and result check
            let fileResult: [FileModel] = getResponse.getRecord()!["ATTACH_FILE_1"]!.getValue() as! [FileModel]
            if let dowloadDir = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first {
                let pathFileName = dowloadDir.absoluteString + fileResult[0].getName()!
                self.fileManagement?.download((fileResult[0].getFileKey()!), pathFileName).then { _ in
                    XCTAssertTrue(true)
                }.catch{ error in
                    XCTFail()
                }
            }
        }
        XCTAssert(waitForPromises(timeout: 60))
    }
    
    func testDownloadSuccessForMultiFile() throws {
        // create test data for file upload
        var fileTestRecord: Dictionary<String, FieldValue> = [:]
        fileTestRecord = addData(fileTestRecord, "SINGLE_LINE_TEXT", FieldType.SINGLE_LINE_TEXT, "testDownloadSuccessForMultiFile")
        // exec upload and result check
        let testBundle = Bundle(for: type(of: self))
        // exec upload and result check
        guard let upload_file_path1 = testBundle.url(forResource: "test", withExtension: "txt") else {
            return XCTFail()
        }
        guard let upload_file_path2 = testBundle.url(forResource: "test", withExtension: "pptx")else {
            return XCTFail()
        }
        guard let upload_file_path3 = testBundle.url(forResource: "test", withExtension: "xlsx")else {
            return XCTFail()
        }
        
        all(
            (self.fileManagement?.upload(upload_file_path1.absoluteString))!,
            (self.fileManagement?.upload(upload_file_path2.absoluteString))!,
            (self.fileManagement?.upload(upload_file_path3.absoluteString))!
        ).then { fileResponse1, fileResponse2, fileResponse3 -> Promise<AddRecordResponse> in
            let fileList = [fileResponse1, fileResponse2, fileResponse3]
            fileTestRecord = self.addData(fileTestRecord, "ATTACH_FILE_1", FieldType.FILE, fileList)
            return (self.recordManagement?.addRecord(self.APP_ID, fileTestRecord))!
        }.then { addResponse -> Promise<GetRecordResponse> in
            let recId = addResponse.getId()
            return (self.recordManagement?.getRecord(self.APP_ID, recId!))!
        }.then { getResponse in
            // exec download file and result check
            let fileResults: [FileModel] = getResponse.getRecord()!["ATTACH_FILE_1"]!.getValue() as! [FileModel]
            for fileResult in fileResults {
                if let dowloadDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    let pathFileName = dowloadDir.absoluteString + fileResult.getName()!
                    try self.fileManagement?.download(fileResult.getFileKey()!, pathFileName)
                    self.fileManagement?.download(fileResult.getFileKey()!, pathFileName).then { _ in
                        XCTAssertTrue(true)
                    }.catch{ error in
                        XCTFail()
                    }
                }
            }
        
        }
        XCTAssert(waitForPromises(timeout: 60))
    }
    
    func testDownloadSuccessForSingleFileToMultiField() throws {
        // create test data for file upload
        var fileTestRecord: Dictionary<String, FieldValue> = [:]
        fileTestRecord = addData(fileTestRecord, "SINGLE_LINE_TEXT", FieldType.SINGLE_LINE_TEXT, "testDownloadSuccessForSingleFileToMultiField")
        
        let testBundle = Bundle(for: type(of: self))
        // exec upload and result check
        guard let upload_file_path1 = testBundle.url(forResource: "test", withExtension: "txt") else {
            return XCTFail()
        }
        guard let upload_file_path2 = testBundle.url(forResource: "test", withExtension: "pptx")else {
            return XCTFail()
        }
        guard let upload_file_path3 = testBundle.url(forResource: "test", withExtension: "xlsx")else {
            return XCTFail()
        }
        
        all(
            (self.fileManagement?.upload(upload_file_path1.absoluteString))!,
            (self.fileManagement?.upload(upload_file_path2.absoluteString))!,
            (self.fileManagement?.upload(upload_file_path3.absoluteString))!
        ).then { fileResponse1, fileResponse2, fileResponse3 -> Promise<AddRecordResponse> in
            // exec add record
            let fileList1 = [fileResponse1]
            let fileList2 = [fileResponse2]
            let fileList3 = [fileResponse3]
            fileTestRecord = self.addData(fileTestRecord, "ATTACH_FILE_1", FieldType.FILE, fileList1)
            fileTestRecord = self.addData(fileTestRecord, "ATTACH_FILE_2", FieldType.FILE, fileList2)
            fileTestRecord = self.addData(fileTestRecord, "ATTACH_FILE_3", FieldType.FILE, fileList3)
            return (self.recordManagement?.addRecord(self.APP_ID, fileTestRecord))!
        }.then { addResponse -> Promise<GetRecordResponse> in
            let recId = addResponse.getId()
            return (self.recordManagement?.getRecord(self.APP_ID, recId!))!
        }.then { getResponse in
            // exec download file and result check
            let fileResult1: [FileModel] = getResponse.getRecord()!["ATTACH_FILE_1"]!.getValue() as! [FileModel]
            let fileResult2: [FileModel] = getResponse.getRecord()!["ATTACH_FILE_2"]!.getValue() as! [FileModel]
            let fileResult3: [FileModel] = getResponse.getRecord()!["ATTACH_FILE_3"]!.getValue() as! [FileModel]
            if let dowloadDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let pathFileName1 = dowloadDir.absoluteString + fileResult1[0].getName()!
                let pathFileName2 = dowloadDir.absoluteString + fileResult2[0].getName()!
                let pathFileName3 = dowloadDir.absoluteString + fileResult3[0].getName()!
                self.fileManagement?.download(fileResult1[0].getFileKey()!, pathFileName1)
                    .then { _ -> Promise<Void> in
                        XCTAssertTrue(true)
                        return (self.fileManagement?.download(fileResult2[0].getFileKey()!, pathFileName2))!
                    }.then { _ -> Promise<Void> in
                        XCTAssertTrue(true)
                        return (self.fileManagement?.download(fileResult3[0].getFileKey()!, pathFileName3))!
                    }.then { resp in
                        XCTAssertTrue(true)
                    }.catch { error in
                        XCTFail()
                    }
            }
        }
        XCTAssert(waitForPromises(timeout: 500))
    }
    
    func testDownloadSuccessForMultiFileToMultiField() throws {
        // create test data for file upload
        var fileTestRecord: Dictionary<String, FieldValue> = [:]
        fileTestRecord = addData(fileTestRecord, "SINGLE_LINE_TEXT", FieldType.SINGLE_LINE_TEXT, "testDownloadSuccessForMultiFileToMultiField")
        
        // exec upload and result check
        let testBundle = Bundle(for: type(of: self))
        guard let upload_file_path1_1 = testBundle.url(forResource: "test", withExtension: "txt") else {
           return XCTFail()
        }
        guard let upload_file_path1_2 = testBundle.url(forResource: "test", withExtension: "pptx")else {
            return XCTFail()
        }
        guard let upload_file_path1_3 = testBundle.url(forResource: "test", withExtension: "xlsx")else {
           return XCTFail()
        }
        guard let upload_file_path2_1 = testBundle.url(forResource: "test", withExtension: "txt")else {
            return XCTFail()
        }
        guard let upload_file_path2_2 = testBundle.url(forResource: "test", withExtension: "pptx")else {
            return XCTFail()
        }
        guard let upload_file_path2_3 = testBundle.url(forResource: "test", withExtension: "xlsx")else {
            return XCTFail()
        }
        guard let upload_file_path3_1 = testBundle.url(forResource: "test", withExtension: "txt")else {
            return XCTFail()
        }
        guard let upload_file_path3_2 = testBundle.url(forResource: "test", withExtension: "pptx")else {
            return XCTFail()
        }
        guard let upload_file_path3_3 = testBundle.url(forResource: "test", withExtension: "xlsx")else {
            return XCTFail()
        }
        all(
            (self.fileManagement?.upload(upload_file_path1_1.absoluteString))!,
            (self.fileManagement?.upload(upload_file_path1_2.absoluteString))!,
            (self.fileManagement?.upload(upload_file_path1_3.absoluteString))!,
            (self.fileManagement?.upload(upload_file_path2_1.absoluteString))!,
            (self.fileManagement?.upload(upload_file_path2_2.absoluteString))!,
            (self.fileManagement?.upload(upload_file_path2_3.absoluteString))!,
            (self.fileManagement?.upload(upload_file_path3_1.absoluteString))!,
            (self.fileManagement?.upload(upload_file_path3_2.absoluteString))!,
            (self.fileManagement?.upload(upload_file_path3_3.absoluteString))!
            ).then { fileResponses -> Promise<AddRecordResponse> in
                // exec add record
                let fileList1 = [fileResponses[0], fileResponses[1], fileResponses[2]]
                let fileList2 = [fileResponses[3], fileResponses[4], fileResponses[5]]
                let fileList3 = [fileResponses[6], fileResponses[7], fileResponses[8]]
                fileTestRecord = self.addData(fileTestRecord, "ATTACH_FILE_1", FieldType.FILE, fileList1)
                fileTestRecord = self.addData(fileTestRecord, "ATTACH_FILE_2", FieldType.FILE, fileList2)
                fileTestRecord = self.addData(fileTestRecord, "ATTACH_FILE_3", FieldType.FILE, fileList3)
                return (self.recordManagement?.addRecord(self.APP_ID, fileTestRecord))!
            }.then { addResponse -> Promise<GetRecordResponse> in
                let recId = addResponse.getId()
                return (self.recordManagement?.getRecord(self.APP_ID, recId!))!
            }.then { getResponse in
                // exec file download and result check
                let fileResults1: [FileModel] = getResponse.getRecord()!["ATTACH_FILE_1"]!.getValue() as! [FileModel]
                let fileResults2: [FileModel] = getResponse.getRecord()!["ATTACH_FILE_2"]!.getValue() as! [FileModel]
                let fileResults3: [FileModel] = getResponse.getRecord()!["ATTACH_FILE_3"]!.getValue() as! [FileModel]
                
                if let dowloadDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    var fileResultsPromiseArray: [Promise<Void>] = [Promise<Void>]()
                        let fileResultsPromise1 = fileResults1.map { (fileResult1) -> Promise<Void> in
                            let pathFileName = dowloadDir.absoluteString + fileResult1.getName()!
                            return (self.fileManagement?.download(fileResult1.getFileKey()!, pathFileName))!
                        }
                        fileResultsPromiseArray.append(contentsOf: fileResultsPromise1)
                    let fileResultsPromise2 = fileResults2.map { (fileResult2) -> Promise<Void> in
                        let pathFileName = dowloadDir.absoluteString + fileResult2.getName()!
                        return (self.fileManagement?.download(fileResult2.getFileKey()!, pathFileName))!
                    }
                    fileResultsPromiseArray.append(contentsOf: fileResultsPromise2)
                    let fileResultsPromise3 = fileResults3.map { (fileResult3) -> Promise<Void> in
                        let pathFileName = dowloadDir.absoluteString + fileResult3.getName()!
                        return (self.fileManagement?.download(fileResult3.getFileKey()!, pathFileName))!
                    }
                    fileResultsPromiseArray.append(contentsOf: fileResultsPromise3)
                    all(
                        fileResultsPromiseArray
                    ).then{ _ in
                        XCTAssertTrue(true)
                    }.catch{error in
                        print(error)
                            
                    }
                }
        }
        XCTAssert(waitForPromises(timeout: 500))
    }
    
    func testDownloadFailForUnexistFileKey() throws {
        if let dowloadDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            self.fileManagement?.download("12345678890", dowloadDir.absoluteString + "test.xtx").catch{ error in
                XCTAssertNotNil(error)
            }
        }
        XCTAssert(waitForPromises(timeout: 5))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

