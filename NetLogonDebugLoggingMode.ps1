Configuration NetLogonDebugLoggingMode
{
    param
    (
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]$ComputerName
    )

    Import-DscResource -ModuleName PTECH_DSDiagnosticLogging;
    
    Node $ComputerName
    {
        #
        #region Enable NETLOGON debug logging
        #
        PTECH_NetLogonDebugLoggingMode EnableDebugLog
        {
            DebugMode = 'Enable'
            Logsize = 20
            Restart = $true
            Ensure = 'Present'
            }
        #
        #endregion
        #
        }
    }