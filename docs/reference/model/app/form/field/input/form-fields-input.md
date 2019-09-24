# Input

Get a list of fields and their settings.

- Permissions to view the App is needed.
- API Tokens cannot be used with this API.

## AttachmentField

!!! warning
    - extend the abstract class  "[AbstractInputField](#abstractinputfield)"

### Methods

#### getThumbnailSize

Get the thumbnailSize

**Declaration**

```
func getThumbnailSize() -> Int?
```

**Parameter**

(none)

**Return**

Integer

## CalculatedField


!!! warning
    - extend the abstract class  "[AbstractInputField](#abstractinputfield)"

### Methods

#### getExpression

Get the expression

**Declaration**

```
func getExpression() -> String?
```

**Parameter**

(none)

**Return**

String

#### getHideExpression

Get the hideExpression

**Declaration**

```
func getHideExpression() -> Bool?
```

**Parameter**

(none)

**Return**

Boolean

#### getDisplayScale

Get the displayScale

**Declaration**

```
func getDisplayScale() -> Int?
```

**Parameter**

(none)

**Return**

Integer

#### getUnit

Get the unit

**Declaration**

```
func getUnit() -> String?
```

**Parameter**

(none)

**Return**

String

#### getUnitPosition

Get the unitPosition

**Declaration**

```
func getUnitPosition() -> UnitPosition?
```

**Parameter**

(none)

**Return**

UnitPosition

#### getFormat

Get the format

**Declaration**

```
func getFormat() -> NumberFormat?
```

**Parameter**

(none)

**Return**

NumberFormat

## LinkField


!!! warning
    - extend the abstract class  "[AbstractInputField](#abstractinputfield)"

### Methods

#### getDefaultValue

Get the defaultValue

**Declaration**

```
func getDefaultValue() -> String?
```

**Parameter**

(none)

**Return**

String

#### getUnique

Get the unique

**Declaration**

```
func getUnique() -> Bool?
```

**Parameter**

(none)

**Return**

Boolean

#### getMaxLength

Get the maxLength

**Declaration**

```
func getMaxLength() -> Int?
```

**Parameter**

(none)

**Return**

Integer

#### getMinLength

Get the minLength

**Declaration**

```
func getMinLength() -> Int?
```

**Parameter**

(none)

**Return**

Integer

#### getProtocol

Get the protocol

**Declaration**

```
func getProtocol() -> LinkProtocol?
```

**Parameter**

(none)

**Return**

LinkProtocol

## MultiLineTextField


!!! warning
    - extend the abstract class  "[AbstractInputField](#abstractinputfield)"

### Methods

#### getDefaultValue

Get the defaultValue

**Declaration**

```
func getDefaultValue() -> String?
```

**Parameter**

(none)

**Return**

String

## NumberField


!!! warning
    - extend the abstract class  "[AbstractInputField](#abstractinputfield)"

### Methods

#### getDisplayScale

Get the displayScale

**Declaration**

```
func getDisplayScale() -> Int?
```

**Parameter**

(none)

**Return**

Integer

#### getUnit

Get the unit

**Declaration**

```
func getUnit() -> String?
```

**Parameter**

(none)

**Return**

String

#### getUnitPosition

Get the unitPosition

**Declaration**

```
func getUnitPosition() -> UnitPosition?
```

**Parameter**

(none)

**Return**

UnitPosition

#### getDigit

Get the digit

**Declaration**

```
func getDigit() -> Bool?
```

**Parameter**

(none)

**Return**

Boolean

#### getMaxValue

Get the maxValue

**Declaration**

```
func getMaxValue() -> Int?
```

**Parameter**

(none)

**Return**

Integer

#### getMinValue

Get the minValue

**Declaration**

```
func getMinValue() -> Int?
```

**Parameter**

(none)

**Return**

Integer

#### getDefaultValue

Get the defaultValue

**Declaration**

```
func getDefaultValue() -> String?
```

**Parameter**

(none)

**Return**

String

#### getUnique

Get the unique

**Declaration**

```
func getUnique() -> Bool?
```

**Parameter**

(none)

**Return**

Boolean

## RichTextField

!!! warning
    - extend the abstract class  "[AbstractInputField](#abstractinputfield)"

### Methods

#### getDefaultValue

Get the defaultValue

**Declaration**

```
func getDefaultValue() -> String?
```

**Parameter**

(none)

**Return**

String

## SingleLineTextField


!!! warning
    - extend the abstract class  "[AbstractInputField](#abstractinputfield)"

### Methods

#### getMinLength

Get the minLength

**Declaration**

```
func getMinLength() -> String?
```

**Parameter**

(none)

**Return**

Integer

#### getMaxLength

Get the maxLength

**Declaration**

```
func getMaxLength() -> String?
```

**Parameter**

(none)

**Return**

Integer

#### getExpression

Get the expression

**Declaration**

```
func getExpression() -> String?
```

**Parameter**

(none)

**Return**

String

#### getHideExpression

Get the hideExpression

**Declaration**

```
func getHideExpression() -> Bool?
```

**Parameter**

(none)

**Return**

Boolean

#### getDefaultValue

Get the defaultValue

**Declaration**

```
func getDefaultValue() -> String?
```

**Parameter**

(none)

**Return**

String

#### getUnique

Get the unique

**Declaration**

```
func getUnique() -> Bool?
```

**Parameter**

(none)

**Return**

Boolean

## AbstractInputField

!!! warning
    - extend the abstract class  "[Field](../form-fields/#field)"
    - This class is an abstract class.

### Methods

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

#### getNoLabel

Get the noLabel

**Declaration**

```
func getNoLabel() -> Bool?
```

**Parameter**

(none)

**Return**

Boolean

#### getRequired

Get the required

**Declaration**

```
func getRequired() -> Bool?
```

**Parameter**

(none)

**Return**

Boolean

## Reference

- [Get App](https://developer.kintone.io/hc/en-us/articles/212494888)
- [Get Apps](https://developer.kintone.io/hc/en-us/articles/115005336727)
- [Get Form fields](https://developer.kintone.io/hc/en-us/articles/115005509288)
- [Get Form Layout](https://developer.kintone.io/hc/en-us/articles/115005509068)