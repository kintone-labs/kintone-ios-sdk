import XCTest
@testable import kintone_ios_sdk
@testable import Promises

class DeleteAllRecordsByQueryTest: XCTestCase {
    var kintoneAuth: Auth?
    var connection: Connection?
    var app: App?
    var recordManagement: Record?
    var APP_ID_ERROR: Int = 0
    override func setUp() {
        super.setUp()
        // set auth
        var auth = Auth()
        auth = auth.setPasswordAuth(TestsConstants.ADMIN_USERNAME, TestsConstants.ADMIN_PASSWORD)
        let conn = Connection(TestsConstants.DOMAIN, auth)
        // instance of Record class
        self.recordManagement = Record(conn)
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
    
    func testDeleteAllRecordsSuccess() throws {
        self.recordManagement?.deleteAllRecordsByQuery(RecordTestConstants.APP_ID, "xxx")
            .then { resp in
                let records = resp.getResults()
                print(records!)
                XCTAssertTrue(true)
            }.catch { error in
                XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
    
    func testDeleteAllRecordsFail() throws {
        self.recordManagement?.deleteAllRecordsByQuery(APP_ID_ERROR)
            .then { resp in
                let records = resp.getResults()
                print(records!)
                XCTFail("No errors occurred")
            }.catch { error in
                XCTAssert(type(of: error) == KintoneAPIException.self)
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
}


