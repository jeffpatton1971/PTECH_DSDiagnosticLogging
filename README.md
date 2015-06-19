# PTECH DS Diagnostic Logging

A collection of PowerShell DSC Resources for working with various Directory Service logging levels among other things.

## Set NTDS Diagnostic Logging

This resource will allow you to enable or disable various logging capabilities of NTDS. This is controlled by the LoggingLevel which be default is 0 and goes up to 5. The Resource implements 3 properties:

* LoggingLevel
* DiagnosticKey
* Ensure

## NetLogon Debug Logging Mode

This resource will allow you to enable or disable the debug mode built into netlogon.dll. For more details about that see this [KB Article] (https://support.microsoft.com/en-us/kb/109626). The Resource implements 4 properties:

* DebugMode
* Logsize
* Restart
* Ensure
