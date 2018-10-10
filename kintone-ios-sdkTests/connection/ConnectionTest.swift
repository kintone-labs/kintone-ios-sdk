//
//  ConnectionTest.swift
//  kintone-ios-sdkTests
//
//  Created by h001218 on 2018/10/01.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

import XCTest
@testable import kintone_ios_sdk

class ConnectionTest: XCTestCase {
    
    private let USERNAME = "hiroyuki-sekiyama"
    private let PASSWORD = "2`G`ZadF"
    private let PROXY_HOST = "10.224.136.41"
    private let PROXY_PORT = 3128
    private let GUEST_SPACE_ID = 132
    private let APP_ID = 1685
    private let GUEST_SPACE_APP_ID = 1688
    
    private let VIEW_API_TOKEN = "dme4HafnqbQrBxhoh0UhvWRejIPoAGiWjHiKE6pV"
    private let POST_API_TOKEN = "1VJbqYijhfayTbXhhD1R6R7cSQBlnR8WGZU4YZM8"
    private let parser = RecordParser()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetRequestShouldSuccess() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(self.USERNAME, self.PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(APP_ID)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            let jsonobject = try connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!)
            XCTAssertNotEqual(jsonobject, Data.init())
            
        }
    }
    
    func testGetRequestShouldFailWhenGivenWrongDomain() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(self.USERNAME, self.PASSWORD)
        let connection: Connection = Connection("https://error.kintone.com", auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(APP_ID)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            XCTAssertThrowsError(try connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!))
        }
    }
    
    func testGetRequestShouldFailWhenGivenWrongUsername() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth("WrongUsername", self.PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(APP_ID)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            XCTAssertThrowsError(try connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!))
        }
    }
    
    func testGetRequestShouldFailWhenGivenWrongPassword() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(self.USERNAME, "WrongPassword")
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(APP_ID)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            XCTAssertThrowsError(try connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!))
        }
    }
    
    func testGetRequestWithPasswordAuthenticationShouldSuccess() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(self.USERNAME, self.PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(APP_ID)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            let jsonobject = try connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!)
            XCTAssertNotEqual(jsonobject, Data.init())
        }
    }
    
    func testGetRequestWithTokenAuthenticationShouldSuccess() throws {
        var auth: Auth = Auth.init()
        auth = auth.setApiToken(self.VIEW_API_TOKEN)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(APP_ID)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            let jsonobject = try connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!)
            XCTAssertNotEqual(jsonobject, Data.init())
        }
    }
    
    func testGetRequestWithTokenAuthenticationShouldFail() throws {
        var auth: Auth = Auth.init()
        auth = auth.setApiToken("UZVlLDkvO20252Lbzx1qbzI9V4dtiAMuMNBxnuDU")
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(APP_ID)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            XCTAssertThrowsError(try connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!))
        }
    }
    
    func testGetRequestWithPassAuthenticationShouldSuccessWhenTokenAuthenticationNotAllow() throws {
        var auth: Auth = Auth.init()
        auth = auth.setApiToken(self.POST_API_TOKEN)
        auth = auth.setPasswordAuth(self.USERNAME, self.PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(APP_ID)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            let jsonobject = try connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!)
            XCTAssertNotEqual(jsonobject, Data.init())
        }
    }
    
    func hInvalidPassAuthenticationShouldFailWhenTokenAuthenticationAllow() throws {
        var auth: Auth = Auth.init()
        auth = auth.setApiToken("11ZkR2UsPjONME2eQL7durBe48TURXR5eVWl1ecg")
        auth = auth.setPasswordAuth("WrongUsername", self.PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(APP_ID)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            let jsonobject = try connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!)
            XCTAssertNotEqual(jsonobject, Data.init())
        }
    }
    
    func testGetRequestWithBasicAuthenticationShouldSuccess() throws {
        var auth: Auth = Auth.init()
        auth = auth.setBasicAuth("cybozu", "cybozu")
        auth = auth.setPasswordAuth("basic", "basic")
        let connection: Connection = Connection("https://ios-sdk-test.cybozu.com", auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(5)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            let jsonobject = try connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!)
            XCTAssertNotEqual(jsonobject, Data.init())
        }
    }
    
    func testGetRequestWithPasswordAuthenticationShouldFailWithBasicAuthenticationSite() throws {
        var auth: Auth = Auth.init()
        auth = auth.setBasicAuth("cybozu", "cybozu")
        let connection: Connection = Connection("https://ios-sdk-test.cybozu.com", auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(5)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            XCTAssertThrowsError(try connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!))
        }
    }
    
    func testGetRequestWithPasswordAuthenticationShouldSuccessWhenGivenBasicAuthentication() throws {
        var auth: Auth = Auth.init()
        auth = auth.setBasicAuth("cybozu", "cybozu")
        auth = auth.setPasswordAuth(self.USERNAME, self.PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(APP_ID)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            let jsonobject = try connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!)
            XCTAssertNotEqual(jsonobject, Data.init())
        }
    }
    
    func testPostRequestShouldSuccess() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(self.USERNAME, self.PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            var record: [String:FieldValue] = [:]
            let fv = FieldValue()
            fv.setType(FieldType.SINGLE_LINE_TEXT)
            fv.setValue("text")
            record["text"] = fv
            
            let requests: AddRecordRequest = AddRecordRequest(APP_ID, record)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            let jsonobject = try connection.request(ConnectionConstants.POST_REQUEST, ConnectionConstants.RECORD, jsonBody!)
            XCTAssertNotEqual(jsonobject, Data.init())
        }
    }
    
    func testPostRequestShouldFailWhenGivenWrongBody() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(self.USERNAME, self.PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            XCTAssertThrowsError(try connection.request(ConnectionConstants.POST_REQUEST, ConnectionConstants.RECORD, ""))
        }
    }
    
    func testPutRequestShouldSuccess() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(self.USERNAME, self.PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            var record: [String:FieldValue] = [:]
            let fv = FieldValue()
            fv.setType(FieldType.SINGLE_LINE_TEXT)
            fv.setValue("test put")
            record["text"] = fv
            
            let requests: UpdateRecordRequest = UpdateRecordRequest(APP_ID, 1, nil, nil, record)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            let jsonobject = try connection.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.RECORD, jsonBody!)
            XCTAssertNotEqual(jsonobject, Data.init())
        }
    }
    
    func testPutRequestShouldFailWhenGivenWrongBody() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(self.USERNAME, self.PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            XCTAssertThrowsError(try connection.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.RECORD, ""))
        }
    }
    
    func testDeleteRequestShouldFailWhenGivenWrongBody() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(self.USERNAME, self.PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            XCTAssertThrowsError(try connection.request(ConnectionConstants.DELETE_REQUEST, ConnectionConstants.RECORDS, ""))
        }
    }
    
    func testDeleteRequestShouldSuccess() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(self.USERNAME, self.PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            var record: [String:FieldValue] = [:]
            let fv = FieldValue()
            fv.setType(FieldType.SINGLE_LINE_TEXT)
            fv.setValue("text")
            record["text"] = fv
            
            let requests: AddRecordRequest = AddRecordRequest(APP_ID, record)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            let jsonobject = try connection.request(ConnectionConstants.POST_REQUEST, ConnectionConstants.RECORD, jsonBody!)
            XCTAssertNotEqual(jsonobject, Data.init())
            
            let res: AddRecordResponse = try parser.parseJson(AddRecordResponse.self, jsonobject)
            let id = res.getId()
            let del_request: DeleteRecordsRequest = DeleteRecordsRequest(APP_ID, [id!], [nil])
            let del_body = try parser.parseObject(del_request)
            let del_jsonBody = String(data: del_body, encoding: .utf8)
            let del_jsonobject = try connection.request(ConnectionConstants.DELETE_REQUEST, ConnectionConstants.RECORDS, del_jsonBody!)
            XCTAssertNotEqual(del_jsonobject, Data.init())
        }
    }
    
    func testGetRequestInGuestSpaceShouldSuccessWithPasswordAuthentication() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(self.USERNAME, self.PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth, self.GUEST_SPACE_ID)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(GUEST_SPACE_APP_ID)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            let jsonobject = try connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!)
            XCTAssertNotEqual(jsonobject, Data.init())
        }
    }
    
    func testGetRequestInGuestSpaceShouldFailWhenGivenInvalidSpaceId() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(self.USERNAME, self.PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth, 1)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(GUEST_SPACE_APP_ID)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            XCTAssertThrowsError(try connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!))
        }
    }
    
    func testPostRequestInGuestSpaceShouldSuccess() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(self.USERNAME, self.PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth, self.GUEST_SPACE_ID)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            var record: [String:FieldValue] = [:]
            let fv = FieldValue()
            fv.setType(FieldType.SINGLE_LINE_TEXT)
            fv.setValue("text")
            record["text"] = fv
            
            let requests: AddRecordRequest = AddRecordRequest(GUEST_SPACE_APP_ID, record)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            let jsonobject = try connection.request(ConnectionConstants.POST_REQUEST, ConnectionConstants.RECORD, jsonBody!)
            XCTAssertNotEqual(jsonobject, Data.init())
        }
    }
    
    func testPutRequestInGuestSpaceShouldSuccess() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(self.USERNAME, self.PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth, self.GUEST_SPACE_ID)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            var record: [String:FieldValue] = [:]
            let fv = FieldValue()
            fv.setType(FieldType.SINGLE_LINE_TEXT)
            fv.setValue("test put")
            record["text"] = fv
            
            let requests: UpdateRecordRequest = UpdateRecordRequest(GUEST_SPACE_APP_ID, 1, nil, nil, record)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            let jsonobject = try connection.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.RECORD, jsonBody!)
            XCTAssertNotEqual(jsonobject, Data.init())
        }
    }
    
    func testDeleteRequestInGuestSpaceShouldSuccess() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(self.USERNAME, self.PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth, self.GUEST_SPACE_ID)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            var record: [String:FieldValue] = [:]
            let fv = FieldValue()
            fv.setType(FieldType.SINGLE_LINE_TEXT)
            fv.setValue("text")
            record["text"] = fv
            
            let requests: AddRecordRequest = AddRecordRequest(GUEST_SPACE_APP_ID, record)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            let jsonobject = try connection.request(ConnectionConstants.POST_REQUEST, ConnectionConstants.RECORD, jsonBody!)
            XCTAssertNotEqual(jsonobject, Data.init())
            
            let res: AddRecordResponse = try parser.parseJson(AddRecordResponse.self, jsonobject)
            let id = res.getId()
            let del_request: DeleteRecordsRequest = DeleteRecordsRequest(GUEST_SPACE_APP_ID, [id!], [nil])
            let del_body = try parser.parseObject(del_request)
            let del_jsonBody = String(data: del_body, encoding: .utf8)
            let del_jsonobject = try connection.request(ConnectionConstants.DELETE_REQUEST, ConnectionConstants.RECORDS, del_jsonBody!)
            XCTAssertNotEqual(del_jsonobject, Data.init())
        }
    }
}
