import XCTest
@testable import kintone_ios_sdk
@testable import Promises

class GetAllRecordsByQueryTest: XCTestCase {
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
    
    func testGetAllRecordsSuccess() throws {
        self.recordManagement?.getAllRecordsByQuery(RecordTestConstants.APP_ID)
            .then { resp in
                let records = resp.getRecords()
                print(records!)
            }.catch { error in
                XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
    
    func testGetAllRecordsFail() throws {
        self.recordManagement?.getAllRecordsByQuery(APP_ID_ERROR)
            .then { resp in
                let records = resp.getRecords()
                print(records!)
            }.catch { error in
                XCTFail(self.getErrorMessage(error))
        }
        XCTAssert(waitForPromises(timeout: 10))
    }
}


