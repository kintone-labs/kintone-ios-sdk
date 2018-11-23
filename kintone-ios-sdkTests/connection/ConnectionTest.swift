//
//  ConnectionTest.swift
//  kintone-ios-sdkTests
//
//  Created by h001218 on 2018/10/01.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

import XCTest
@testable import kintone_ios_sdk
@testable import Promises

class ConnectionTest: XCTestCase {
    
    private let USERNAME = "xxxxx"
    private let PASSWORD = "xxxxx"
    private let PROXY_HOST = "10.224.136.41"
    private let PROXY_PORT = 3128
    private let GUEST_SPACE_ID = 23
    private let APP_ID = 23
    private let GUEST_SPACE_APP_ID = 32
    
    private let VIEW_API_TOKEN = "xxxxxxxxxxxxxxxxxx"
    private let POST_API_TOKEN = "xxxxxxxxxxxxxxxxxx"
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
        auth = auth.setPasswordAuth(ConnectionTestConstants.AUTH_USERNAME, ConnectionTestConstants.AUTH_PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(ConnectionTestConstants.APP_ID)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!).then { jsonobject in
                XCTAssertNotEqual(jsonobject, Data.init())
            }
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
    
    func testGetRequestShouldFailWhenGivenWrongDomain() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(ConnectionTestConstants.AUTH_USERNAME, ConnectionTestConstants.AUTH_PASSWORD)
        let connection: Connection = Connection("https://error.kintone.com", auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(ConnectionTestConstants.APP_ID)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!)
                .then{jsonObject in
                    XCTFail()
                }
                .catch{ error in
                XCTAssertTrue(true)
            }
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
    
    func testGetRequestShouldFailWhenGivenWrongUsername() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth("WrongUsername", ConnectionTestConstants.AUTH_PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(ConnectionTestConstants.APP_ID)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!)
                .then{jsonObject in
                    XCTFail()
                }
                .catch{ error in
                    XCTAssertTrue(true)
            }
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
    
    func testGetRequestShouldFailWhenGivenWrongPassword() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(ConnectionTestConstants.AUTH_USERNAME, "WrongPassword")
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(ConnectionTestConstants.APP_ID)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!)
                .then{jsonObject in
                    XCTFail()
                }
                .catch{ error in
                    XCTAssertTrue(true)
            }
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
    
    func testGetRequestWithPasswordAuthenticationShouldSuccess() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(ConnectionTestConstants.AUTH_USERNAME, ConnectionTestConstants.AUTH_PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(ConnectionTestConstants.APP_ID)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!).then { jsonobject in
                XCTAssertNotEqual(jsonobject, Data.init())
            }
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
    
    func testGetRequestWithTokenAuthenticationShouldSuccess() throws {
        var auth: Auth = Auth.init()
        auth = auth.setApiToken(ConnectionTestConstants.VIEW_API_TOKEN)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(ConnectionTestConstants.APP_ID)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!).then { jsonobject in
                XCTAssertNotEqual(jsonobject, Data.init())
            }
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
    
    func testGetRequestWithTokenAuthenticationShouldFail() throws {
        var auth: Auth = Auth.init()
        auth = auth.setApiToken("UZVlLDkvO20252Lbzx1qbzI9V4dtiAMuMNBxnuDU")
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(ConnectionTestConstants.APP_ID)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!)
                .then{jsonObject in
                    XCTFail()
                }
                .catch{ error in
                    XCTAssertTrue(true)
            }
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
    
    func testGetRequestWithPassAuthenticationShouldSuccessWhenTokenAuthenticationNotAllow() throws {
        var auth: Auth = Auth.init()
        auth = auth.setApiToken(ConnectionTestConstants.POST_API_TOKEN)
        auth = auth.setPasswordAuth(ConnectionTestConstants.AUTH_USERNAME, ConnectionTestConstants.AUTH_PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(ConnectionTestConstants.APP_ID)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!).then { jsonobject in
                XCTAssertNotEqual(jsonobject, Data.init())
            }
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
    
    func testInvalidPassAuthenticationShouldFailWhenTokenAuthenticationAllow() throws {
        var auth: Auth = Auth.init()
        auth = auth.setApiToken("11ZkR2UsPjONME2eQL7durBe48TURXR5eVWl1ecg")
        auth = auth.setPasswordAuth("WrongUsername", ConnectionTestConstants.AUTH_PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(ConnectionTestConstants.APP_ID)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!).then { jsonobject in
                XCTAssertNotEqual(jsonobject, Data.init())
            }
        }
        XCTAssert(waitForPromises(timeout: 10))
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
            connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!).then { jsonobject in
                XCTAssertNotEqual(jsonobject, Data.init())
            }
        }
        XCTAssert(waitForPromises(timeout: 10))
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
            connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!)
                .then{jsonObject in
                    XCTFail()
                }
                .catch{ error in
                    XCTAssertTrue(true)
            }
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
    
    func testGetRequestWithPasswordAuthenticationShouldSuccessWhenGivenBasicAuthentication() throws {
        var auth: Auth = Auth.init()
        auth = auth.setBasicAuth("cybozu", "cybozu")
        auth = auth.setPasswordAuth(ConnectionTestConstants.AUTH_USERNAME, ConnectionTestConstants.AUTH_PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(ConnectionTestConstants.APP_ID)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!).then { jsonobject in
                XCTAssertNotEqual(jsonobject, Data.init())
            }
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
    
    func testPostRequestShouldSuccess() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(ConnectionTestConstants.AUTH_USERNAME, ConnectionTestConstants.AUTH_PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            var record: [String:FieldValue] = [:]
            let fv = FieldValue()
            fv.setType(FieldType.SINGLE_LINE_TEXT)
            fv.setValue("text")
            record["text"] = fv
            
            let requests: AddRecordRequest = AddRecordRequest(ConnectionTestConstants.APP_ID, record)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            connection.request(ConnectionConstants.POST_REQUEST, ConnectionConstants.RECORD, jsonBody!).then { jsonobject in
                XCTAssertNotEqual(jsonobject, Data.init())
            }
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
    
    func testPostRequestShouldFailWhenGivenWrongBody() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(ConnectionTestConstants.AUTH_USERNAME, ConnectionTestConstants.AUTH_PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            connection.request(ConnectionConstants.POST_REQUEST, ConnectionConstants.RECORD, "")
                .then{jsonObject in
                    XCTFail()
                }
                .catch{ error in
                    XCTAssertTrue(true)
            }
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
    
    func testPutRequestShouldSuccess() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(ConnectionTestConstants.AUTH_USERNAME, ConnectionTestConstants.AUTH_PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            var record: [String:FieldValue] = [:]
            let fv = FieldValue()
            fv.setType(FieldType.SINGLE_LINE_TEXT)
            fv.setValue("test put")
            record["text"] = fv
            
            let requests: UpdateRecordRequest = UpdateRecordRequest(ConnectionTestConstants.APP_ID, 1, nil, nil, record)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            connection.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.RECORD, jsonBody!).then { jsonobject in
                XCTAssertNotEqual(jsonobject, Data.init())
            }
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
    
    func testPutRequestShouldFailWhenGivenWrongBody() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(ConnectionTestConstants.AUTH_USERNAME, ConnectionTestConstants.AUTH_PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            connection.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.RECORD, "")
                .then{jsonObject in
                    XCTFail()
                }
                .catch{ error in
                    XCTAssertTrue(true)
            }
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
    
    func testDeleteRequestShouldFailWhenGivenWrongBody() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(ConnectionTestConstants.AUTH_USERNAME, ConnectionTestConstants.AUTH_PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            connection.request(ConnectionConstants.DELETE_REQUEST, ConnectionConstants.RECORDS, "")
                .then{jsonObject in
                    XCTFail()
                }
                .catch{ error in
                    XCTAssertTrue(true)
            }
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
    
    func testDeleteRequestShouldSuccess() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(ConnectionTestConstants.AUTH_USERNAME, ConnectionTestConstants.AUTH_PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            var record: [String:FieldValue] = [:]
            let fv = FieldValue()
            fv.setType(FieldType.SINGLE_LINE_TEXT)
            fv.setValue("text")
            record["text"] = fv
            
            let requests: AddRecordRequest = AddRecordRequest(ConnectionTestConstants.APP_ID, record)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            connection.request(ConnectionConstants.POST_REQUEST, ConnectionConstants.RECORD, jsonBody!)
                .then { jsonobject -> Promise<Data> in
                    XCTAssertNotEqual(jsonobject, Data.init())
                    
                    let res: AddRecordResponse = try self.parser.parseJson(AddRecordResponse.self, jsonobject)
                    let id = res.getId()
                    let del_request: DeleteRecordsRequest = DeleteRecordsRequest(ConnectionTestConstants.APP_ID, [id!], nil)
                    let del_body = try self.parser.parseObject(del_request)
                    let del_jsonBody = String(data: del_body, encoding: .utf8)
                    return connection.request(ConnectionConstants.DELETE_REQUEST, ConnectionConstants.RECORDS, del_jsonBody!)
                }.then{ del_jsonobject in
                    XCTAssertNotEqual(del_jsonobject, Data.init())
                }
        }
        XCTAssert(waitForPromises(timeout: 50))
    }
    
    func testGetRequestInGuestSpaceShouldSuccessWithPasswordAuthentication() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(ConnectionTestConstants.AUTH_USERNAME ,ConnectionTestConstants.AUTH_PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth, ConnectionTestConstants.GUEST_SPACE_ID)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(ConnectionTestConstants.GUEST_SPACE_APP_ID)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!).then { jsonobject in
                XCTAssertNotEqual(jsonobject, Data.init())
            }.catch{error in
                print(error)
            }
        }
        XCTAssert(waitForPromises(timeout: 50))
    }
    
    func testGetRequestInGuestSpaceShouldFailWhenGivenInvalidSpaceId() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(ConnectionTestConstants.AUTH_USERNAME, ConnectionTestConstants.AUTH_PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth, 1)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            let requests: GetAppRequest = GetAppRequest(ConnectionTestConstants.GUEST_SPACE_APP_ID)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            connection.request(ConnectionConstants.GET_REQUEST, ConnectionConstants.APP, jsonBody!)
                .then{jsonObject in
                    XCTFail()
                }
                .catch{ error in
                    XCTAssertTrue(true)
            }
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
    
    func testPostRequestInGuestSpaceShouldSuccess() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(ConnectionTestConstants.AUTH_USERNAME, ConnectionTestConstants.AUTH_PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth, ConnectionTestConstants.GUEST_SPACE_ID)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            var record: [String:FieldValue] = [:]
            let fv = FieldValue()
            fv.setType(FieldType.SINGLE_LINE_TEXT)
            fv.setValue("text")
            record["text"] = fv
            
            let requests: AddRecordRequest = AddRecordRequest(ConnectionTestConstants.GUEST_SPACE_APP_ID, record)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            connection.request(ConnectionConstants.POST_REQUEST, ConnectionConstants.RECORD, jsonBody!).then { jsonobject in
                XCTAssertNotEqual(jsonobject, Data.init())
            }
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
    
    func testPutRequestInGuestSpaceShouldSuccess() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(ConnectionTestConstants.AUTH_USERNAME, ConnectionTestConstants.AUTH_PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth, ConnectionTestConstants.GUEST_SPACE_ID)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            var record: [String:FieldValue] = [:]
            let fv = FieldValue()
            fv.setType(FieldType.SINGLE_LINE_TEXT)
            fv.setValue("test put")
            record["text"] = fv
            
            let requests: UpdateRecordRequest = UpdateRecordRequest(ConnectionTestConstants.GUEST_SPACE_APP_ID, 1, nil, nil, record)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            connection.request(ConnectionConstants.PUT_REQUEST, ConnectionConstants.RECORD, jsonBody!).then { jsonobject in
                XCTAssertNotEqual(jsonobject, Data.init())
            }
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
    
    func testDeleteRequestInGuestSpaceShouldSuccess() throws {
        var auth: Auth = Auth.init()
        auth = auth.setPasswordAuth(ConnectionTestConstants.AUTH_USERNAME, ConnectionTestConstants.AUTH_PASSWORD)
        let connection: Connection = Connection(TestsConstants.DOMAIN, auth, ConnectionTestConstants.GUEST_SPACE_ID)
        connection.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT)
        
        do {
            var record: [String:FieldValue] = [:]
            let fv = FieldValue()
            fv.setType(FieldType.SINGLE_LINE_TEXT)
            fv.setValue("text")
            record["text"] = fv
            
            let requests: AddRecordRequest = AddRecordRequest(ConnectionTestConstants.GUEST_SPACE_APP_ID, record)
            let body = try parser.parseObject(requests)
            let jsonBody = String(data: body, encoding: .utf8)
            connection.request(ConnectionConstants.POST_REQUEST, ConnectionConstants.RECORD, jsonBody!)
                .then { jsonobject -> Promise<Data> in
                    XCTAssertNotEqual(jsonobject, Data.init())
                    let res: AddRecordResponse = try self.parser.parseJson(AddRecordResponse.self, jsonobject)
                    let id = res.getId()
                    let del_request: DeleteRecordsRequest = DeleteRecordsRequest(ConnectionTestConstants.GUEST_SPACE_APP_ID, [id!], [nil])
                    let del_body = try self.parser.parseObject(del_request)
                    let del_jsonBody = String(data: del_body, encoding: .utf8)
                    return connection.request(ConnectionConstants.DELETE_REQUEST, ConnectionConstants.RECORDS, del_jsonBody!)
                }.then{ del_jsonobject in
                    XCTAssertNotEqual(del_jsonobject, Data.init())
                }
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
}
