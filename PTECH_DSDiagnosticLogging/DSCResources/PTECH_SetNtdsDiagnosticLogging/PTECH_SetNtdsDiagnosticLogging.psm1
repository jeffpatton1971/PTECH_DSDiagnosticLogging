function Get-TargetResource
{
	[CmdletBinding()]
	[OutputType([System.Collections.Hashtable])]
	param
	(
		[ValidateRange(0,5)]
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

    Write-Verbose "Incoming Param LoggingLevel  : $($LoggingLevel)"
    Write-Verbose "Incoming Param DiagnosticKey : $($DiagnosticKey)"
    Write-Verbose "Incoming Param Ensure        : $($Ensure)"

    $RegPath = 'SYSTEM\CurrentControlSet\services\NTDS\Diagnostics\'

    $EnsurePresent = 'Absent'
    $Result = Get-RegistryValue -Hive HKEY_LOCAL_MACHINE -SubKeyName $RegPath -ValueName $DiagnosticKey -ValueType DWORD
    [bool]$PathExist = $false

    switch ($Result.ReturnValue)
    {
        0
        {
            if ($Result.uValue -eq $LoggingLevel)
            {
                $PathExist = $true
                }
            else
            {
                $PathExist = $false
                }
            }
        1
        {
            $PathExist = $false
            }
        5
        {
            throw "Access Denied"
            }
        default
        {
            throw "Error $($Result.ReturnValue) ocurred"
            }
        }

    switch ($Ensure)
    {
        'Absent'
        {
            #
            # Regpath must NOT exist
            #
            if ($PathExist)
            {
                $EnsurePresent = 'Present'
                }
            else
            {
                $EnsurePresent = 'Absent'
                }
            }
        'Present'
        {
            #
            # Regpath must exist
            #
            if ($PathExist)
            {
                $EnsurePresent = 'Present'
                }
            else
            {
                $EnsurePresent = 'Absent'
                }
            }
        }

	$returnValue = @{
		LoggingLevel = [System.Int32]$LoggingLevel
        DiagnosticKey = [System.String]$DiagnosticKey
		Ensure = [System.String]$EnsurePresent
	}

	$returnValue
}


function Set-TargetResource
{
	[CmdletBinding()]
	param
	(
		[ValidateRange(0,5)]
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

    Write-Verbose "Incoming Param LoggingLevel  : $($LoggingLevel)"
    Write-Verbose "Incoming Param DiagnosticKey : $($DiagnosticKey)"
    Write-Verbose "Incoming Param Ensure        : $($Ensure)"

    $RegPath = 'SYSTEM\CurrentControlSet\services\NTDS\Diagnostics\'

	switch ($Ensure)
    {
        'Absent'
        {
            Write-Verbose "Setting $($DiagnosticKey) to 0"
            $Result = Set-RegistryValue -Hive HKEY_LOCAL_MACHINE -SubKeyName $RegPath -ValueName $DiagnosticKey -ValueType DWORD -Value 0
            if (!($Result.ReturnValue -eq 0))
            {
                throw "Error $($Result.ReturnValue) ocurred"
                }
            }
        'Present'
        {
            Write-Verbose "Setting $($DiagnosticKey) to $($LoggingLevel)"
            $Result = Set-RegistryValue -Hive HKEY_LOCAL_MACHINE -SubKeyName $RegPath -ValueName $DiagnosticKey -ValueType DWORD -Value $LoggingLevel
            if (!($Result.ReturnValue -eq 0))
            {
                throw "Error $($Result.ReturnValue) ocurred"
                }
            }
        }
}


function Test-TargetResource
{
	[CmdletBinding()]
	[OutputType([System.Boolean])]
	param
	(
		[ValidateRange(0,5)]
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

    Write-Verbose "Incoming Param LoggingLevel  : $($LoggingLevel)"
    Write-Verbose "Incoming Param DiagnosticKey : $($DiagnosticKey)"
    Write-Verbose "Incoming Param Ensure        : $($Ensure)"

    $RegPath = 'SYSTEM\CurrentControlSet\services\NTDS\Diagnostics\'

    Write-Verbose "Checking if $($RegPath) Exists"
    $Result = Get-RegistryValue -Hive HKEY_LOCAL_MACHINE -SubKeyName $RegPath -ValueName $DiagnosticKey -ValueType DWORD
    if ($Result.ReturnValue -eq 0)
    {
        Write-Verbose "$($RegPath) Exists"
        if ($Result.uValue -eq $LoggingLevel)
        {
            Write-Verbose "$($DiagnosticKey) == $($LoggingLevel)"
            $Status = "Present"
            }
        else
        {
            Write-Verbose "$($DiagnosticKey) != $($LoggingLevel)"
            $Status = "Absent"
            }
        }
    else
    {
        Write-Verbose "$($RegPath) Does not exist"
        $Status = "Absent"
        }

    switch ($Ensure)
    {
        'Absent'
        {
            if ($Status -eq 'Present')
            {
                $Result = $false
                }
            else
            {
                $Result = $true
                }
            }
        'Present'
        {
            if ($Status -eq 'Present')
            {
                $Result = $true
                }
            else
            {
                $Result = $false
                }
            }
        }
	$Result
}


Export-ModuleMember -Function *-TargetResource


Export-ModuleMember -Function *-TargetResource

