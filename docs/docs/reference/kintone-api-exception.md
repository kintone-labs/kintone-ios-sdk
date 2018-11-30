# kintoneAPIException

Handle error responses from kintone Rest API

## Methods

### getHttpErrorCode()

**Parameter **

(none)

**Return**

int

**Sample code**

<details class="tab-container" open>
<Summary>Get http error code</Summary>

** Source code **

```java
let recordManagement = Record(connection)
recordManagement.getRecord(-1, 1).then{response in
    print(response)  
}.catch{ error in
    if error is KintoneAPIException {
        print((error as! KintoneAPIException).getHttpErrorCode()!)
    }
}

```

</details>

### getErrorResponse()

**Parameter **

(none)

**Return**

[ErrorResponse](https://developer.kintone.io/hc/en-us/articles/212495188#responses)

**Sample code**

<details class="tab-container" open>
<Summary>Get apps with error response</Summary>

** Source code **

```java
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

```

</details>

### getErrorResponses()

**Parameter **

(none)

**Return**

ArrayList&lt;[ErrorResponse](https://developer.kintone.io/hc/en-us/articles/212495188#responses)&gt;

**Sample code**

<details class="tab-container" open>
<Summary>Get apps with error responses</Summary>

** Source code **

```java

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

```

</details>