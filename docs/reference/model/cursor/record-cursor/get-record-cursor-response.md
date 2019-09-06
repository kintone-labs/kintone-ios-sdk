# GetRecordCursorResponse

The response of the get records by cursor

## Constructor

**Declaration**

    init(_ records: [[String:FieldValue]]?, _ next: Bool?)

### **Parameter**

| Name| Type| Description |
| --- | --- | --- |
| records | [[String:FieldValue]] | The array of records data
| next | Bool | Show if there's more records to get from kintone for cursor.

## Methods

### getRecords

Get the records data.

**Declaration**

    func getRecords()->  [[String:FieldValue]] 

**Parameter **

(none)

**Return**

[[String:FieldValue]]

### setRecords

Set the records data.

**Declaration**

    func setRecords(_ records: [[String:[FieldValue]]?)

**Parameter **

| Name| Type| Description |
| --- | --- | --- |
| records | [[String:FieldValue]] | The array of records data

**Return**

None

### getNext

Show if there's more records to get from kintone for cursor.

**Declaration**

    func getNext()-> Bool

**Parameter **

(none)

**Return**

Bool

### setNext

Set the next param

**Declaration**

    func setNext(_ next: Bool?)

**Parameter **

| Name| Type| Description |
| --- | --- | --- |
| next | Bool | Show if there's more records to get from kintone for cursor.

**Return**

None