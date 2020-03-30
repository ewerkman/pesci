# PESCi - Powershell Extensions for Sitecore Commerce

Pesci is a set of Powershell Extensions for Sitecore Commerce that makes it easier to perform operations on the Sitecore Commerce Engine. 

## Compatibility

* PESCi has been tested on Sitecore Commerce 9.2 and above. 
* It requires Powershell 5.1 or above.

## Installation

The PESCi module can be installed from Powershell Gallery [https://www.powershellgallery.com/packages/Pesci](https://www.powershellgallery.com/packages/Pesci) by using the following command line:

```
PS> Install-Module -Name Pesci
```

## Using PESCi

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
    PS C:\> $password = Read-Host -AsSecureString
    PS C:\> Connect-Commerce -Username admin -Password $password -IdentityServerHost sc9.identityserver 
```

## Cmdlets

### Environment variables

You can use environment variables to set common things like the url and port of the Commerce Engine and the environment you want to use. Once set, the environment variables will be used by the cmdlets if not specified on the command line.

You can use the following environment variables:

| Name        | Description           |  Example|
| ------------- |-------------|-------------| 
|SC_EngineHost|Url of the engine to use|`authoring.sc9.com`|
|SC_EnginePort|Port of the engine to use|`5000`|
|SC_Environment|Default environment to use|`HabitatAuthoring`|


### Bootstrapping & Initialization

#### Invoke-Bootstrap

Bootstraps the Commerce Engine.

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

Initializes the specified environment. You can use the taskid that is returned to check whether the initialize command has been finished, using `Invoke-CheckLongRunningCommand`.

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

Cleans the specified environment.

##### Syntax

```
    Invoke-CleanEnvironment
        -Environment <string>
        -EngineHost <string>
        -EnginePort <Int32>
```

##### Example 

```
    Invoke-CleanEnvironment -Environment HabitatAuthoring -EngineHost authoring.sc9.com -EnginePort 5000
```

#### Invoke-CheckLongRunningCommand

Checks the state of a long running command.

##### Syntax

```
    Invoke-CheckLongRunningCommand
        -TaskId <int32>
        -EngineHost <string>
        -EnginePort <Int32>
```

##### Example 

```
    Invoke-CheckLongRunningCommand -TaskId 322 -EngineHost authoring.sc9.com -EnginePort 5000
```

#### Invoke-RunMinion

Starts specified minion.

##### Syntax

```
    Invoke-RunMinion
        -MinionFullName <string>
        -EnvironmentName
        -EngineHost <string>
        -EnginePort <Int32>
```

##### Example 

```
    Invoke-RunMinion -MinionFullName "Sitecore.Commerce.Plugin.Carts.PurgeCartsMinion, Sitecore.Commerce.Plugin.Carts" -EnvironmentName HabitatAuthoring
```
