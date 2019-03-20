# Field Model

## FieldValue

General Field's value of the kintone app

### Constructor

**Parameter**

(none)

### Methods

#### getType()

Get the type of field.

**Parameter**

(none)

**Return**

FieldType

#### setType(FieldType type)

Set the type of field.

**Parameter**

| Name| type| Description |
| --- | ---  | --- |
| type | FieldType  | The type of field - kintone-sdk FieldType constants.

**Return**

(none)

#### getValue()

Get the value of field in the record.

**Parameter**

(none)

**Return**

Object

#### setValue(Object value)

Set the value of field in the record.

**Parameter**

| Name| type| Description |
| --- | ---  | --- |
| value | Object  | The value of field in the record, read more at [Field Type here](https://developer.kintone.io/hc/en-us/articles/212494818/#responses).


**Return**

(none)

##SubTableValueItem

### Constructor

**Parameter**

(none)

### Methods

#### getID()

Get the ID of item in table.

**Parameter**

(none)

**Return**

Integer


#### setID(Integer id)

Set the ID of table.

**Parameter**

| Name| type | Description |
| --- | ---  | --- |
| id | Integer | The ID of table .

**Return**

(none)

#### getValue()

Get the value of field in the record.

**Parameter**

(none)

**Return**

HashMap<String, [FieldValue](#fieldvalue)\>

#### setValue(HashMap<String, [FieldValue](#fieldvalue)\> value) 

set the value of field in the record.

**Parameter**

| Name| type | Description |
| --- | ---  | --- |
| value | HashMap<String, [FieldValue](#fieldvalue)\>  | The row data of table.


**Return**

(none)
