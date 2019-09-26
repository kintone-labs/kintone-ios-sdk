# kintoneAPIException

Handle error responses from the Kintone Rest API

## Methods

### getHttpErrorCode

**Declaration**

```
func getHttpErrorCode() -> Int?
```

**Parameter**

(none)

**Return**

int

**Sample code**

<details class="tab-container" open>
<Summary>Get http error code</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let recordManagement = Record(connection)
    recordManagement.getRecord(-1, 1).then{response in
        print(response)  
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).getHttpErrorCode()!)
        }
    }

</pre>

</details>

### getErrorResponse

**Declaration**

```
func getErrorResponse() -> ErrorResponse?
```

**Parameter**

(none)

**Return**

[ErrorResponse](https://developer.kintone.io/hc/en-us/articles/212495188#responses)

**Sample code**

<details class="tab-container" open>
<Summary>Get apps with error response</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let recordManagement = Record(connection)
    recordManagement.getRecord(-1, 1).then{response in
        print(response)  
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).getErrorResponse().getId()!)
            print((error as! KintoneAPIException).getErrorResponse().getMessage()!)
            print((error as! KintoneAPIException).getErrorResponse().getCode()!)
        }
    }

</pre>

</details>

### getErrorResponses

**Declaration**

```
func getErrorResponses() -> Array<ErrorResponse>?
```

**Parameter**

(none)

**Return**

ArrayList&lt;[ErrorResponse](https://developer.kintone.io/hc/en-us/articles/212495188#responses)&gt;

**Sample code**

<details class="tab-container" open>
<Summary>Get apps with error responses</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    // Init Bulk request
    var bulkRequest = BulkRequest(connection);
    
    var record: [String: FieldValue] = [:]
            
    let fv = FieldValue()
    fv.setType(FieldType.SINGLE_LINE_TEXT)
    fv.setValue("test_AddRecord")
    
    record["Your_Field_Code"] = fv
    bulkRequest = try bulkRequest?.addRecord(-1, record)
    bulkRequest?.execute().catch{error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).getErrorResponses().toString()!)
        }
        else {
            print((error as! Error).localizedDescription))
        }
    }

</pre>

</details>