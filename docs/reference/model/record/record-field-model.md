# Field Model

## FieldValue

General Field's value of the kintone app

### Constructor

**Parameter**

(none)

### Methods

#### getType

Get the type of field.

**Declaration**

```
func getType() -> FieldType?
```

**Parameter**

(none)

**Return**

FieldType

#### setType

Set the type of field.

**Declaration**

```
func setType(_ type: FieldType)
```

**Parameter**

| Name| type| Description |
| --- | ---  | --- |
| type | FieldType  | The type of field - kintone-sdk FieldType constants.

**Return**

(none)

#### getValue()

Get the value of field in the record.

**Declaration**

```
func getValue() -> Any?
```

**Parameter**

(none)

**Return**

Object

#### setValue

Set the value of field in the record.

**Declaration**

```
setValue(_ value: Any?)
```

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

#### getID

Get the ID of item in table.

**Declaration**

```
func getID() -> Int?
```

**Parameter**

(none)

**Return**

Integer


#### setID

Set the ID of table.

**Declaration**

```
func setID(_ id: Int)
```

**Parameter**

| Name| type | Description |
| --- | ---  | --- |
| id | Integer | The ID of table .

**Return**

(none)

#### getValue

Get the value of field in the record.

**Declaration**

```
func getValue() -> [String:FieldValue]?
```

**Parameter**

(none)

**Return**

HashMap<String, [FieldValue](#fieldvalue)\>

#### setValue

set the value of field in the record.

**Declaration**

```
func setValue(_ value: [String:FieldValue])
```

**Parameter**

| Name| type | Description |
| --- | ---  | --- |
| value | HashMap<String, [FieldValue](#fieldvalue)\>  | The row data of table.


**Return**

(none)
