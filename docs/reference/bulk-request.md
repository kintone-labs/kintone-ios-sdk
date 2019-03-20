# BulkRequest

The Bulk Request API allows multiple API requests to run on multiple kintone apps. The below API can be used with the Bulk Request API:

- Add Record
- Add Records
- Update Record
- Update Records
- Delete Records
- Update Status
- Update Statuses
- Update Assignees

## Constructor

### **Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| connection | [Connection](../connection) | yes | The connection module of this SDK.

**Sample code**

<details class="tab-container" open>
<Summary>Init bulk request module</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let username = "your_username"
    let password = "your_password"
    let domain = "your_domain"
    
    // Init authenticationAuth
    let auth = Auth()
    auth.setPasswordAuth(username, password)
    
    // Init Connection without "guest space ID"
    let connection = Connection(domain, auth)
    
    // Init Bulk request
    var bulkRequest = BulkRequest(connection);

</pre>

</details>

## Methods

All below methods (excluded `execute()` method) will add the request to the queue, you must execute the `execute()` function to get the result of BulkRequest.

### addRecord(_ app: Int?, _ record: [String:FieldValue]?) 

**Parameter**

See at [Record - addRecord](./record#addrecord_-app-int-_-record-stringfieldvalue)

**Return**

[BulkRequest](#bulkrequest)

**Sample code**

<details class="tab-container" open>
<Summary>add Record</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    var record: [String: FieldValue] = [:]
            
    let fv = FieldValue()
    fv.setType(FieldType.SINGLE_LINE_TEXT)
    fv.setValue("test_AddRecord")
    
    record["Your_Field_Code"] = fv
    bulkRequest = try! bulkRequest?.addRecord(1, record)

</pre>

</details>

### addRecords(_ app: Int?, _ records: [[String:FieldValue]]) 

**Parameter**

See at [Record - addRecords](./record#addrecords_-app-int-_-records-stringfieldvalue)

**Return**

[BulkRequest](#bulkrequest)

**Sample code**

<details class="tab-container" open>
<Summary>add multiple Records</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    // create add data
    var addData1: Dictionary<String, FieldValue> = [:]
    var addData2: Dictionary<String, FieldValue> = [:]
    var field1 = FieldValue()
    var field2 = FieldValue()
    field1.setType(FieldType.SINGLE_LINE_TEXT)
    field1.setValue("Test Value1")
    field2.setType(FieldType.SINGLE_LINE_TEXT)
    field2.setValue("Test Value2")
    addData1[{your_field_code}] = field1
    addData2[{your_field_code}] = field2
    var  = [addData1, addData2]
    
    // create addRecords bulk request
    let appID = 311

    bulkRequest = try! bulkRequest?.addRecords(appID, addDataList);

</pre>

</details>

### updateRecordByID(_ app: Int, _ id: Int, _ record: [String:FieldValue]?, _ revision: Int?)

**Parameter**

See at [Record - updateRecordByID](./record#updaterecordbyid_-app-int-_-id-int-_-record-stringfieldvalue-_-revision-int)

**Return**

[BulkRequest](#bulkrequest)

**Sample code**

<details class="tab-container" open>
<Summary>update Record By ID</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    // create add data
    var updateData:Dictionary<String, FieldValue> = [:]
    var field = FieldValue()
    field.setType(FieldType.SINGLE_LINE_TEXT)
    field.setValue("Test Value Update")
    updateData[{your_field_code}] = field
            
    // create updateRecordByID bulk request
    let appID = {your_app_id}
    let updRecID = {your_record_id}

    bulkRequest = try! bulkRequest?.updateRecordByID(appID, updRecID, updateData, nil);

</pre>

</details>

### updateRecordByUpdateKey(_ app: Int, _ updateKey: RecordUpdateKey, _ record: [String:FieldValue]?, _ revision: Int?)

**Parameter**

See at [Record - updateRecordByUpdateKey](./record#updaterecordbyupdatekey_-app-int-_-updatekey-recordupdatekey-_-record-stringfieldvalue-_-revision-int)

**Return**

[BulkRequest](#bulkrequest)

**Sample code**

<details class="tab-container" open>
<Summary>update Record By UpdateKey</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    // create update data
    var updateData: Dictionary<String, FieldValue> = [:]
    var field = FieldValue()
    field.setType(FieldType.SINGLE_LINE_TEXT)
    field.setValue("Test Value Update For Key")
    updateData[{your_field_code}] = field
            
    // create update key
    let updKey = RecordUpdateKey("{your_field_code}", "update key value")
            
    let appID = {your_app_id}

    // create updateRecordByUpdateKey bulk request
    bulkRequest = try! bulkRequest?.updateRecordByUpdateKey(appID, updKey, updateData, nil);

</pre>

</details>

### updateRecords(_ app: Int?, _ records: [RecordUpdateItem])

**Parameter**

See at [Record - updateRecords](./record#updaterecords_-app-int-_-records-recordupdateitem)

**Return**

[BulkRequest](#bulkrequest)

**Sample code**

<details class="tab-container" open>
<Summary>update multiple Records</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    // create update data
    var recId1 = {your_record_id}
    var recId2 = {your_record_id}
    var updateData1: Dictionary<String, FieldValue> = [:]
    var updateData2: Dictionary<String, FieldValue> = [:]
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
            
    // create updateRecords bulk request
    let appID = {your_app_id}

    bulkRequest = try! bulkRequest?.updateRecords(appID, updateItemList);

</pre>

</details>

### deleteRecords(_ app: Int?, _ ids: [Int])

**Parameter**

See at [Record - deleteRecords](./record#deleterecords_-app-int-_-ids-int)

**Return**

[BulkRequest](#bulkrequest)

**Sample code**

<details class="tab-container" open>
<Summary>Bulk Delete Records</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    // create deleteRecords bulk request
    let appID = {your_app_id}
    let delRecordID1 = {your_record_id1}
    let delRecordID2 = {your_record_id2}
    let delIdList = [delRecordID1, delRecordID2]

    bulkRequest = try! bulkRequest?.deleteRecords(appID, delIdList);

</pre>

</details>

### deleteRecordsWithRevision(_ app: Int?, _ idWithRevision: [Int:Int>])

**Parameter**

See at [Record - deleteRecordsWithRevision](./record#deleterecordswithrevision_-app-int-_-idwithrevision-intint)

**Return**

[BulkRequest](#bulkrequest)

**Sample code**

<details class="tab-container" open>
<Summary>delete Records With Revision</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    // create deleteRecordsWithRevision bulk request
    let appID = {your_app_id}
    var delIdAndRevision: Dictionary<Int, Int> = [:]
    delIdAndRevision[{your_record_id}] = {your_revision_id}
    delIdAndRevision[{your_record_id}] = {your_revision_id}

    bulkRequest = try! bulkRequest?.deleteRecordsWithRevision(appID, delIdAndRevision);
</pre>

</details>

### updateRecordAssignees(_ app: Int, _ id: Int, _ assignees: [String], _ revision: Int?)

**Parameter**

See at [Record - updateRecordAssignees](./record#updaterecordassignees_-app-int-_-id-int-_-assignees-string-_-revision-int)

**Return**

[BulkRequest](#bulkrequest)

**Sample code**

<details class="tab-container" open>
<Summary>Update the Assignees for the record</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    // create updateRecordAssignees bulk request
    let appID = {your_app_od}
    let updRecID = {your_record_id}
    let assignees = ["{your_user_code}"]

    bulkRequest = try! bulkRequest?.updateRecordAssignees(appID, updRecID, assignees, nil);

</pre>

</details>

### updateRecordStatus(_ app: Int, _ id: Int, _ action: String, _ assignee: String?, _ revision: Int?)

**Parameter**

See at [Record - updateRecordStatus](./record#updaterecordstatus_-app-int-_-id-int-_-action-string-_-assignee-string-_-revision-int)

**Return**

[BulkRequest](#bulkrequest)

**Sample code**

<details class="tab-container" open>
<Summary>Update the status of a single record</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    // create updateRecordStatus bulk request
    let appID = {your_app_id}
    let updRecID = {your_record_id}
    let assignees = "{your_user_code}"
    let status = "{your_status}"
    bulkRequest = try! bulkRequest?.updateRecordStatus(appID, updRecID, status, assignees, nil);

</pre>

</details>

### updateRecordsStatus(_ app: Int, _ records: [RecordUpdateStatusItem])

**Parameter**

See at [Record - updateRecordsStatus](./record#updaterecordsstatus_-app-int-_-records-recordupdatestatusitem)

**Return**

[BulkRequest](#bulkrequest)

**Sample code**

<details class="tab-container" open>
<Summary>Update the status of multiple records in bulk</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    // create updateRecordsStatus bulk request
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
    bulkRequest = try! bulkRequest?.updateRecordsStatus(appID, itemList);

</pre>

</details>

### execute()

Execute the bulk request and get data response

**Parameter**

(none)

**Return**

[BulkRequestResponse](../model/bulk-request/bulk-request-response)

**Sample code**

<details class="tab-container" open>
<Summary>Execute bulk request</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    bulkRequest?.execute().then{responses in
        print(responses)
    }.catch{error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription))
        }
    }
    
</pre>

</details>

## Reference

- [Bulk Request](https://developer.kintone.io/hc/en-us/articles/213148977/)