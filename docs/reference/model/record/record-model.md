# Record Model

General record response, using for data response from the kintone app

## GetRecordResponse

Methods

### getRecord()

Get the Record data response.

**Parameter**

(none)

**Return**

HashMap<String, [FieldValue](./record-field-model#fieldvalue)\>

## GetRecordsResponse

Methods

### getRecords()

Get the Records data response.

**Parameter**

(none)

**Return**

ArrayList<HashMap<String, [FieldValue](./record-field-model#fieldvalue)\>\>

### getTotalCount()

Get the number of records response.

**Parameter**

(none)

**Return**

Integer

## AddRecordResponse

Methods

### getID()

Get the the ID of record added.

**Parameter**

(none)

**Return**

Integer

### getRevision()

Get the revision number of record added.

**Parameter**

(none)

**Return**

Integer

## AddRecordsResponse

Methods

### getIDs()

Get the array of added records ID.

**Parameter**

(none)

**Return**

ArrayList<Integer\>

### getRevisions()

Get the array of added records revision number.

**Parameter**

(none)

**Return**

ArrayList<Integer\>

## UpdateRecordResponse

Methods

### getRevision()

Get the revision number of record updated.

**Parameter**

(none)

**Return**

Integer

## UpdateRecordsResponse

Methods

### getRecords()

Get the array of added records ID with revision.

**Parameter**

(none)

**Return**

ArrayList<[RecordUpdateResponseItem](#recordupdateresponseitem)\>

## RecordUpdateResponseItem

Methods

### getID()

Get the the ID of record updated.

**Parameter**

(none)

**Return**

Integer

### getRevision()

Get the revision number of record updated.

**Parameter**

(none)

**Return**

Integer

## RecordUpdateItem

### Constructor

**Parameter**

| Name| type| Description |
| --- | ---  | --- |
| id | Integer  | The ID of the record.
| revision | Integer  | The revision number of the record.
| updateKey | [RecordUpdateKey](#recordupdatekey)  |  The unique key of the record to be updated. Required, if id will not be specified. To specify this field, the field must have the "Prohibit duplicate values" option turned on.
| record | HashMap<String, [FieldValue](./record-field-model#fieldvalue)\>  | The data to update record.

Methods

(none)

## RecordUpdateKey

### Constructor

**Parameter**

| Name| type| Description |
| --- | ---  | --- |
| field | String  | The field code of unique key in the kintone app.
| value | String  | The field value in the record.

Methods

(none)

## RecordUpdateStatusItem

### Constructor

**Parameter**

| Name| type| Description |
| --- | ---  | --- |
| action | String  | The Action name of the action you want.
| assignee | String  |  (Optional) The next Assignee. Specify the Assignee's log in name..
| id | Integer  |   The record ID.
| revision | Integer  |  (Optional) The revision number of the record before updating the status.If the specified revision is not the latest revision, the request will result in an error.

Methods

(none)

## RecordUpsertItem

### Constructor

**Declaration**

<pre class="inline-code">
public init(_ updateKey: RecordUpdateKey?,_ record: [String:FieldValue]?)
</pre>

**Parameter**

| Name|Description |
| --- | --- |
| updateKey |  The unique key of the record to be updated. Required, if id will not be specified. To specify this field, the field must have the "Prohibit duplicate values" option turned on.
| record | The data to update record.

Methods

### getRecord

Get the Record data response.

**Declaration**

<pre class="inline-code">
func getRecord() -> [String:FieldValue]?
</pre>

**Parameter**

(none)

**Return**

HashMap&lt;String, [FieldValue](./record-field-model#fieldvalue)&gt;

### getRecord

Get the Record data response by UpdateKey.

**Declaration**

<pre class="inline-code">
func getRecord(_ updateKey: RecordUpdateKey?) -> [String:FieldValue]?
</pre>

**Parameter**

| Name| Description |
| --- | --- |
| updateKey | The unique key of the record to be updated. Required, if id will not be specified. To specify this field, the field must have the "Prohibit duplicate values" option turned on.

**Return**

HashMap&lt;String, [FieldValue](./record-field-model#fieldvalue)&gt;

### getUpdateKey

Get the unique key of record.

**Declaration**

<pre class="inline-code">
func getUpdateKey() -> RecordUpdateKey?
</pre>

**Parameter**

(none)

**Return**

[RecordUpdateKey](#recordupdatekey)

### setRecord

Set the Record data response.

**Declaration**

<pre class="inline-code">
func setRecord(_ record: [String:FieldValue]?)
</pre>

**Parameter**

| Name| Description |
| --- | --- |
| record | The data to update record.

**Return**

(none)

### setUpdateKey

Set the unique key of record.

**Declaration**

<pre class="inline-code">
func setUpdateKey(_ updateKey: RecordUpdateKey?)
</pre>

**Parameter**

| Name| Description |
| --- | --- |
| updateKey | The unique key of the record to be updated. Required, if id will not be specified. To specify this field, the field must have the "Prohibit duplicate values" option turned on.

**Return**

(none)