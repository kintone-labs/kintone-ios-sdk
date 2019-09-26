# Connection

[Connection](#) module will be used as a connector to connect to the kintone Rest API

## Constructor

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| domain | String | yes | The Domain name or FQDN
| auth | [Auth](../authentication) | yes | The authentication object
| guestSpaceID | Integer | (optional) | The guest space id. Use this parameter to connect to kintone guest space.

**Sample code**

<details class="tab-container" open>
<Summary>Init Connection module</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    // Define Authentication object
    // Init Authentication
    let loginName = 'your_user_login_name'
    let loginPassword = 'your_password'
    let domain = 'your_kintone_domain'
    
    // Init authenticationAuth
    let auth = Auth()
    auth.setPasswordAuth(username, password)
    
    // Init connection
    let connection = Connection(domain, auth)

    // Define the connection that included guest space

    // Init Authentication
    let loginName = 'your_user_login_name'
    let loginPassword = 'your_password'
    let domain = 'your_kintone_domain'
    
    // Init authenticationAuth
    let auth = Auth()
    auth.setPasswordAuth(username, password)

    // Init Guest space
    let guestSpaceID = 3

    // Init connection
    let connection = Connection(domain, auth, guestSpaceID)

</pre>

</details>

## Methods

### setHeader

Set new header of the [Connection](../connection)

**Declaration**

```
func setHeader(_ key: String, _ value: String) -> Connection
```

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| key | String | yes | The header's `key` name
| value | String | yes | The header's value of `key`

**Return**

[Connection](../connection)

**Sample code**

<details class="tab-container" open>
<Summary>Set header of the Connection</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    // Define Authentication object
    // Init Authentication
    let loginName = 'your_user_name'
    let loginPassword = 'your_password'
    let domain = 'your_kintone_domain'
    let key = "X-HTTP-Method-Override";
    let value = "GET";
    
    // Init authenticationAuth
    let auth = Auth()
    auth.setPasswordAuth(username, password)
    
    // Init connection
    let connection = Connection(domain, auth)
    connection.setHeader(key, value);

</pre>

</details>

### setProxy

Set the proxy of the request

**Declaration**

```
func setProxy(_ host: String, _ port: Int)
```

**Parameter**

| Name| Type| Required| Description |
| --- | --- | --- | --- |
| proxyHost | String | yes | The proxy host name
| proxyPort | Integer | yes | The proxy port number

**Return**

(none)

**Sample code**

<details class="tab-container" open>
<Summary>Set the proxy of the request</Summary>

<strong class="tab-name">Source code</strong>

<pre class="inline-code">

    let proxyHost = "xxxx";
    let proxyPort: Int? = {your_proxy_port};
    
    let loginName = 'your_user_login_name'
    let loginPassword = 'your_password'
    let domain = 'your_kintone_domain'
    
    // Init authenticationAuth
    let auth = Auth()
    auth.setPasswordAuth(username, password)
    
    // Init connection
    let connection = Connection(domain, auth)
    connection.setProxy(proxyHost, proxyPort);
    
</pre>

</details>
