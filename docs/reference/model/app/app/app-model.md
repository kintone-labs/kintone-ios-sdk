# AppModel

Gets the basic information about the app.

- Permissions to view the App is needed.
- API Tokens cannot be used with this API.

## Constructor

### **Parameter**

(none)

## Methods

### getAppId

Get the appId

**Declaration**

```
func getAppId() -> Int?
```

**Parameter**

(none)

**Return**

Integer

### getCode

Get the code

**Declaration**

```
func getCode() -> String?
```

**Parameter **

(none)

**Return**

String

### getName

Get the name

**Declaration**

```
func getName() -> String?
```

**Parameter **

(none)

**Return**

String

### getDescription

Get the description

**Declaration**

```
func getDescription() -> String?
```

**Parameter **

(none)

**Return**

String

### getSpaceId

Get the spaceId

**Declaration**

```
func getSpaceId() -> Int?
```

**Parameter **

(none)

**Return**

Integer

### getThreadId

Get the threadId

**Declaration**

```
func getThreadId() -> Int?
```

**Parameter**

(none)

**Return**

Integer

### getCreator

Get the creator

**Declaration**

```
func getCreator() -> Member?
```

**Parameter**

(none)

**Return**

[Member](../member)

### getModifier

Get the modifier

**Declaration**

```
func getModifier() -> Member?
```

**Parameter**

(none)

**Return**

[Member](../member)

### getCreatedAt

Get the createdAt

**Declaration**

```
func getCreadtedAt() -> String?
```

**Parameter**

(none)

**Return**

String

### getModifiedAt

Get the modifiedAt

**Declaration**

```
func getModifiedAt() -> String?
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