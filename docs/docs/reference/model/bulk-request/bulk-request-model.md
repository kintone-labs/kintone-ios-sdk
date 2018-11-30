# Bulk Request Model

Store a list of requests and responses for a bulk request.

## BulkRequestModel

### Constructor

**Parameter**

(none)

### Methods

#### addRequest(bulkRequestItem)

**Parameter**

| Name| Type| Description |
| --- | --- | --- |
| bulkRequestItem | [BulkRequestItem](#bulkrequestitem) | The BulkRequest Item.

**Return**

(none)

##BulkRequestItem

### Constructor

**Parameter**

| Name| Type| Description |
| --- | --- | --- |
| method | String | The API method name.
| api | String | The path of the API.
| payload | Object | The parameters to be passed onto the API.Contents and formats will change depending on the API.

##BulkRequestResponse

### Constructor

**Parameter**

(none)

### Methods

#### getResults()

**Parameter**

(none)

**Return**

ArrayList<Object\>

