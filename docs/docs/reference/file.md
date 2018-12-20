# File

Provide manipulate functions on file: file download & file upload in the kintone app.

!!! warning
    The user must set the promises to global to use the module:

            DispatchQueue.promise = .global()


## Constructor

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| connection | [Connection](../connection) | yes | The connection module of this SDK.

**Sample code**

<details class="tab-container" open>
<Summary>Initial file class</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    // Init File Module
    let fileManager = File(con)

</pre>

</details>

## Methods

###  upload(_ filePath: String)

Upload file kintone via Rest API

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| filePath | String | yes | The full path of file on your environment

**Return**

Promise<FileModel\>

**Sample code**

<details class="tab-container" open>
<Summary>Get app sample</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let USERNAME = "your_username"
    let PASSWORD = "your_password"
    let DOMAIN = "your_domain"
    
    // Init authenticationAuth
    let auth = Auth()
    auth.setPasswordAuth(USERNAME, PASSWORD)
    let con = Connection(DOMAIN, auth)
    
    // Init File Module
    let fileManager = File(con)
    let recordManager = Record(con)
    
    
    var fileTestRecord: Dictionary<String, FieldValue> = [:]
        var field = FieldValue()
        field.setType(FieldType.SINGLE_LINE_TEXT)
        field.setValue("testUploadSuccessForSingleFile")
        fileTestRecord[fieldCode] = field
    
    var fileName = "test"   
    var fileExtention = "txt"
    // exec upload and result check
    let testBundle = Bundle(for: type(of: self))
    if let upload_file_path = testBundle.url(forResource: fileName, withExtension: fileExtention){
        fileManager.uploadAsync(upload_file_path.absoluteString).then{ fileResponse in
            // exec add record
            let fileList = [fileResponse]
            fileTestRecord = Dictionary<String, FieldValue> = [:]
            field.setType(FieldType.FILE)
            field.setValue(fileList)
            fileTestRecord["ATTACH_FILE_1"] = field
    
            recordManager.addRecord(self.APP_ID, fileTestRecord).then{ addResponse -> Promise<GetRecordResponse> in
                    let recId = addResponse.getId()
                    return (recordManager.getRecord(self.APP_ID, recId!))!
                }.then { getResponse in
                    // result check
                    let fileResult: [FileModel] = getResponse.getRecord()!["ATTACH_FILE_1"]!.getValue() as! [FileModel]
                    print(fileResult.count)
                    print(fileResult[0].getSize())
                    print(fileResult[0].getName())
                    print(fileResult[0].getFileKey())
                    print(fileResult[0].getContentType()!)
            }
        }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }

</pre>

</details>

### download(_ fileKey: String, _ outPutFilePath: String) 

Download file kintone via Rest API

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| fileKey | String | yes | The file key of the uploaded file on kintone
| outPutFilePath | String | yes | The full path of output file on your environment

**Return**

Promise<Void\>

**Sample code**

<details class="tab-container" open>
<Summary>Get apps sample</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let USERNAME = "your_username"
    let PASSWORD = "your_password"
    let DOMAIN = "your_domain"
    
    // Init authenticationAuth
    let auth = Auth()
    auth.setPasswordAuth(USERNAME, PASSWORD)
    let con = Connection(DOMAIN, auth)
    
    // Init File Module
    let fileManager = File(con)
    let recordManager = Record(con)
    var fieldCode = "SINGLE_LINE_TEXT"
    var fileTestRecord: Dictionary<String, FieldValue> = [:]
    var field = FieldValue()
        field.setType(FieldType.SINGLE_LINE_TEXT)
        field.setValue("testDownloadSuccessForSingleFile")
        fileTestRecord[fieldCode] = field
            // exec upload and result check
    let testBundle = Bundle(for: type(of: self))
    guard let upload_file_path = testBundle.url(forResource: "test", withExtension: "txt") else {
        return XCTFail()
    }
    self.fileManagement?.uploadAsync(upload_file_path.absoluteString).then{ fileResponse -> Promise<AddRecordResponse> in
        // exec add record
        let fileList = [fileResponse]
        fileTestRecord = Dictionary<String, FieldValue> = [:]
        field.setType(FieldType.FILE)
        field.setValue(fileList)
        fileTestRecord["ATTACH_FILE_1"] = field
        return (self.recordManagement?.addRecord(self.APP_ID, fileTestRecord))!
    }.then { addResponse -> Promise<GetRecordResponse> in
        let recId = addResponse.getId()
        return (self.recordManagement?.getRecord(self.APP_ID, recId!))!
    }.then { getResponse in
        // exec download file and result check
        let fileResult: [FileModel] = getResponse.getRecord()!["ATTACH_FILE_1"]!.getValue() as! [FileModel]
        if let dowloadDir = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first {
            let pathFileName = dowloadDir.absoluteString + fileResult[0].getName()!
            self.fileManagement?.downloadAsync((fileResult[0].getFileKey()!), pathFileName)
            .catch{ error in
                if error is KintoneAPIException {
                    print((error as! KintoneAPIException).toString()!)
                } else {
                    print((error as! Error).localizedDescription)
                }
            }
        }
    }
    
</pre>

</details>
