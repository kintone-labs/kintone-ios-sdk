# Record Model

General record response, using for data response from the kintone app

## GetRecordResponse

Methods

### getRecord()

> get the Record data response.

**Parameter**

(none)

**Return**

HashMap<String, [FieldValue](./record-field-model#fieldvalue)\>

## GetRecordsResponse

Methods

### getRecords()

> get the Records data response.

**Parameter**

(none)

**Return**

ArrayList<HashMap<String, [FieldValue](./record-field-model#fieldvalue)\>\>

### getTotalCount()

> get the number of records response.

**Parameter**

(none)

**Return**

Integer

## AddRecordResponse

Methods

### getID()

> get the the ID of record added.

**Parameter**

(none)

**Return**

Integer

### getRevision()

> get the revision number of record added.

**Parameter**

(none)

**Return**

Integer

## AddRecordsResponse

Methods

### getIDs()

> get the array of added records ID.

**Parameter**

(none)

**Return**

ArrayList<Integer\>

### getRevisions()

> get the array of added records revision number.

**Parameter**

(none)

**Return**

ArrayList<Integer\>

## UpdateRecordResponse

Methods

### getRevision()

> get the revision number of record updated.

**Parameter**

(none)

**Return**

Integer

## UpdateRecordsResponse

Methods

### getRecords()

> get the array of added records ID with revision.

**Parameter**

(none)

**Return**

ArrayList<[RecordUpdateResponseItem](#recordupdateresponseitem)\>

## RecordUpdateResponseItem

Methods

### getID()

> get the the ID of record updated.

**Parameter**

(none)

**Return**

Integer

### getRevision()

> get the revision number of record updated.

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