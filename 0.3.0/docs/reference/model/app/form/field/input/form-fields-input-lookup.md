# Lookup

Get a list of fields and their settings.

- Permissions to view the App is needed.
- API Tokens cannot be used with this API.

## LookupField

!!! warning
    - extend the abstract class  "[AbstractInputField](../form-fields-input/#abstractinputfield)"

### Methods

#### getLookup

Get the lookup

**Declaration**

```
func getLookup() -> LookupItem?
```

**Parameter**

(none)

**Return**

[LookupItem](#lookupitem)

## LookupItem

### Methods

#### getFieldMapping

Get the fieldMapping

**Declaration**

```
func getFieldMapping() -> [FieldMapping]
```

**Parameter**

(none)

**Return**

List<[FieldMapping](../form-fields/#fieldmapping)\>

#### getFilterCond

Get the filterCond

**Declaration**

```
func getFilterCond() -> String?
```

**Parameter**

(none)

**Return**

String

#### getLookupPickerFields

Get the lookupPickerFields

**Declaration**

```
func getLookupPickerFields() -> [String]
```

**Parameter**

(none)

**Return**

List<String\>

#### getRelatedApp

Get the relatedApp

**Declaration**

```
func getRelatedApp() -> RelatedApp?
```

**Parameter**

(none)

**Return**

[RelatedApp](../form-fields-related_record/#relatedapp)

#### getRelatedKeyField

Get the relatedKeyField

**Declaration**

```
func getRelatedKeyField() -> String?
```

**Parameter**

(none)

**Return**

String

#### getSort

Get the sort

**Declaration**

```
func getSort() -> String?
```

**Parameter**

(none)

**Return**

String

## Reference

- [Get App](https://developer.kintone.io/hc/en-us/articles/212494888)
- [Get Apps](https://developer.kintone.io/hc/en-us/articles/115005336727)
- [Get Form fields](https://developer.kintone.io/hc/en-us/articles/115005509288)
- [Get Form Layout](https://developer.kintone.io/hc/en-us/articles/115005509068)