Configuration SetNtdsDiagnosticLogging
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
        #region Configure NTDS Diagnostic Logging
        #
        PTECH_SetNtdsDiagnosticLogging KnowledgeConsistencyChecker
        {
            LoggingLevel = '0'
            DiagnosticKey = '1 Knowledge Consistency Checker'
            Ensure = 'Present'
            }
        PTECH_SetNtdsDiagnosticLogging SecurityEvents
        {
            LoggingLevel = '0'
            DiagnosticKey = '2 Security Events'
            Ensure = 'Present'
            }
        PTECH_SetNtdsDiagnosticLogging ExDSInterfaceEvents
        {
            LoggingLevel = '0'
            DiagnosticKey = '3 ExDS Interface Events'
            Ensure = 'Present'
            }
        PTECH_SetNtdsDiagnosticLogging MAPIInterfaceEvents
        {
            LoggingLevel = '0'
            DiagnosticKey = '4 MAPI Interface Events'
            Ensure = 'Present'
            }
        PTECH_SetNtdsDiagnosticLogging ReplicationEvents
        {
            LoggingLevel = '0'
            DiagnosticKey = '5 Replication Events'
            Ensure = 'Present'
            }
        PTECH_SetNtdsDiagnosticLogging GarbageCollection
        {
            LoggingLevel = '0'
            DiagnosticKey = '6 Garbage Collection'
            Ensure = 'Present'
            }
        PTECH_SetNtdsDiagnosticLogging InternalConfiguration
        {
            LoggingLevel = '0'
            DiagnosticKey = '7 Internal Configuration'
            Ensure = 'Present'
            }
        PTECH_SetNtdsDiagnosticLogging DirectoryAccess
        {
            LoggingLevel = '0'
            DiagnosticKey = '8 Directory Access'
            Ensure = 'Present'
            }
        PTECH_SetNtdsDiagnosticLogging InternalProcessing
        {
            LoggingLevel = '0'
            DiagnosticKey = '9 Internal Processing'
            Ensure = 'Present'
            }
        PTECH_SetNtdsDiagnosticLogging PerformanceCounters
        {
            LoggingLevel = '0'
            DiagnosticKey = '10 Performance Counters'
            Ensure = 'Present'
            }
        PTECH_SetNtdsDiagnosticLogging InitializationTermination
        {
            LoggingLevel = '0'
            DiagnosticKey = '11 Initialization/Termination'
            Ensure = 'Present'
            }
        PTECH_SetNtdsDiagnosticLogging ServiceControl
        {
            LoggingLevel = '0'
            DiagnosticKey = '12 Service Control'
            Ensure = 'Present'
            }
        PTECH_SetNtdsDiagnosticLogging NameResolution
        {
            LoggingLevel = '0'
            DiagnosticKey = '13 Name Resolution'
            Ensure = 'Present'
            }
        PTECH_SetNtdsDiagnosticLogging Backup
        {
            LoggingLevel = '0'
            DiagnosticKey = '14 Backup'
            Ensure = 'Present'
            }
        PTECH_SetNtdsDiagnosticLogging FieldEngineering
        {
            LoggingLevel = '0'
            DiagnosticKey = '15 Field Engineering'
            Ensure = 'Present'
            }
        PTECH_SetNtdsDiagnosticLogging LDAPInterfaceEvents
        {
            LoggingLevel = '0'
            DiagnosticKey = '16 LDAP Interface Events'
            Ensure = 'Present'
            }
        PTECH_SetNtdsDiagnosticLogging Setup
        {
            LoggingLevel = '0'
            DiagnosticKey = '17 Setup'
            Ensure = 'Present'
            }
        PTECH_SetNtdsDiagnosticLogging GlobalCatalog
        {
            LoggingLevel = '0'
            DiagnosticKey = '18 Global Catalog'
            Ensure = 'Present'
            }
        PTECH_SetNtdsDiagnosticLogging IntersiteMessaging
        {
            LoggingLevel = '0'
            DiagnosticKey = '19 Inter-site Messaging'
            Ensure = 'Present'
            }
        PTECH_SetNtdsDiagnosticLogging GroupCaching
        {
            LoggingLevel = '0'
            DiagnosticKey = '20 Group Caching'
            Ensure = 'Present'
            }
        PTECH_SetNtdsDiagnosticLogging LinkedValueReplication
        {
            LoggingLevel = '0'
            DiagnosticKey = '21 Linked-Value Replication'
            Ensure = 'Present'
            }
        PTECH_SetNtdsDiagnosticLogging DSRPCClient
        {
            LoggingLevel = '0'
            DiagnosticKey = '22 DS RPC Client'
            Ensure = 'Present'
            }
        PTECH_SetNtdsDiagnosticLogging DSRPCServer
        {
            LoggingLevel = '0'
            DiagnosticKey = '23 DS RPC Server'
            Ensure = 'Present'
            }
        PTECH_SetNtdsDiagnosticLogging DSSchema
        {
            LoggingLevel = '0'
            DiagnosticKey = '24 DS Schema'
            Ensure = 'Present'
            }
        #
        #endregion
        #
        }
    }