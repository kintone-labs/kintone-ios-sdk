# Record

Provide manipulate functions on records: get, update, delete, update the record status & assignees in the kintone app

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

    let username = {your_user_name}
    let password = {your_user_password}
    let domain = {your_domain}
    
    // Init authenticationAuth
    let auth = Auth()
    auth.setPasswordAuth(username, password)
            
    // Init Connection without "guest space ID"
    let connection = Connection(domain, auth)
            
    // Init Record Module
    let recordManagement = Record(connection)

</pre>

</details>

## Methods

### getRecord

Retrieves details of 1 record from an app.

**Declaration**

```
func getRecord(_ app: Int,_ id: Int) -> Promise<GetRecordResponse>
```

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app | Integer | yes | The kintone app ID
| id | Integer | yes | The record ID in kintone app


**Return**

Promise<GetRecordResponse\>

**Sample code**

<details class="tab-container" open>
<Summary>Get record</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    // execute get record API
    let appID = {your_app_id}
    let recordID = {your_record_id}
    
    recordManagement.getRecord(appID, recordID).then{response in
                
        let resultData: Dictionary&lt;String, FieldValue&gt; = response.getRecord()!
        print(resultData["$id"]?.getValue())
                
        for (code, value) in resultData {
            print(value.getType()!)
            print(value.getValue())
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

### getRecords

Retrieves details of multiple records from an app using a query string.

**Declaration**

```
func getRecords(_ app: Int, _ query: String?, _ fields: [String]?, _ totalCount: Bool?) -> Promise<GetRecordsResponse>
```

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app | Integer | yes | The kintone app ID
| query | String | (optional) | [The query string](https://developer.kintone.io/hc/en-us/articles/213149287#getrecords) that will specify what records will be responded.
| fields | ArrayList<String\>| (optional) | List of field codes you want in the response.
| totalCount | Boolean | (optional) | If "true", the request will retrieve total count of records match with query conditions.

**Return**

Promise<GetRecordsResponse\>

**Sample code**

<details class="tab-container" open>
<Summary>Get records</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appID = {your_app_id}
    let query = "レコード番号 >= 2 order by レコード番号 asc"
    
    recordManagement.getRecords(appID, query, nil, true).then{response in
        let records = response?.getRecords()
                
        for (i, dval) in (records?.enumerated())! {
            for (code, value) in dval {
                print(value.getType())
                print(value.getValue())
            }
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

### getAllRecordsByCursor

Retrieves details of multiple records from an app using a query string.

**Declaration**

    func getAllRecordsByCursor(_ app: Int, _ query: String? = nil, _ fields: [String]? = nil)  -> Promise<GetRecordsResponse>

**Parameter**

| Name| Description |
| --- | --- |
| app | The kintone app ID
| query | [The query string](https://developer.kintone.io/hc/en-us/articles/213149287#getrecords) that will specify what records will be responded.
| fields | List of field codes you want in the response.

**Return**

Promise<[GetRecordsResponse](../model/record/record-model/#getrecordsresponse)\>

**Sample code**

<details class="tab-container" open>
<Summary>Get all record by cursor</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let username = {your_user_name}
    let password = {your_user_password}
    let domain = {your_domain}
    
    // Init authenticationAuth
    var auth = Auth()
    auth = auth.setPasswordAuth(username, password)
            
    // Init Connection without "guest space ID"
    let connection = Connection(domain, auth)
            
    // Init Record Module
    let recordManagement = Record(connection)
            
    // execute get records API
    let appID = {your_app_id}
    let query = "レコード番号 >= 2 order by レコード番号 asc"
    
    recordManagement.getAllRecordsByCursor(appID, query, nil).then{response in
        let records = response.getRecords()
                
        for (_, dval) in (records?.enumerated())! {
            for (_, value) in dval {
                print(value.getType() as Any)
                print(value.getValue() as Any)
            }
        }
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print(error.localizedDescription)
        }
    }

</pre>

</details>

### getAllRecordsByQuery

Get all records from an app by using a query string.

**Declaration**

```
func getAllRecordsByQuery(_ app: Int,_ query: String? = "",_ fields: [String]? = [],_ totalCount: Bool = false) -> Promise<GetRecordsResponse>
```

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app | Integer | yes | The kintone app ID|
| query | String | (optional) | [The query string](https://developer.kintone.io/hc/en-us/articles/213149287#getrecords) that will specify what records will be responded.
| fields | Array<String\> | (optional) | List of field codes you want in the response.
| totalCount | Boolean | (optional) | If "true", the request will retrieve total count of records match with query conditions.

**Return**

Promise<GetRecordsResponse\>

**Sample code**

<details class="tab-container" open>

<Summary>Get all records by query</Summary>
<strong class="tab-name">Source code</strong>

<pre class="inline-code">
    let appID = {YOUR_APP_ID}
    let query = "{YOUR_QUERY}"
    
    recordManagement.getAllRecordsByQuery(appID, query, nil, true).then {response in
        let records = response.getRecords()
        for (_, dval) in (records?.enumerated())! {
            for (_, value) in dval {
                print(value.getType() as Any)
                print(value.getValue() as Any)
            }
        }
        }.catch{ error in
            if error is KintoneAPIException {
                print((error as! KintoneAPIException).toString()!)
            }
            else {
                print((error).localizedDescription)
            }
        }
</pre>
</details>

### addRecord

>Add one record to an app.

**Declaration**

```
func addRecord(_ app: Int, _ record: [String:FieldValue]?) -> Promise<AddRecordResponse>
```

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app | Integer | yes | The kintone app ID
| record | Dictionary<String, FieldValue\> | (optional) | The record data to be add to kintone app. About the format, please look the sample below or [reference](#reference) at the end of this page

**Return**

Promise<AddRecordResponse\>

**Sample code**

<details class="tab-container" open>
<Summary>Add record</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    var addData: Dictionary&lt;String, FieldValue&gt; = [:]
    var field = FieldValue()
    field.setType(FieldType.SINGLE_LINE_TEXT)
    field.setValue("Test Value")
    addData[{your_field_code}] = field
            
    // execute add record API
    let appID = {your_app_id}
    recordManagement.addRecord(appID, addData).then{response in
        print(response.getId())
        print(response.getRevision())
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

### addRecords

Add multiple records to an app.

**Declaration**

```
func addRecords(_ app: Int, _ records: [[String:FieldValue]]) -> Promise<AddRecordsResponse>
```

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app | Integer | yes | The kintone app ID
| records | ArrayList<Dictionary<String, FieldValue\>\> | yes | List of records data to be add to kintone app. About the format, please look the sample below or [reference](#reference) at the end of this page.

**Return**

Promise<AddRecordsResponse\>

**Sample code**

<details class="tab-container" open>
<Summary>Add multi records</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    var addData1: Dictionary&lt;String, FieldValue&gt; = [:]
    var addData2: Dictionary&lt;String, FieldValue&gt; = [:]
    var field1 = FieldValue()
    var field2 = FieldValue()
    field1.setType(FieldType.SINGLE_LINE_TEXT)
    field1.setValue("Test Value1")
    field2.setType(FieldType.SINGLE_LINE_TEXT)
    field2.setValue("Test Value2")
    addData1[{your_field_code}] = field1
    addData2[{your_field_code}] = field2
    var addDataList = [addData1, addData2]
    
    // execute add records API
    let appID = 311
    recordManagement.addRecords(appID, addDataList).then{response in
        print(response!.getIDs())
        print(response!.getRevisions())   
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

### updateRecordByID

Updates details of 1 record in an app by specifying its record number.

**Declaration**

```
func updateRecordByID(_ app: Int, _ id: Int, _ record: [String:FieldValue]?, _ revision: Int?) -> Promise<UpdateRecordResponse>
```

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app | Integer | yes | The kintone app ID
| id | Integer | yes | The record ID on kintone app
| record | Dictionary<String, FieldValue\> | yes | The record data to be updated in the kintone app. About the format, please look the sample below or [reference](#reference) at the end of this page.
| revision | Integer | (optional) | The revision number of record

**Return**

Promise<UpdateRecordResponse\>

**Sample code**

<details class="tab-container" open>
<Summary>Update record by ID</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    var updateData:Dictionary&lt;String, FieldValue&gt; = [:]
    var field = FieldValue()
    field.setType(FieldType.SINGLE_LINE_TEXT)
    field.setValue("Test Value Update")
    updateData[{your_field_code}] = field
            
    // execute update record API
    let appID = {your_app_id}
    let updRecID = {your_record_id}
    recordManagement.updateRecordByID(appID, updRecID, updateData , nil).then{response in
        print(response.getRevision())
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

### updateRecordByUpdateKey

Updates details of 1 record in an app by the unique key.

**Declaration**

```
func updateRecordByUpdateKey(_ app: Int, _ updateKey: RecordUpdateKey, _ record: [String:FieldValue]?, _ revision: Int?) -> Promise<UpdateRecordResponse>
```

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app | Integer | yes | The kintone app ID
| updateKey | RecordUpdateKey | yes | The unique key of the record to be updated. About the format, please look the sample below or [reference](#reference) at the end of this page.
| record | Dictionary<String, FieldValue\>  | yes | The record data will be added to the kintone app. About the format, please look the sample below or [reference](#reference) at the end of this page.
| revision | Integer | (optional) | The revision number of record

**Return**

Promise<UpdateRecordResponse\>

**Sample code**

<details class="tab-container" open>
<Summary>Update record by UpdateKey</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    var updateData: Dictionary&lt;String, FieldValue&gt; = [:]
    var field = FieldValue()
    field.setType(FieldType.SINGLE_LINE_TEXT)
    field.setValue("Test Value Update For Key")
    updateData[{your_field_code}] = field
            
    // create update key
    let updKey = RecordUpdateKey("{your_field_code}", "update key value")
            
    // execute update record API
    let appID = {your_app_id}
    recordManagement.updateRecordByUpdateKey(appID, updKey, updateData, nil).then{response in
        print(response.getRevision())
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

### updateRecords

Updates details of multiple records in an app, by specifying their record number, or a different unique key.

**Declaration**

```
func updateRecords(_ app: Int, _ records: [RecordUpdateItem]) -> Promise<UpdateRecordsResponse>
```

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app | Integer | yes | The kintone app ID
| records | ArrayList<RecordUpdateItem\> | yes | The record data will be added to kintone app. About the format, please look the sample below or [reference](#reference) at the end of this page.

**Return**

Promise<UpdateRecordsResponse\>

**Sample code**

<details class="tab-container" open>
<Summary>Update multi records</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    var recId1 = {your_record_id}
    var recId2 = {your_record_id}
    var updateData1: Dictionary&lt;String, FieldValue&gt; = [:]
    var updateData2: Dictionary&lt;String, FieldValue&gt; = [:]
    var field1 = FieldValue()
    var field2 = FieldValue()
    field1.setType(FieldType.SINGLE_LINE_TEXT)
    field1.setValue("Test Update Value1 ")
    field2.setType(FieldType.SINGLE_LINE_TEXT)
    field2.setValue("Test Update Value2")
    updateData1[{your_field_code}] = field1
    updateData2[{your_field_code}] = field2
    var updateDataItem1 = RecordUpdateItem(recId1, nil, nil, updateData1)
    var updateDataItem2 = RecordUpdateItem(recId2, nil, nil, updateData2)
    let updateItemList = [updateDataItem1 , updateDataItem2]
            
    // execute update records API
    let appID = {your_app_id}
    recordManagement.updateRecords(appID, updateItemList).then{response in
        for value in (response!.getRecords())! {
            print(value.getID())
            print(value.getRevision())
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


### updateAllRecords

Updates details of all records in an app.

**Declaration**

    func updateAllRecords (_ app: Int, _ records: [RecordUpdateItem]) -> Promise<BulkRequestResponse>

**Parameter**

| Name| Description |
| --- | --- |
| app | The kintone app ID
| records | The record data will be added to kintone app. About the format, please look the sample below or [reference](#reference) at the end of this page.

**Return**

Promise<BulkRequestResponse\>

**Sample code**

<details class="tab-container" open>
<Summary>Update multi records</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let recId1 = {your_record_id}
    let recId2 = {your_record_id}
    var updateData1: Dictionary&lt;String, FieldValue&gt; = [:]
    var updateData2: Dictionary&lt;String, FieldValue&gt; = [:]
    let field1 = FieldValue()
    let field2 = FieldValue()
    field1.setType(FieldType.SINGLE_LINE_TEXT)
    field1.setValue("Test Update Value1 ")
    field2.setType(FieldType.SINGLE_LINE_TEXT)
    field2.setValue("Test Update Value2")
    updateData1[{your_field_code}] = field1
    updateData2[{your_field_code}] = field2
    let updateDataItem1 = RecordUpdateItem(recId1, nil, nil, updateData1)
    let updateDataItem2 = RecordUpdateItem(recId2, nil, nil, updateData2)
    let updateItemList = [updateDataItem1 , updateDataItem2]
            
    // execute update records API
    let appID = {your_app_id}
    recordManagement.updateAllRecords(appID, updateItemList).then{response in
        for result in response.getResults()! {
            let updateRecordsResponse = result as! [UpdateRecordsResponse]
            for item in updateRecordsResponse {
                for record in item.getRecords()! {
                    print(record.getID() as Any)
                    print(record.getRevision() as Any)
                }
            }
        }
    }.catch{ error in
        var errorString = ""
        if (type(of: error) == BulksException.self) {
            errorString = (error as! BulksException).getError()!
        } else {
            errorString = error.localizedDescription
        }
        print(errorString)
    }

</pre>

</details>

### deleteRecords(_ app: Int, _ ids: [Int])


Deletes multiple records in an app.

**Declaration**

```
func deleteRecords(_ app: Int, _ ids: [Int]) -> Promise<Void>
```

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app | Integer | yes | The kintone app ID
| ids | ArrayList<Integer\> | yes | The list ids of record will be delete.

**Return**

Promise<Void\>

**Sample code**

<details class="tab-container" open>
<Summary>Delete multi record</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appID = {your_app_id}
    let delRecordID1 = {your_record_id1}
    let delRecordID2 = {your_record_id2}
    let delIdList = [delRecordID1, delRecordID2]
    
    recordManagement.deleteRecords(appID, delIdList)
    .catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }

</pre>

</details>

### deleteRecordsWithRevision

Deletes multiple records in an app with revision.

**Declaration**

```
func deleteRecordsWithRevision(_ app: Int, _ idsWithRevision: [Int:Int?]) -> Promise<Void>
```

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app | Integer | yes | The kintone app ID
| idsWithRevision | Dictionary<Integer, Integer\> | yes |  (**key**: `The Id of record`, **value**: `The Revision of record.`)

**Return**

Promise<Void\>

**Sample code**

<details class="tab-container" open>
<Summary>Delete record with revision</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appID = {your_app_id}
    var delIdAndRevision: Dictionary&lt;Int, Int&gt; = [:]
    delIdAndRevision[{your_record_id}] = {your_revision_id}
    delIdAndRevision[{your_record_id}] = {your_revision_id}
            
    recordManagement.deleteRecordsWithRevision(appID, delIdAndRevision)
    .catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }

</pre>

</details>

### updateRecordAssignees

Update assignees of a record.

**Declaration**

```
func updateRecordAssignees(_ app: Int, _ id: Int, _ assignees: [String], _ revision: Int?) -> Promise<UpdateRecordResponse>
```

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app  | Integer | yes | The kintone app ID
| id  | Integer | yes | The record ID of kintone app
| assignees | ArrayList<String\> | yes | The user code(s) of the assignee(s)
| revision | Integer | (option) | The revision number of record

**Return**

Promise<UpdateRecordResponse\>

**Sample code**

<details class="tab-container" open>
<Summary>update record Assignees</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let username = {your_user_name}
    let password = {your_user_password}
    let domain = {your_domain}
    
    // Init authenticationAuth
    let auth = Auth()
    auth.setPasswordAuth(username, password)
    
    // Init Connection without "guest space ID"
    let connection = Connection(domain, auth)
    
    // Init Record Module
    let recordManagement = Record(connection)
    
    // execute update assignees API
    let appID = {your_app_od}
    let updRecID = {your_record_id}
    let assignees = ["{your_user_code}"]
    recordManagement.updateRecordAssignees(appID, updRecID, assignees, nil).then{response in
        print(response.getRevision())
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

### updateRecordStatus

Updates the Status of a record of an app.

**Declaration**

```
func updateRecordStatus(_ app: Int, _ id: Int, _ action: String, _ assignee: String?, _ revision: Int?) -> Promise<UpdateRecordResponse>
```

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app | Integer | yes | The kintone app ID.
| id | Integer | yes | The record ID on the kintone app.
| action | String | yes | The Action name will be run.
| assignee | String | (Conditionally required) | The next Assignee. Specify the Assignee's login name.</br>Required if the "Assignee List" of the current status is set to "User chooses one assignee from the list to take action", and a selectable assignee exists.
| revision | Integer | (optional) | The revision of record

**Return**

Promise<UpdateRecordResponse\>

**Sample code**

<details class="tab-container" open>
<Summary>Update record status</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appID = {your_app_id}
    let updRecID = {your_record_id}
    let assignees = "{your_user_code}"
    let status = "{your_status}"
    recordManagement.updateRecordStatus(appID, updRecID, status, assignees, nil).then{response in
        print(response.getRevision())
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

### updateRecordsStatus

Updates the Status of multiple records of an app.

**Declaration**

```
func updateRecordsStatus(_ app: Int, _ records: [RecordUpdateStatusItem]) -> Promise<UpdateRecordsResponse>
```

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app | Integer | yes | The kintone app ID
| records | ArrayList<RecordUpdateStatusItem\> | yes | The recod status data. See belowsample codee or [reference](#reference) at the end of this page to know format.

**Return**

Promise<UpdateRecordsResponse\>

**Sample code**

<details class="tab-container" open>
<Summary>Update multi record status</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appID = {your_app_id}
    let updRecID1 = {your_record_id1}
    let updRecID2 = {your_record_id2}
    let assignees1 = [{your_login_code1}]
    let assignees2 = [{your_login_code2}]
    let status1 = {your_update_status1}
    let status2 = {your_update_status2}
    let item1 = RecordUpdateStatusItem(status1, assignees1, updRecID1, nil)
    let item2 = RecordUpdateStatusItem(status2, assignees2, updRecID2, nil)
    let itemList = [item1, item2]
            
    recordManagement.updateRecordsStatus(appID, itemList).then{response in
        for value in (response!.getRecords())! {
            print(value.getID())
            print(value.getRevision())
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

### getComments

**Declaration**

```
func getComments(_ app: Int, _ record: Int, _ order: String?, _ offset: Int?, _ limit: Int?) -> Promise<GetCommentsResponse>
```

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app | Integer | yes | The kintone app ID
| record | Integer | yes | The kintone app ID
| order | String | (optional) | The sort order of the Comment ID. Please select **asc** or **desc**
| offset | Integer | (optional) | The number of first comments will be ignored.
| limit | Integer | (optional) | The number of records to retrieve.

**Return**

Promise<GetCommentsResponse\>

**Sample code**

<details class="tab-container" open>
<Summary>Get comments</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appID = {your_app_id}
    let recordID = {your_record_id}
    var response: GetCommentsResponse? = nil
    
    recordManagement.getComments(appID, recordID, nil, nil, nil).then{response in
        for value in (response.getComments())! {
            print(value.getId())
            print(value.getCreatedAt())
            print(value.getText())
            print(value.getCreator()?.code)
            print(value.getMentions())
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

### addComment

**Declaration**

```
func addComment(_ app: Int, _ record: Int, _ comment: CommentContent) -> Promise<AddCommentResponse>
```

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app | Integer | yes | The kintone app ID |
| record | Integer | yes | The kintone app ID |
| comment | CommentContent | yes | About the format, please look the sample below or [reference](#reference) at the end of this page.|

**Return**

Promise<AddCommentResponse\>

**Sample code**

<details class="tab-container" open>
<Summary>Add comment</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let mention = CommentMention()
    let comment = CommentContent()
    mention.setCode("cybozu")
    mention.setType("USER")
    let mentionList = [mention]
    comment.setText("add comment")
    comment.setMentions(mentionList)
                
    // execute get comments API
    let appID = {your_app_id}
    let recordID = {your_record_id}
    recordManagement.addComment(appID, recordID, comment).then{response in
        print(response.getId())
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

### deleteComment

**Declaration**

```
func deleteComment(_ app: Int, _ record: Int, _ comment: Int) -> Promise<Void>
```

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app | Integer | yes | The kintone app ID
| record | Integer | yes | The record ID on kintone app
| comment | Integer | yes | The comment ID on kintone record

**Return**

Promise<Void\>

**Sample code**

<details class="tab-container" open>
<Summary>Delete comment</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appId = {your_app_id}
    let recordId = {your_record_id}
    let commentId = {your_comment_Id}
    
    recordManagement.deleteComment(appId, recordId, commentId)
    .catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }
    
</pre>

</details>

### upsertRecord

Insert or update a record to kintone app.<br>
Insert the record if the updateKey doesn't exist and update the record if the updateKey exists.

**Declaration**

```
func upsertRecord(_ app: Int, _ updateKey: RecordUpdateKey, _ record: [String:FieldValue], _ revision: Int? = -1) -> Promise<AddRecordResponse> or  Promise<UpdateRecordResponse>
```

**Parameter**

| Name| Description |
| --- | --- |
| app | The kintone app ID
| updateKey | The unique key of the record to be updated. About the format, please look the sample below or [reference](#reference) at the end of this page.
| record | The record data will be added to the kintone app. About the format, please look the sample below or [reference](#reference) at the end of this page.
| revision | The expected revision number. If the value does not match, an error will occur and the record will not be updated. If the value is not specified or is -1, the revision number will not be checked.

**Return**

Promise&lt;AddRecordResponse&gt; or  Promise&lt;UpdateRecordResponse&gt;

**Sample code**

<pre class="inline-code">

    let username = {your_user_name}
    let password = {your_user_password}
    let domain = {your_domain}
    
    // Init authenticationAuth
    var auth = Auth()
    auth = auth.setPasswordAuth(username, password)
            
    // Init Connection without "guest space ID"
    let connection = Connection(domain, auth)
            
    // Init Record Module
    let recordManagement = Record(connection)

    // Init data
    var upsertData: Dictionary&lt;String, FieldValue&gt; = [:]
    let field = FieldValue()
    field.setType(FieldType.SINGLE_LINE_TEXT)
    field.setValue("Test Value Update For Key")
    upsertData[{your_field_code}] = field

    // create update key
    let updKey = RecordUpdateKey("{your_field_code}", "update key value")

    // execute update record API
    let appID = {your_app_id}
    recordManagement.upsertRecord(appID, updKey, upsertData, nil).then{response in
        if let addResponse = response as? AddRecordResponse {
            print(addResponse.getRevision())
        } else if let updateResponse = response as? UpdateRecordResponse {
            print(updateResponse.getRevision())
        }
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        } else {
            print(error.localizedDescription)
        }
    }

</pre>

### upsertRecords

Insert or update up to 1500 records to kintone app.<br>
If the records are over 1500, It is thrown Error.<br>
Insert the records if the updateKey doesn't exist and update the records if the updateKey exists.

**Declaration**

```
func upsertRecords(_ app: Int, _ records: [RecordUpsertItem]) -> Promise<BulkRequestResponse>
```

**Parameter**

| Name| Description |
| --- | --- |
| app | The kintone app ID
| records | The record data Array which has updateKey and record. About the format, please look the sample below or [reference](#reference) at the end of this page.

**Return**

Promise&lt;BulkRequestResponse&gt;

**Sample code**

<pre class="inline-code">

    let username = {your_user_name}
    let password = {your_user_password}
    let domain = {your_domain}
    
    // Init authenticationAuth
    var auth = Auth()
    auth = auth.setPasswordAuth(username, password)
            
    // Init Connection without "guest space ID"
    let connection = Connection(domain, auth)
            
    // Init Record Module
    let recordManagement = Record(connection)

    // create update key
    let updKey1 = RecordUpdateKey("{your_field_code}", "update key value")
    let updKey2 = RecordUpdateKey("{your_field_code}", "update key value")
    let updKey3 = RecordUpdateKey("{your_field_code}", "update key value")

    let field = FieldValue()
    field.setType(FieldType.SINGLE_LINE_TEXT)
    field.setValue("Test Value Update For Key")
    
    var record1: Dictionary&lt;String, FieldValue&gt; = [:]
    var record2: Dictionary&lt;String, FieldValue&gt; = [:]
    var record3: Dictionary&lt;String, FieldValue&gt; = [:]
    record1[{your_field_code}] = field
    record2[{your_field_code}] = field
    record3[{your_field_code}] = field

    let recordUpsertItem1 = RecordUpsertItem(updKey1, record1)
    let recordUpsertItem2 = RecordUpsertItem(updKey2, record2)
    let recordUpsertItem3 = RecordUpsertItem(updKey3, record3)

    var upsertRecords: [RecordUpsertItem] = []
    upsertRecords.append(recordUpsertItem1)
    upsertRecords.append(recordUpsertItem2)
    upsertRecords.append(recordUpsertItem3)
            
    // execute update record API
    let appID = {your_app_id}
    recordManagement.upsertRecords(appID, upsertRecords).then{response in
        print(response)
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print(error.localizedDescription)
        }
    }

</pre>

## Reference

- [Get Record](https://developer.kintone.io/hc/en-us/articles/213149287/) 
- [Add Record](https://developer.kintone.io/hc/en-us/articles/212494628/)
- [Update Record](https://developer.kintone.io/hc/en-us/articles/213149027/)
- [Delete Record](https://developer.kintone.io/hc/en-us/articles/212494558/)
- [Get Comments](https://developer.kintone.io/hc/en-us/articles/219105188)
- [Add Comment](https://developer.kintone.io/hc/en-us/articles/219501367)
- [Delete Comment](https://developer.kintone.io/hc/en-us/articles/219562607)
- [Update Record Status](https://developer.kintone.io/hc/en-us/articles/213149747)
- [Update Record Assignees](https://developer.kintone.io/hc/en-us/articles/219563427)
