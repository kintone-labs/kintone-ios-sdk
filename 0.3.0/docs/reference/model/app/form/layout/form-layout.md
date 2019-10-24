# Form Layout

Get the layout of a form.
Length and width of the field,
The fields you set on the table and their order,
Put fields in the Group field and their layout,
label, space, and border settings.

- Permissions to view the App is needed.
- API Tokens cannot be used with this API.

## FormLayout

### Methods

#### getRevision

Get the revision

**Declaration**

```
func getRevision() -> String?
```

**Parameter**

(none)

**Return**

String

#### getLayout

Get the layout

**Declaration**

```
func getLayout() -> [ItemLayout]?
```

**Parameter**

(none)

**Return**

List<[ItemLayout](#itemlayout)\>

## FieldLayout

### Methods

#### getType

Get the type

**Declaration**

```
func getType() -> String?
```

**Parameter**

(none)

**Return**

String

#### getCode

Get the code

**Declaration**

```
func getCode() -> String?
```

**Parameter**

(none)

**Return**

String

#### getElementId

Get the elementId

**Declaration**

```
func getElementId() -> String?
```

**Parameter**

(none)

**Return**

String

#### getLabel

Get the label

**Declaration**

```
func getLabel() -> String?
```

**Parameter**

(none)

**Return**

String

#### getSize

Get the size

**Declaration**

```
func getSize() -> FieldSize?
```

**Parameter**

(none)

**Return**

[FieldSize](#fieldsize)

## FieldSize

### Methods

#### getWidth

Get the width

**Declaration**

```
func getWidth() -> String?
```

**Parameter**

(none)

**Return**

String

#### getHeight

Get the height

**Declaration**

```
func getHeight() -> String?
```

**Parameter**

(none)

**Return**

String

#### getInnerHeight

Get the innerHeight

**Declaration**

```
func getInnerHeight() -> String?
```

**Parameter**

(none)

**Return**

String

## GroupLayout

!!! warning
    - extend the abstract class  "[ItemLayout](#itemlayout)"

### Methods

#### getCode

Get the code

**Declaration**

```
func getCode() -> String?
```

**Parameter**

(none)

**Return**

String

#### getLayout

Get the layout

**Declaration**

```
func getLayout() -> [RowLayout]?
```

**Parameter**

(none)

**Return**

List<[RowLayout](#rowlayout)>

## RowLayout

!!! warning
    - extend the abstract class  "[ItemLayout](#itemlayout)"

### Methods

#### getFields

Get the fields

**Declaration**

```
func getFields() -> [FieldLayout]?
```

**Parameter**

(none)

**Return**

List<[FieldLayout](#fieldlayout)>

## SubTableLayout

!!! warning
    - extend the abstract class  "[ItemLayout](#itemlayout)"

### Methods

#### getCode

Get the code

**Declaration**

```
func getCode() -> String?
```

**Parameter**

(none)

**Return**

String

## ItemLayout

!!! warning
    - This class is an abstract class.

### Methods

#### getType

Get the type

**Declaration**

```
func getType() -> LayoutType?
```

**Parameter**

(none)

**Return**

LayoutType

## Reference

- [Get App](https://developer.kintone.io/hc/en-us/articles/212494888)
- [Get Apps](https://developer.kintone.io/hc/en-us/articles/115005336727)
- [Get Form fields](https://developer.kintone.io/hc/en-us/articles/115005509288)
- [Get Form Layout](https://developer.kintone.io/hc/en-us/articles/115005509068)