# Related Record

Get a list of fields and their settings.

>
- Permissions to view the App is needed.
- API Tokens cannot be used with this API.

## RelatedApp

### Methods

#### getApp

Get the app

**Declaration**

```
func getApp() -> Int?
```

**Parameter**

(none)

**Return**

 String

**Sample code**

<details class="tab-container" open>
<Summary>get App</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    String app = relatedApp.getApp();

</pre>

</details>

#### getCode

Get the code

**Declaration**

```
func getCode() -> String
```

**Parameter**

(none)

**Return**

String

**Sample code**

<details class="tab-container" open>
<Summary>get Code</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    String app = relatedApp.getCode();

</pre>

</details>

## ReferenceTable

### Methods

#### getCondition

Get the condition

**Declaration**

```
func getCondition() -> FieldMapping?
```

**Parameter**

(none)

**Return**

[FieldMapping](../form-fields/#fieldmapping)

**Sample code**

<details class="tab-container" open>
<Summary>get Condition</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    FieldMapping condition = referenceTable.getCondition();

</pre>

</details>

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

**Sample code**

<details class="tab-container" open>
<Summary>get FilterCond</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    String filterCond = referenceTable.getFilterCond();

</pre>

</details>

#### getRelatedApp

Get the relatedApp

**Declaration**

```
func getRelatedApp() -> RelatedApp?
```

**Parameter**

(none)

**Return**

[RelatedApp](#relatedapp)

**Sample code**

<details class="tab-container" open>
<Summary>get Related App</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    RelatedApp relatedApp = referenceTable.getRelatedApp();

</pre>

</details>

#### getSize

Get the size

**Declaration**

```
func getSize() -> Int?
```

**Parameter**

(none)

**Return**

 Integer

**Sample code**

<details class="tab-container" open>
<Summary>get Size</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    Integer size = referenceTable.getSize();

</pre>

</details>

#### getDisplayFields

Get the displayFields

**Declaration**

```
func getDisplayFields() -> [String]?
```

**Parameter**

(none)

**Return**

 List<String\>

**Sample code**

<details class="tab-container" open>
<Summary>get Display Fields</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    List<String> displayFields = referenceTable.getDisplayFields();

</pre>

</details>

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

**Sample code**

<details class="tab-container" open>
<Summary>get Sort</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    String sort = referenceTable.getSort();

</pre>

</details>

## RelatedRecordsField

!!! warning
    - extend the abstract class  "[Field](../form-fields/#field)"

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

**Sample code**

<details class="tab-container" open>
<Summary>get Label</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    String label = relatedRecordsField.getLabel();

</pre>

</details>

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

**Sample code**

<details class="tab-container" open>
<Summary>get NoLabel</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    Boolean noLabel = relatedRecordsField.getNoLabel();

</pre>

</details>

#### getReferenceTable

Get the referenceTable

**Declaration**

```
func getReferenceTable() -> ReferenceTable?
```

**Parameter**

(none)

**Return**

[ReferenceTable](#referencetable)

**Sample code**

<details class="tab-container" open>
<Summary>get Reference Table</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    ReferenceTable referenceTable = relatedRecordsField.getReferenceTable();
    
</pre>

</details>

## Reference

- [Get App](https://developer.kintone.io/hc/en-us/articles/212494888)
- [Get Apps](https://developer.kintone.io/hc/en-us/articles/115005336727)
- [Get Form fields](https://developer.kintone.io/hc/en-us/articles/115005509288)
- [Get Form Layout](https://developer.kintone.io/hc/en-us/articles/115005509068)