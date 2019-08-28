# Record Cursor

Provide functions to work with kintone Cursor

Currently there's only cursor for records.

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

### createCursor(app: Int, fields: [String], query: String, size: Int)

Retrieves details of 1 record from an app.

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app | Integer | yes | The kintone app ID
| fields | Array<String\> | (optional) | Fields of record to return
| query | String | (optional) | Query condition
| size | Integer | (optional) | Number of records to retrieve per request.<br>Default: 100.<br>Maximum: 500.


**Return**

Promise<[CreateRecordCursorResponse](../model/cursor/record-cursor/create-record-cursor-response)\>

**Sample code**

<details class="tab-container" open>
<Summary>Create cursor</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    var appID = YOUR_APP_ID
    var fields = ["YOUR_FIELD_CODE"]
    var query = "YOUR_QUERY"
    var size = 500
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

### getRecords(cursorID: String)

Retrieves records from an app.

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| cursorID | String | yes | The cursor ID

**Return**

Promise<[GetRecordCursorResponse](../model/cursor/record-cursor/get-record-cursor-response)\>

**Sample code**

<details class="tab-container" open>
<Summary>Get records</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    var appID = YOUR_APP_ID
    var fields = ["YOUR_FIELD_CODE"]
    var query = "YOUR_QUERY"
    var size = 500
    
    recordCursor.createCursor(appID, fields, query, size).then{createCursorRespone in
    return (recordCursor.getRecords(createCursorRespone.getId()))!
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

### getAllRecords(cursorID: String)

Retrieves all records from an app.

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| cursorID | String | yes | The cursor ID

**Return**

Promise<[GetRecordsResponse](../model/record/record-model/#getrecordsresponse)\>

**Sample code**

<details class="tab-container" open>
<Summary>Get all records</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    var appID = YOUR_APP_ID
    var fields = ["YOUR_FIELD_CODE"]
    var query = "YOUR_QUERY"
    var size = 500
    
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

### deleteCursor(cursorID: String)

Delete cursor in the app

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| cursorID | String | yes | The cursor ID

**Return**

Promise<Void\>

**Sample code**

<details class="tab-container" open>
<Summary>Delete cursor</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    var appID = YOUR_APP_ID
    var fields = ["YOUR_FIELD_CODE"]
    var query = "YOUR_QUERY"
    var size = 500
    
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