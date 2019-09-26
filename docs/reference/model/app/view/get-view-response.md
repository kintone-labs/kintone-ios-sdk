# GetViewsResponse
The views of an apps.

## Constructor

### **Parameter**


| Name| Type| Description |
| --- | --- | --- |
| views | [String: [ViewModel](../view-model)] | The appId
| revision | The revision of the preview app

## Methods

### getViews

Get the views of an app.

**Declaration**

```
func getViews() -> [String: ViewModel]?
```

**Parameter**

(none)

**Return**

[String: [ViewModel](../view-model)]

### getRevision

The revision of the preview app.

**Declaration**

```
func getRevision() -> Int?
```

**Parameter**

(none)

**Return**

Integer