function Get-TargetResource
{
	[CmdletBinding()]
	[OutputType([System.Collections.Hashtable])]
	param
	(
		[parameter(Mandatory = $true)]
		[ValidateSet("1 Knowledge Consistency Checker","2 Security Events","3 ExDS Interface Events","4 MAPI Interface Events","5 Replication Events","6 Garbage Collection","7 Internal Configuration","8 Directory Access","9 Internal Processing","10 Performance Counters","11 Initialization/Termination","12 Service Control","13 Name Resolution","14 Backup","15 Field Engineering","16 LDAP Interface Events","17 Setup","18 Global Catalog","19 Inter-site Messaging","20 Group Caching","21 Linked-Value Replication","22 DS RPC Client","23 DS RPC Server","24 DS Schema")]
		[System.String]
		$DiagnosticKey
	)

	#Write-Verbose "Use this cmdlet to deliver information about command processing."

	#Write-Debug "Use this cmdlet to write debug information while troubleshooting."


	<#
	$returnValue = @{
		LoggingLevel = [System.Int32]
		DiagnosticKey = [System.String]
		Ensure = [System.String]
	}

	$returnValue
	#>
}


function Set-TargetResource
{
	[CmdletBinding()]
	param
	(
		[ValidateSet(0,1,2,3,4,5)]
		[System.Int32]
		$LoggingLevel,

		[parameter(Mandatory = $true)]
		[ValidateSet("1 Knowledge Consistency Checker","2 Security Events","3 ExDS Interface Events","4 MAPI Interface Events","5 Replication Events","6 Garbage Collection","7 Internal Configuration","8 Directory Access","9 Internal Processing","10 Performance Counters","11 Initialization/Termination","12 Service Control","13 Name Resolution","14 Backup","15 Field Engineering","16 LDAP Interface Events","17 Setup","18 Global Catalog","19 Inter-site Messaging","20 Group Caching","21 Linked-Value Replication","22 DS RPC Client","23 DS RPC Server","24 DS Schema")]
		[System.String]
		$DiagnosticKey,

		[ValidateSet("Present","Absent")]
		[System.String]
		$Ensure
	)

	#Write-Verbose "Use this cmdlet to deliver information about command processing."

	#Write-Debug "Use this cmdlet to write debug information while troubleshooting."

	#Include this line if the resource requires a system reboot.
	#$global:DSCMachineStatus = 1


}


function Test-TargetResource
{
	[CmdletBinding()]
	[OutputType([System.Boolean])]
	param
	(
		[ValidateSet(0,1,2,3,4,5)]
		[System.Int32]
		$LoggingLevel,

		[parameter(Mandatory = $true)]
		[ValidateSet("1 Knowledge Consistency Checker","2 Security Events","3 ExDS Interface Events","4 MAPI Interface Events","5 Replication Events","6 Garbage Collection","7 Internal Configuration","8 Directory Access","9 Internal Processing","10 Performance Counters","11 Initialization/Termination","12 Service Control","13 Name Resolution","14 Backup","15 Field Engineering","16 LDAP Interface Events","17 Setup","18 Global Catalog","19 Inter-site Messaging","20 Group Caching","21 Linked-Value Replication","22 DS RPC Client","23 DS RPC Server","24 DS Schema")]
		[System.String]
		$DiagnosticKey,

		[ValidateSet("Present","Absent")]
		[System.String]
		$Ensure
	)

	#Write-Verbose "Use this cmdlet to deliver information about command processing."

	#Write-Debug "Use this cmdlet to write debug information while troubleshooting."


	<#
	$result = [System.Boolean]
	
	$result
	#>
}


Export-ModuleMember -Function *-TargetResource

