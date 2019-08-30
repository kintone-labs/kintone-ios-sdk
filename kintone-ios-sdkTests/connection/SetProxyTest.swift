import XCTest
@testable import kintone_ios_sdk
@testable import Promises

class SetProxyTest: XCTestCase {
    var connection: Connection?
    var APP_ID_ERROR: Int = 0
    override func setUp() {
        super.setUp()
        // set auth
        var auth = Auth()
        auth = auth.setPasswordAuth(TestsConstants.ADMIN_USERNAME, TestsConstants.ADMIN_PASSWORD)
        self.connection = Connection(TestsConstants.DOMAIN, auth)
        // instance of Record class
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func getErrorMessage(_ error: Any) -> String {
        if error is KintoneAPIException {
            return (error as! KintoneAPIException).toString()!
        }
        else {
            return (error as! Error).localizedDescription
        }
    }
    
    func testSetProxySuccess() throws {
        self.connection?.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT, TestsConstants.PROXY_USERNAME, TestsConstants.PROXY_PASSWORD)
        let app = App(self.connection)
        app.getApp(2).then {resp in
            print(resp.getName())
            XCTAssertTrue(true)
            }.catch { error in
                XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 20))
    }
    
    func testSetProxyFail() throws {
        self.connection?.setProxy(TestsConstants.PROXY_HOST, TestsConstants.PROXY_PORT, "WRONG_PROXY_USERNAME", "WRONG_PROXY_PASSWORD")
        let app = App(self.connection)
        app.getApp(2).then {resp in
            XCTFail("Wrong proxy information")
            }.catch { error in
                XCTAssert(type(of: error) == KintoneAPIException.self)
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
}
