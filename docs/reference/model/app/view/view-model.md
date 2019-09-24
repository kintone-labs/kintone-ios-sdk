# ViewModel

General information of the member(user/group/organization) on the kintone application

## Methods

### getBuiltinType

Get the code of the user/group/organization

**Declaration**

```
func getBuiltinType() -> BuiltinType?
```

**Parameter**

(none)

**Return**

[BuiltinType](#builtintype)

### setCode()

The [BuiltinType](#BuiltinType) of the built-in View.

**Parameter**

None

**Return**

[BuiltinType](#BuiltinType)

### getDate

The field code set for the Date Field. Responded for Calendar Views.

**Declaration**

```
func getDate() -> String?
```

**Return**

String

### getFields

The list of field codes for the fields displayed in the View.
> Responded for List Views.

**Declaration**

```
func getFields() -> [String]?
```

**Parameter**

None

**Return**

[String]

### getFilterCond

The filter condition as a query.

**Declaration**

```
func getFilterCond() -> String?
```

**Return**

String

### getHtml

The HTML code set for the View. 
> Responded for Custom Views.

**Declaration**

```
func getHtml() -> String?
```

**Parameter**

None

**Return**

String

### getId

The View ID.

**Declaration**

```
func getId() -> Int?
```

**Parameter**

None

**Return**

Integer


### getIndex

The display order (ascending) of the View, when listed with other views.

**Declaration**

```
func getIndex() -> Int?
```

**Parameter**

None

**Return**

Integer


### getName

The name of the View.

**Declaration**

```
func getName() -> String?
```

**Parameter**

None

**Return**

String


### getPager

The pagination settings. 
Responded for Custom Views.

**Declaration**

```
func getPager() -> Bool?
```

**Parameter**

None

**Return**

Boolean

### getSort

The sort order as a query.

**Declaration**

```
func getSort() -> String?
```

**Parameter**

None

**Return**

String

### getTitle

The field code set for the Title Field. 
Responded for Calendar Views.

**Declaration**

```
func getTitle() -> String?
```

**Parameter**

None

**Return**

String

### getType

The type of View in [Type](#type)

**Declaration**

```
func getType() -> ViewType?
```

**Parameter**

None

**Return**

[Type](#type)

## Enum

### Type

| Name | Type | Value | Description |
| --- | --- | --- | --- |
| LIST | String | LIST | List View
| CALENDAR | String | CALENDAR | Custom View
| CUSTOM | String | CUSTOM | Custom View

### BuiltinType

| Name | Type | Value | Description |
| --- | --- | --- | --- |
| ASSIGNEE | String | ASSIGNEE | The "Assigned to me" View.(This list is automatically created if the Process Management settings have been enabled in the app.)
