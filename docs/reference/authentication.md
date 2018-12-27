# Authentication

Authentication module will be used by [Connection](../connection).
This module allows authenticating with the Kintone app by password authenticator or API token authenticator. This module is also supported the basic authenticator.

!!! warning

    - If both the Token and the Password Authentication are specified, the Token Authentication will be ignored and the Password authentication will be used.

## Constructor

**Parameter**

(none)

**Sample code**

<details class="tab-container" open>
<Summary>Init authentication module</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let kintoneAuth = Auth()

</pre>

</details>

## Methods

### setPasswordAuth(username, password)

> Set password authentication for the Authentication module.

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| username | String | yes | The username that is able to authenticate on the kintone app
| password | String | yes | The password that is able to authenticate on the kintone app

**Return**

[Auth](../authentication)

**Sample code**

<details class="tab-container" open>
<Summary>Set password authentication</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let username: String? = "cybozu";
    let password: String? = "cybozu";
    kintoneAuth.setPasswordAuth(username, password);

</pre>

</details>


### setApiToken(apiTokenString)

> Set Api Token for the Authentication module.

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| apiToken | String | yes | The apiToken that is able to authenticate on kintone app

**Return**

[Auth](../authentication)


<details class="tab-container" open>
<Summary>Set APIToken authentication</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let apiToken: String? = "123456789abcdefghijklmnopqrstuvwxyz";
    kintoneAuth.setApiToken(apiToken);

</pre>

</details>


### setBasicAuth(username, password)

> Set Basic authentication for the Authentication module.

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| username | String | yes | The username that is able to authenticate on the kintone app
| password | String | yes | The password that is able to authenticate on the kintone app

**Return**

[Auth](../authentication)

**Sample code**

<details class="tab-container" open>
<Summary>Set basic authentication</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let username: String?  = "cybozu";
    let password: String? = "cybozu";
    kintoneAuth.setBasicAuth(username, password);

</pre>

</details>


### createHeaderCredentials()

Provide the list of HTTP Headers which use to authentication in.

**Parameter**

(none)

**Return**

Array&lt;HTTPHeader&gt;

**Sample code**

<details class="tab-container" open>
<Summary>Provide the list of HTTP Headers which use to authentication in</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let loginName: String? = "your_user_login_name"
    let loginPassword: String? = "your_password"
    let basicLoginName: String? = "your_basic_login_name"
    let basicLoginPassword: String? = "your_basic_password"
    let apiToken: String? = "your_api_token"
            
    let auth = Auth()
    auth.setBasicAuth(basicLoginName, basicLoginPassword)
    auth.setPasswordAuth(loginName, loginPassword)
    auth.setApiToken(apiToken)
    
    let headers: [HTTPHeader?] = auth.createHeaderCredentials()
    var count = 0
    for header in headers {
        print("Key[" + count.description + "]: " + (header?.getKey())!)
        print("Value[" + count.description + "]: " + (header?.getValue())!)
        count += 1
    }
    
</pre>

</details>

### setClientCert(certData, certPassword)

Set certificate by certificate data

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| certData | Data | yes | Data read from certificate file received from kintone
| password | String | yes | The password from kintone to decode the cert file

**Return**

[Auth](../authentication)

**Sample code**

<details class="tab-container" open>
<Summary>Set certificate by certificate data</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let certPassword = "YOUR_CERT_PASSWORD"
    let testBundle = Bundle(for: type(of: self))
    
    let certData = try! Data(contentsOf: testBundle.url(forResource: "YOUR_CERT_NAME", withExtension: "YOUR_CERT_EXTENSION")!)
    auth.setClientCert(certData, certPassword)
    
    let conn = Connection("YOUR_DOMAIN", auth, -1)

</pre>

</details>

### setClientCertByPath(certData, certPassword)

Set certificate by path

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| certPath | String | yes | Path to kintone certificate file
| password | String | yes | The password from kintone to decode the cert file

**Return**

[Auth](../authentication)

**Sample code**

<details class="tab-container" open>
<Summary>Set certificate by path</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let certPassword = "YOUR_CERT_PASSWORD"
    let testBundle = Bundle(for: type(of: self))
    
    let certData = try! Data(contentsOf: testBundle.url(forResource: "YOUR_CERT_NAME", withExtension: "YOUR_CERT_EXTENSION")!)
    auth.setClientCert(certData, certPassword)
    
    let conn = Connection("YOUR_DOMAIN", auth, -1)

</pre>

</details>
