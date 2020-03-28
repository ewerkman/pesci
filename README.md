# PESCi
## Powershell Extensions for Sitecore Commerce

Pesci is a set of Powershell Extensions for Sitecore Commerce that makes it easier to perform operations on the Sitecore Commerce Engine. 

### Logging in

To perform any of the cmdlets you first need to connect to the Commerce Engine using a username and password. The `Connect-Commerce` cmdlet connects to Sitecore Identity Server using the supplied username and password and retrieves a token. The token is saved in an environment variable called SC_TOKEN which is subsequently used by the other cmdlets to authenticate to Commerce Engine. 

#### Connect-Commerce 

##### Syntax
```
Connect-Commerce 
    -Username <String> 
    -Password <Secure String> 
    -IdentityServerHost <String>
```

##### Example
To get a token which can be used to login to Sitecore Commmerce:

```
    # Enter the admin password from the console
    $password = Read-Host -AsSecureString

    Connect-Commerce -Username admin -Password $password -IdentityServerHost sc9.identityserver 
```

## Cmdlets

### Environment variables

#### SC_EngineHost

#### SC_EnginePort

#### SC_Environment

### Bootstrapping & Initialization

#### Invoke-Bootstrap

##### Syntax

```
    Invoke-Bootstrap 
        -EngineHost <string>
        -EnginePort <Int32>
```

##### Example 

```
    Invoke-Bootstrap -EngineHost authoring.sc9.com -EnginePort 5000
```

#### Invoke-InitializeEnvironment

##### Syntax

```
    Invoke-InitializeEnvironment
        -Environment <string>
        -EngineHost <string>
        -EnginePort <Int32>
```

##### Example 

```
    Invoke-InitializeEnvironment -Environment HabitatAuthoring -EngineHost authoring.sc9.com -EnginePort 5000
```

#### Invoke-CleanEnvironment

##### Syntax

##### Example 

#### Invoke-CheckLongRunningCommand

##### Syntax

##### Example 


