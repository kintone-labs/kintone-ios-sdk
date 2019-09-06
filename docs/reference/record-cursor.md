# Record Cursor

Provide functions to work with kintone Cursor

Currently there's only cursor for records.

!!! warning
    The user must set the promises to global to use the module:

            DispatchQueue.promise = .global()

## Constructor

### Declaration

    init(_ connection: Connection?)

**Parameter**

| Name| Description |
| ---| --- |
| connection | [Connection](../connection) | yes | The connection module of this SDK.

**Sample code**

<details class="tab-container" open>
<Summary>Init record module</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let username = 'YOUR_USER_NAME'
    let password = 'YOUR_PASSWORD'
    let domain = 'YOUR_DOMAIN'
    
    // Init authenticationAuth
    let auth = Auth()
    auth.setPasswordAuth(username, password)
            
    // Init Connection without "guest space ID"
    let connection = Connection(domain, auth)
            
    // Init Record Module
    let recordCursor = RecordCursor(connection)

</pre>

</details>

## Methods

### createCursor

Retrieves details of 1 record from an app.

**Declaration**

    func createCursor(_ app: Int, _ fields: [String]? = nil, _ query: String? = nil, _ size: Int? = 100) -> Promise<CreateRecordCursorResponse>

**Parameter**

| Name| Description |
| --- | --- |
| app |The kintone app ID
| fields | Fields of record to return
| query | Query condition
| size | Number of records to retrieve per request.<br>Default: 100.<br>Maximum: 500.


**Return**

Promise<[CreateRecordCursorResponse](../model/cursor/record-cursor/create-record-cursor-response)\>

**Sample code**

<details class="tab-container" open>
<Summary>Create cursor</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appID = YOUR_APP_ID
    let fields = ["YOUR_FIELD_CODE"]
    let query = "YOUR_QUERY"
    let size = 500
    recordCursor.createCursor(appID, fields, query, size).then{ rsp in
        print(rsp.getId())
        print(rsp.getTotalCount())
    }.catch{ error in
        var errorString = ""
        if (type(of: error) == KintoneAPIException.self) {
            errorString = (error as! KintoneAPIException).toString()!
        } else {
            errorString = error.localizedDescription
        }
        print(errorString)
    }

</pre>

</details>

### getRecords

Retrieves records from an app.

**Declaration**

    func getRecords(_ cursorID: String) -> Promise<GetRecordCursorResponse>

**Parameter**

| Name| Description |
| ---| --- |
| cursorID| The cursor ID

**Return**

Promise<[GetRecordCursorResponse](../model/cursor/record-cursor/get-record-cursor-response)\>

**Sample code**

<details class="tab-container" open>
<Summary>Get records</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appID = YOUR_APP_ID
    let fields = ["YOUR_FIELD_CODE"]
    let query = "YOUR_QUERY"
    let size = 500
    
    recordCursor.createCursor(appID, fields, query, size).then{createCursorRespone in
    return (recordCursor.getRecords(createCursorRespone.getId()))
    }.then{ getRecordsRespone in
        let records = getRecordsRespone.getRecords()
        for (_, dval) in (records.enumerated()) {
            for (_, value) in dval {
            print(value.getType() as Any)
            print(value.getValue() as Any)
            }
        }
    }.catch{ error in
    var errorString = ""
    if (type(of: error) == KintoneAPIException.self) {
        errorString = (error as! KintoneAPIException).toString()!
    } else {
        errorString = error.localizedDescription
    }
    print(errorString)
    }

</pre>

</details>

### getAllRecords

Retrieves all records from an app.

**Declaration**

    func getAllRecords(_ cursorID: String)  -> Promise<GetRecordsResponse>

**Parameter**

| Name| Description |
| ---| --- |
| cursorID| The cursor ID

**Return**

Promise<[GetRecordsResponse](../model/record/record-model/#getrecordsresponse)\>

**Sample code**

<details class="tab-container" open>
<Summary>Get all records</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appID = YOUR_APP_ID
    let fields = ["YOUR_FIELD_CODE"]
    let query = "YOUR_QUERY"
    let size = 500
    
    recordCursor.createCursor(appID, fields, query, size).then{createCursorRespone in
    return recordCursor.getAllRecords(createCursorRespone.getId())
    }.then{ getRecordsRespone in
        let records = getRecordsRespone.getRecords()
        for (_, dval) in (records!.enumerated()) {
            for (_, value) in dval {
            print(value.getType() as Any)
            print(value.getValue() as Any)
            }
        }
    }.catch{ error in
    var errorString = ""
    if (type(of: error) == KintoneAPIException.self) {
        errorString = (error as! KintoneAPIException).toString()!
    } else {
        errorString = error.localizedDescription
    }
    print(errorString)
    }

</pre>

</details>

### deleteCursor

Delete cursor in the app

**Declaration**

    func deleteCursor(_ cursorID: String) -> Promise<Void>


**Parameter**

| Name| Description |
| ---| --- |
| cursorID| The cursor ID

**Return**

Promise<Void\>

**Sample code**

<details class="tab-container" open>
<Summary>Delete cursor</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appID = YOUR_APP_ID
    let fields = ["YOUR_FIELD_CODE"]
    let query = "YOUR_QUERY"
    let size = 500
    
    recordCursor.createCursor(appID, fields, query, size).then{createCursorRespone in
        return recordCursor.deleteCursor(createCursorRespone.getId())
    }.then{_ in
        print("Deleted cursor")
    }.catch{ error in
    var errorString = ""
    if (type(of: error) == KintoneAPIException.self) {
        errorString = (error as! KintoneAPIException).toString()!
    } else {
        errorString = error.localizedDescription
    }
    print(errorString)
    }

</pre>

</details>

## Reference

- [Add Cursor](https://developer.kintone.io/hc/en-us/articles/360000280322) 
- [Get Cursor](https://developer.kintone.io/hc/en-us/articles/360000280502)
- [Delete Cursor](https://developer.kintone.io/hc/en-us/articles/360000280522)