# GetRecordCursorResponse

The response of the get records by cursor

## Constructor

### **Parameter**

| Name| Type| Description |
| --- | --- | --- |
| records | [[String:FieldValue]] | The array of records data
| next | Bool | Show if there's more records to get from kintone for cursor.

## Methods

### getRecords()

Get the records data.

**Parameter **

(none)

**Return**

[[String:FieldValue]]

### setRecords(records: [[String:FieldValue]])

Set the records data.

**Parameter **

| Name| Type| Description |
| --- | --- | --- |
| records | [[String:FieldValue]] | The array of records data

**Return**

None

### getNext()

Show if there's more records to get from kintone for cursor.

**Parameter **

(none)

**Return**

Bool

### setNext( next: Bool)

Set the next param

**Parameter **

| Name| Type| Description |
| --- | --- | --- |
| next | Bool | Show if there's more records to get from kintone for cursor.

**Return**

None