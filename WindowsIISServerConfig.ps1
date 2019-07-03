configuration WindowsIISServerConfig
{

Import-DscResource -ModuleName @{ModuleName = 'xWebAdministration';ModuleVersion = '1.19.0.0'}
Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    WindowsFeature WebServer
    {
        Ensure  = 'Present'
        Name    = 'Web-Server'
    }

    # IIS Site Default Values
    xWebSiteDefaults SiteDefaults
    {
        ApplyTo                 = 'Machine'
        LogFormat               = 'IIS'
        LogDirectory            = 'C:\inetpub\logs\LogFiles'
        TraceLogDirectory       = 'C:\inetpub\logs\FailedReqLogFiles'
        DefaultApplicationPool  = 'DefaultAppPool'
        AllowSubDirConfig       = 'true'
        DependsOn               = '[WindowsFeature]WebServer'
    }

    # IIS App Pool Default Values
    xWebAppPoolDefaults PoolDefaults
    {
       ApplyTo               = 'Machine'
       ManagedRuntimeVersion = 'v4.0'
       IdentityType          = 'ApplicationPoolIdentity'
       DependsOn             = '[WindowsFeature]WebServer'
    }