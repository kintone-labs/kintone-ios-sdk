# CreateRecordCursorResponse

The response of the create record cursor.

## Constructor

**Declaration**

    init(_ connection: Connection?)

### **Parameter**

| Name| Description |
| --- |  --- |
| id | The cursor ID.
| totalCount | The total count of records that match the query conditions.

## Methods

### getId

Get the cursor ID.

**Declaration**

    func getId() -> String

**Parameter **

(none)

**Return**

String

### setId

Set the cursor ID.

**Declaration**

    func setId(_ id: String?)

**Parameter **

| Name| Description |
| --- |  --- |
| id | The cursor ID.

**Return**

None

### getTotalCount

Get the total count of records that match the query conditions.

**Declaration**

    func getTotalCount() -> Int

**Parameter **

(none)

**Return**

Integer

### setTotalCount(totalCount: Int)

Set the total count of records that match the query conditions.

**Declaration**

    func setTotalCount(_ totalCount: Int?)

**Parameter **

| Name| Description |
| --- |  --- |
| totalCount | The total count of records that match the query conditions.

**Return**

None