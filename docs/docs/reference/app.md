# App

Gets general information of an App, including the name, description, related Space, creator and updater information.

!!! warning
    Use must set the promises to global to use module:

            DispatchQueue.promise = global()


>
- Permissions to view the App is needed.
- API Tokens cannot be used with this API.

## Constructor

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| connection | [Connection](../connection) | yes | The connection module of this SDK.

**Sample code**

<details class="tab-container" open>
<Summary>Init app module</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    // Init authentication
    var kintoneAuth = Auth()
    
    // Password Authentication
    let username = "your_usernamr"
    let password = "your_password"
    kintoneAuth = kintoneAuth.setPasswordAuth(username, password)
    let connection = Connection( "your_domain", kintoneAuth )
    let app = App(connection)

</pre>

</details>

## Methods

### getApp(_ appId: Int?)

> Get single app

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| appId | Integer | yes | The kintone app ID

**Return**

AppModel

**Sample code**

<details class="tab-container" open>
<Summary>get App</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appId: Int = {your_app_id}
    app.getApp(appId).then{response in
        print("appId : \(response.getAppId()!)")
        print("spaceId : \(response.getSpaceId())" )
        print("threadId : \(response.getThreadId())" )
        print("name : \(response.getName()!)")
        print("description : \(response.getDescription()!)")
        print("----------------")
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }

</pre>

</details>

### getApps(_ offset: Int?, _ limit: Int?)

> Get multiple apps

**Parameter **

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| offset | Integer | (optional) | The offset off data result
| limit | Integer | (optional) | The limit number of result

**Return**

List<AppModel>

**Sample code**

<details class="tab-container" open>
<Summary>Get Apps</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    app.getApps().then{appsResponse in
        var count = 1
        for appInfo in appsResponse {
            print("App[\(count)] : ");
            print("appId : \(appInfo.getAppId()!)")
            print("spaceId : \(appInfo.getSpaceId())" )
            print("threadId : \(appInfo.getThreadId())" )
            print("name : \(appInfo.getName()!)")
            print("description : \(appInfo.getDescription()!)")
            print("----------------")
            count = count + 1
        }
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }

</pre>

</details>

### getAppsByIDs(_ ids: [Int]?, _ offset: Int?, _ limit: Int?)

> Get multiple apps by list of ids

**Parameter **

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| ids | List<Integer\> | yes | The array of app ids
| offset | Integer | (optional) | The offset off data result
| limit | Integer | (optional) | The limit number of result

**Return**

List<AppModel>

**Sample code**

<details class="tab-container" open>
<Summary>get Apps By IDs</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    var appIds: [Int] = [{your_app_id}, {your_app_id}]
    let limit: Int = {your_limit}
    let offset : Int = {your_offset}
    
    app.getAppsByIDs(appIds, limit, offset).then{appsResponse in
        var count = 1
    for appInfo in appsResponse {
        print("App[\(count)] : ");
        print("appId : \(appInfo.getAppId()!)")
        print("spaceId : \(appInfo.getSpaceId())" )
        print("threadId : \(appInfo.getThreadId())" )
        print("name : \(appInfo.getName()!)")
        print("description : \(appInfo.getDescription()!)")
        print("----------------")
        count = count + 1
    }
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }

</pre>

</details>

### getAppsByCodes(_ codes: [String]?, _ offset: Int?, _ limit: Int?)

> Get multiple apps by a list of codes

**Parameter **

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| codes | List<String\> | yes | The array of app codes
| offset | Integer | (optional) | The offset off data result
| limit | Integer | (optional) | The limit number of result

**Return**

List<AppModel>

**Sample code**

<details class="tab-container" open>
<Summary>get Apps By Codes</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    var appCode: [String] = [{your_app_code}, {your_app_code}]
    let limit: Int = {your_limit}
    let offset: Int = {your_offset}
    
    app.getAppsByCodes(appCode, limit, offset).then{appsResponse in
    var count = 1
    for appInfo in appsResponse {
        print("App[\(count)] : ");
        print("appId : \(appInfo.getAppId()!)")
        print("appCode : \(appInfo.getCode()!)")
        print("spaceId : \(appInfo.getSpaceId())" )
        print("threadId : \(appInfo.getThreadId())" )
        print("name : \(appInfo.getName()!)")
        print("description : \(appInfo.getDescription()!)")
        print("----------------")
        count = count + 1
    }
    }.catch{ error in
    if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }

</pre>

</details>

### getAppsByName(_ spaceIds: [Int]?, _ offset: Int?, _ limit: Int?)

> Get multiple apps by name

**Parameter **

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| name | String | yes | The app name
| offset | Integer | (optional) | The offset off data result
| limit | Integer | (optional) | The limit number of result

**Return**

List<AppModel>

**Sample code**

<details class="tab-container" open>
<Summary>get Apps By Name</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appName: String = {your_app_name}
    let limit: Int = {your_limit}
    let offset: Int = {your_offset}
    
    app.getAppsByName(appName, limit, offset).then{appsResponse in
        var count = 1
        for appInfo in appsResponse {
            print("App[\(count)] : ");
            print("appId : \(appInfo.getAppId()!)")
            print("appCode : \(appInfo.getCode()!)")
            print("spaceId : \(appInfo.getSpaceId())" )
            print("threadId : \(appInfo.getThreadId())" )
            print("name : \(appInfo.getName()!)")
            print("description : \(appInfo.getDescription()!)")
            print("----------------")
            count = count + 1
        }
        }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }

</pre>

</details>

### getAppsBySpaceIDs(_ spaceIds: [Int]?, _ offset: Int?, _ limit: Int?)

> Get multiple apps by space id

**Parameter **

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| spaceIds | Array<Integer> | (optional) | The Space ID of where the App resides in. <br>Up to 100 IDs can be specified.
| offset | Integer | (optional) | The number of retrievals that will be skipped. <br>Must be between 0 and 2147483647. If nothing is specified, it will default to 0.
| limit | Integer | (optional) | The maximum number of the apps to retrieve. <br>Must be between 1 and 100. <br>If nothing is specified, it will default to 100.

**Return**

List<AppModel>

**Sample code**

<details class="tab-container" open>
<Summary>get Apps By SpaceIDs</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let spaceIds: [Int] = [{your_space_id}, {your_space_id}]
    let limit = {your_litmit}
    let offset = {your_offset}
    
    app.getAppsBySpaceIDs(spaceIds, offset, limit).then{appsResponse in
        var count = 1
        for appInfo in appsResponse {
            print("App[\(count)] : ");
            print("appId : \(appInfo.getAppId()!)")
            print("spaceId : \(appInfo.getSpaceId())" )
            print("threadId : \(appInfo.getThreadId())" )
            print("name : \(appInfo.getName()!)")
            print("description : \(appInfo.getDescription()!)")
            print("----------------")
            count = count + 1
        }
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }

</pre>

</details>

### addPreviewApp(_ name: String?, _ space: Int? = nil, _ thread: Int? = nil)

> Creates a preview App. 

**Parameter **

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| name | String | yes | The App name.<br>The maximum length is 64 characters.|
| space | Integer | (optional) | The Space ID of where the App will be created.|
| thread | Integer | (optional) | The Thread ID of the thread in the Space where the App will be created.<br>It is recommended to ignore this parameter so that Apps are created in the default thread. <br>There is currently no helpful reason to create Apps in threads other than the default thread, as there are no visual representations in kintone of Apps being related to threads.<br> There are only visual representations of Apps being related to Spaces.|

**Return**

PreviewApp

**Sample code**

<details class="tab-container" open>
<Summary>add PreviewApp</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let spaceId = {your_space_id} // Space will add this app
    let threadId = {your_thread_id} // Thread will add this app
    
    app.addPreviewApp(appName, spaceId, threadId).then{ addPreviewRespones in
        print(addPreviewRespones?.getApp())
        print(addPreviewRespones?.getRevision())
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }

</pre>

</details>


### deployAppSettings(_ apps: Array<PreviewApp>?, _ revert: Bool?) 

> Updates the settings of a pre-live App to the live App.

**Parameter **

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| apps | Array<PreviewApp> | yes | The list of Apps to deploy the pre-live settings to the live Apps. The Maximum limit is 300.<br>If Apps are being deployed to Guest Spaces, Apps can only be deployed to the same Guest Space..|
| revert | Boolean | (optional) | Specify <b>"true"</b> to cancel all changes made to the pre-live settings. The pre-live settings will be reverted back to the current settings of the live app.|

**Return**

None

**Sample code**

<details class="tab-container" open>
<Summary>deploy AppSettings</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appId: Int = {your_app_id}
    let revision: Int = {your_revision} // Revision of application to deploy
    let appPreview: PreviewApp? = PreviewApp(appId, revision)
    
    app.deployAppSettings([appPreview!]).catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }

</pre>

</details>

### getAppDeployStatus(_ apps: [Int]?)

> Updates the settings of a pre-live App to the live App.

**Parameter **

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| apps | Array<Integer> | yes | The list of Apps to check the deploy statuses of. The Maximum limit is 300.<br>If Apps in Guest Spaces are specified, all Apps specified in the request must belong to that Guest Space.|

**Return**

GetAppDeployStatusResponse

**Sample code**

<details class="tab-container" open>
<Summary>get App DeployStatus</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appIds: [Int] = [{your_app_id}, {your_app_id}]
    
    app.getAppDeployStatus(appIds).then{deployStatusReponse in
        let listAppsDeployStatus = deployStatusReponse?.getApps()
        for appDeployStatus in listAppsDeployStatus! {
            print(appDeployStatus.getApp())
            print(appDeployStatus.getStatus())
        }
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }

</pre>

</details>


### getFormFields(_ app: Int?, _ lang: LanguageSetting?,_ isPreview: Bool?)

> Get field of form in kintone app

**Parameter **

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| appId | Integer | yes | The app ID
| lang | LanguageSetting | (optional) | The language code. Support: <ul><li>DEFAULT: Default language setting of system </li><li>JA: Japanese language setting</li><li>ZH: Chinese language setting</li><li>EN: English language setting</li> |
| isPreview | Boolean | (optional) | Get the app form fields with a [pre-live settings](https://developer.kintone.io/hc/en-us/articles/115005509288).

**Return**

FormFields

**Sample code**

<details class="tab-container" open>
<Summary>get FormFields</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appId: Int = {your_app_id} // Integer
    let lang: LanguageSetting = {language_code} // LanguageSetting .Ex: LanguageSetting.JA
    
    app.getFormFields(appId, lang).then{ formFieldsResponse in
        print(formFieldsResponse)
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }
    
    // Get a pre-live (preview) form fields
    let appId: Int = {your_app_id} // Integer
    let lang: LanguageSetting = {language_code} // LanguageSetting .Ex: LanguageSetting.JA
    let isPreview: Bool = true
    
    self.app?.getFormFields(appId, lang, isPreview).then{ formFieldsResponse in
        print(formFieldsResponse) // FormFields Object
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }

</pre>

</details>

### addFormFields(_ app: Int?, _ fields: [String: Field]?,_ revision: Int?)

> Adds fields to a form of an App. 

**Parameter **

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| appId | Integer | yes | The app ID
| fields | [String: Field] | (optional) | The formFields which will add to form of kintone app <br> *Note:* <br> [String: Field]: <ul><li>Key: The field code of field on kintone app</li><li> Value:  The field settings of form field on kintone app </li> </ul>|
| revision | Boolean | (optional) | Specify the revision number of the settings that will be deployed.<br>The request will fail if the revision number is not the latest revision.<br>The revision will not be checked if this parameter is ignored, or -1 is specified.

**Return**

BasicResponse

**Sample code**

<details class="tab-container" open>
<Summary>add FormFields</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appId: Int = {your_app_id} // App Id
    let fieldCode: String = {field_code_string} // Field code of new Field. It must be not as same as any fields in Pre-Live App Setttings
    let revision: Int = {latest_revision_of_the_settings} // Integer
    
    // Create Radio field instance and set properties
    let addNewField = RadioButtonField(fieldCode)
    var optionArray = [String: OptionData]()
    optionArray["1"] = OptionData("1","1")
    optionArray["2"] = OptionData("2","2")
    optionArray["3"] = OptionData("3","3")
    addNewField.setOptions(optionArray)
    addNewField.setNoLabel(false)
    addNewField.setRequired(true)
    addNewField.setLabel("Label Radio")
    addNewField.setAlign(AlignLayout.VERTICAL)
    
    // Add Field object into dictionary with key is Field Code
    var properties = [String: Field]()
    properties[fieldCode] = addNewField
    // Another add field here
    
    app.addFormFields(self.APP_ID, properties, revision).then{ basicResponse in
        print(basicResponse)
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }

</pre>

</details>

### updateFormFields(_ app: Int?, _ fields: [String: Field]?,_ revision: Int?)

> Updates the field settings of fields in a form of an App.

**Parameter **

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app | Integer | yes | The app ID
| fields | [String: Field] | (optional) | The formFields which will add to form of kintone app <br> *Note:* <br> [String: Field]: <ul><li>Key: The field code of field on kintone app</li><li> Value:  The field settings of form field on kintone app </li> </ul>|
| revision | Boolean | (optional) | Specify the revision number of the settings that will be deployed.<br>The request will fail if the revision number is not the latest revision.<br>The revision will not be checked if this parameter is ignored, or -1 is specified.

**Return**

BasicResponse

**Sample code**

<details class="tab-container" open>
<Summary>update FormFields</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appId: Int = {your_app_id} // Integer
    let fieldCode: String = {field_code_string} // String | fieldCode of exist fields in Pre-Live App Setttings
    let revision: Int = {latest_revision_of_the_settings} // Integer
    
    // Create Field Object to Update
    let updateField = SingleLineTextField(fieldCode)
    updateField.setDefaultValue("Hello Kintone")
    updateField.setRequired(true)
    
    // Add Update Field object into dictionary with key is Field Code
    var properties = [String: Field]()
    properties[fieldCode] = updateField
    
    app.updateFormFields(appId, properties, revision).then{ basicResponse in
        print(basicResponse) // BasicResponse { revision : <String> }
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }

</pre>

</details>

### deleteFormFields(_ app: Int?, _ fields: [String]?,_ revision: Int?)

> Deletes fields from a form of an App.

**Parameter **

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app | Integer | yes | The app ID
| fields | Array<String\> | yes| The list of field codes of the fields to delete.<br>Up to 100 field codes can be specified.|
| revision | Integer | (optional) | Specify the revision number of the settings that will be deployed.<br>The request will fail if the revision number is not the latest revision.<br>The revision will not be checked if this parameter is ignored, or -1 is specified.

**Return**

BasicResponse

**Sample code**

<details class="tab-container" open>
<Summary>delete FormFields</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appId: Int = {your_app_id} // Integer
    let fieldCodeArray: [String] = [{field_code_string}] // Array<String> | Array of fieldCodes of exist fields in Pre-Live App Setttings
    let revision: Int = {latest_revision_of_the_settings} // Integer
    
    app.deleteFormFields(appId, fieldCodeArray, revision).then{ basicResponse in
        print(basicResponse) // BasicResponse { revision : <String> }
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }

</pre>

</details>

### getFormLayout(_ app: Int?, _ isPreview: Bool?)

> Get layout of form in kintone app

**Parameter **

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app | Integer | yes | The kintone app id
| isPreview | Boolean | (optional) | Get the app form layout with a [pre-live settings](https://developer.kintone.io/hc/en-us/articles/115005509288).

**Return**

FormLayout

**Sample code**

<details class="tab-container" open>
<Summary>get FormLayout</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appId: Int = {your_app_id} // Integer
    
    app.getFormLayout(appId).then{ formLayoutResponse in
        print(response_layout.getLayout()!)
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }
    
    // Get a pre-live (preview) form fields
    let appId: Int = {your_app_id} // Integer
    let isPreview: Bool = true
    
    app.getFormLayout(appId, isPreview).then{ formLayoutResponse in
        print(response_layout.getLayout()!)
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }

</pre>

</details>

### updateFormLayout( _ app: Int?, _ layout: [ItemLayout]?,_ revision: Int?)

> Updates the field layout info of a form in an App. 

**Parameter **

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app | Integer |  | The kintone app id
| layout | Array<ItemLayout\> | yes | A list of field layouts for each row.
| revision | Integer | (optional) | Specify the revision number of the settings that will be deployed.<br>The request will fail if the revision number is not the latest revision.<br>The revision will not be checked if this parameter is ignored, or -1 is specified.

**Return**

BasicResponse

**Sample code**

<details class="tab-container" open>
<Summary>update FormLayout</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appId: Int = {your_app_id} // Integer
    var itemLayoutRequest: [ItemLayout]? = [ItemLayout]()
        
    // Row Layout
    let rowLayout1: RowLayout? = RowLayout()
    var fieldsRowLayout1: [FieldLayout]? = [FieldLayout]()
    
    let singleFieldRowLayout1: FieldLayout? = FieldLayout()
    singleFieldRowLayout1?.setCode("Text")
    singleFieldRowLayout1?.setType(FieldType.SINGLE_LINE_TEXT.rawValue)
    let singleFieldSizeRowLayout1: FieldSize? = FieldSize()
    singleFieldSizeRowLayout1?.setWidth("193")
    singleFieldRowLayout1?.setSize(singleFieldSizeRowLayout1)
    fieldsRowLayout1?.append(singleFieldRowLayout1!)
    
    let richTextFieldRowLayout1: FieldLayout? = FieldLayout()
    richTextFieldRowLayout1?.setCode("Rich_text")
    richTextFieldRowLayout1?.setType(FieldType.RICH_TEXT.rawValue)
    let richTextFieldSizeRowLayout1: FieldSize? = FieldSize()
    richTextFieldSizeRowLayout1?.setWidth("315")
    richTextFieldSizeRowLayout1?.setInnerHeight("125")
    richTextFieldRowLayout1?.setSize(richTextFieldSizeRowLayout1)
    fieldsRowLayout1?.append(richTextFieldRowLayout1!)
    
    rowLayout1?.setFields(fieldsRowLayout1)
    
    // Subtable Layout
    let subTableLayout: SubTableLayout? = SubTableLayout()
    var fieldSubTableLayout: [FieldLayout]? = [FieldLayout]()
    
    let singleFieldSubTableLayout1: FieldLayout? = FieldLayout()
    singleFieldSubTableLayout1?.setCode("Text_0")
    singleFieldSubTableLayout1?.setType(FieldType.SINGLE_LINE_TEXT.rawValue)
    let singleFieldSizeSubTableLayout1: FieldSize? = FieldSize()
    singleFieldSizeSubTableLayout1?.setWidth("193")
    singleFieldSubTableLayout1?.setSize(singleFieldSizeSubTableLayout1)
    
    fieldSubTableLayout?.append(singleFieldSubTableLayout1!)
    subTableLayout?.setFields(fieldSubTableLayout)
    subTableLayout?.setCode("Table")
    
    // GROUP Layout
    let groupLayout: GroupLayout? = GroupLayout()
    var rowLayoutInGroup: [RowLayout]? = [RowLayout]()
    // Row Layout
    let firstRowLayoutInGroup: RowLayout? = RowLayout()
    var fieldsInRowLayoutInGroup: [FieldLayout]? = [FieldLayout]()
    // Numeric Field Layout
    let numericFieldInRowLayoutInGroup: FieldLayout? = FieldLayout()
    numericFieldInRowLayoutInGroup?.setCode("Number")
    numericFieldInRowLayoutInGroup?.setType(FieldType.NUMBER.rawValue)
    // field size
    let numericFieldSizeInRowLayoutInGroup: FieldSize? = FieldSize()
    numericFieldSizeInRowLayoutInGroup?.setWidth("200")
    numericFieldInRowLayoutInGroup?.setSize(numericFieldSizeInRowLayoutInGroup)
    
    fieldsInRowLayoutInGroup?.append(numericFieldInRowLayoutInGroup!)
    firstRowLayoutInGroup?.setFields(fieldsInRowLayoutInGroup)
    rowLayoutInGroup?.append(firstRowLayoutInGroup!)
    groupLayout?.setLayout(rowLayoutInGroup)
    groupLayout?.setCode("Field_group")
    
    // Append layout
    itemLayoutRequest?.append(rowLayout1!)
    itemLayoutRequest?.append(subTableLayout!)
    itemLayoutRequest?.append(groupLayout!)
    
    app.updateFormLayout(appId, itemLayoutRequest).then{ basicResponse in
        print(basicResponse.getRevision())
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }

</pre>

</details>

### getGeneralSettings(_ app: Int?, _ lang: LanguageSetting?, _ isPreview: Bool?)

> Gets the description, name, icon, revision and color theme of an App.

**Parameter **

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app | Integer | yes | The kintone app id
| lang | LanguageSetting | (optional) | The localized language to retrieve the data in language constants
| isPreview | Boolean | (optional) | Get general settings of the app with a [pre-live settings](https://developer.kintone.io/hc/en-us/articles/115005509288).

**Return**

GeneralSettings

**Sample code**

<details class="tab-container" open>
<Summary>get GeneralSettings</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appId = {your_app_id}
    
    app.getGeneralSettings(self.APP_ID).then{appGeneralSetting in
        print(appGeneralSetting.getName())
        print(appGeneralSetting.getIcon())
        print(appGeneralSetting.getKey())
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }
    
    // Get a pre-live (preview) general settings
    let appId = {your_app_id}
    let lang = {your_language_code} // LanguageSetting( EN | JA | ZH ). Ex: LanguageSetting.JA
    let isPreview = true
    
    app.getGeneralSettings(self.APP_ID, self.LANG, isPreview).then{appGeneralSetting in
        print(appGeneralSetting.getName())
        print(appGeneralSetting.getIcon())
        print(appGeneralSetting.getKey())
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }

</pre>

</details>

### updateGeneralSettings(_ app: Int?, _ generalSettings: GeneralSettings?)

> Updates the description, name, icon, revision and color theme of an App.

**Parameter **

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app | Integer | yes | The kintone app id
| generalSettings | GeneralSettings | (Conditional) | The description, name, icon, revision and color theme of an App.<br>The request will fail if the revision number is not the latest revision.<br>The revision will not be checked if ignored, or -1 is specified.

**Return**

BasicResponse

**Sample code**

<details class="tab-container" open>
<Summary>update general settings</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appId: Int = {your_app_id}
    
    let appGeneralSetting: GeneralSettings = GeneralSettings()
    appGeneralSetting.setName("GetViewsApp_Test")
    appGeneralSetting.setDescription("<div>A list of great places to go!</div>")
    let iconModel: Icon = Icon("APP39", Icon.IconType.PRESET)
    appGeneralSetting.setIcon(iconModel)
    appGeneralSetting.setTheme(GeneralSettings.IconTheme.WHITE)
    
    app.updateGeneralSettings(appId, appGeneralSetting).then{ basicResponse in
        print(basicResponse.getRevision())
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }

</pre>

</details>

### getViews(_ app: Int?, _ lang: LanguageSetting?,_ isPreview: Bool?)

> Gets the View settings of a an App.

**Parameter **

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app | Integer | yes | The kintone app id
| lang | LanguageSetting | (optional) | The localized language to retrieve the data in language constants
| isPreview | Boolean | (optional) | Get views of the app with a pre-live settings when isPreview param is set <b>true</b>.

**Return**

GetViewsResponse

**Sample code**

<details class="tab-container" open>
<Summary>get Views</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appId = {your_app_id}
    let lang = LanguageSetting.EN // LanguageSetting( EN | JA | ZH ). Ex: LanguageSetting.JA
    
    app.getViews(appId, lang).then{ appViewResponse in
        print(appViewResponse)
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }
    
    // Get a pre-live (preview) general settings
    let appId = 2 // your app Id
    let lang = LanguageSetting.EN // LanguageSetting( EN | JA | ZH )
    let isPreview = true
    app.getViews(appId, lang, isPreview).then{ appViewResponse in
        print(appViewResponse)
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }

</pre>

</details>

### updateViews(_ app: Int?, _ views: [String: ViewModel],_ revision: Int?) 

> Updates the View settings of an App.

**Parameter **

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| app | Integer | yes | The kintone app id
| views | HashTable<String, View> | yes | An object of data of Views.
| revision | Integer | (optional) | Specify the revision number of the settings that will be deployed.<br>The request will fail if the revision number is not the latest revision.<br>The revision will not be checked if this parameter is ignored, or -1 is specified.


**Return**

UpdateViewsResponse

**Sample code**

<details class="tab-container" open>
<Summary>update Views</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let appId = {your_app_id)}
    let revision = {your_lastest_revision} //default: revision = -1
    
    var viewEntry: [String: ViewModel] = [String: ViewModel]()
    let updateViewModel: ViewModel = ViewModel()
    updateViewModel.setName("ViewTest")
    updateViewModel.setSort("Record_number desc")
    updateViewModel.setType(ViewModel.ViewType.LIST)
    updateViewModel.setFilterCond("Created_datetime = LAST_WEEK()")
    updateViewModel.setIndex(1)
    let fieldsViews: [String] = ["Text", "Text_Area", "Created_datetime"]
    updateViewModel.setFields(fieldsViews)
    viewEntry["ViewTest"] = updateViewModel
    
    let updateViewModel2: ViewModel = ViewModel()
    updateViewModel2.setName("ViewTest2")
    updateViewModel2.setSort("Record_number asc")
    updateViewModel2.setType(ViewModel.ViewType.LIST)
    updateViewModel2.setFilterCond("Created_datetime > LAST_WEEK()")
    updateViewModel2.setIndex(0)
    
    let fieldsInViews2: [String] = ["Text_Area", "Created_datetime"]
    updateViewModel2.setFields(fieldsInViews2)
    
    viewEntry["ViewTest2"] = updateViewModel2
    app.updateViews(appId, viewEntry, revision).then{ updateViewResponse in
        print(updateViewResponse.getRevision())
    }.catch{ error in
        if error is KintoneAPIException {
            print((error as! KintoneAPIException).toString()!)
        }
        else {
            print((error as! Error).localizedDescription)
        }
    }
    
</pre>

</details>

## Reference

- [Get App](https://developer.kintone.io/hc/en-us/articles/212494888)`on developer network`
- [Get Apps](https://developer.kintone.io/hc/en-us/articles/115005336727)`on developer network`
- [Get Form fields](https://developer.kintone.io/hc/en-us/articles/115005509288)`on developer network`
- [Get Form Layout](https://developer.kintone.io/hc/en-us/articles/115005509068)`on developer network`

- [Add Preview App](https://developer.kintone.io/hc/en-us/articles/115004712547)`on developer network`
- [Deploy App Settings](https://developer.kintone.io/hc/en-us/articles/115004881348)`on developer network`
- [Get App Deploy Status](https://developer.kintone.io/hc/en-us/articles/115004890947)`on developer network`
- [Get Views](https://developer.kintone.io/hc/en-us/articles/115004401787)`on developer network`

- [Update Views](https://developer.kintone.io/hc/en-us/articles/115004880588)`on developer network`

- [Get General Settings](https://developer.kintone.io/hc/en-us/articles/115004811668)`on developer network`
- [Update General Settings](https://developer.kintone.io/hc/en-us/articles/115004868628)`on developer network`