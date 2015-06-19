function Get-TargetResource
{
	[CmdletBinding()]
	[OutputType([System.Collections.Hashtable])]
	param
	(
		[parameter(Mandatory = $true)]
		[ValidateSet("Enable","Disable")]
		[System.String]
		$DebugMode,

		[System.Int16]
		$Logsize,
		
        [System.Boolean]
		$Restart,

		[ValidateSet("Present","Absent")]
		[System.String]
		$Ensure
	)

    Write-Verbose "Incoming Param DebugMode : $($DebugMode)"
    Write-Verbose "Incoming Param Logsize   : $($Logsize)"
    Write-Verbose "Incoming Param Restart   : $($Restart)"
    Write-Verbose "Incoming Param Ensure    : $($Ensure)"

    $RegPath = "SYSTEM\CurrentControlSet\Services\Netlogon\Parameters"
    $ValueNames = "DBFlag","MaximumLogFileSize"
    switch ($DebugMode)
    {
        'Enable'
        {
            $Values = "2080FFFF", $Logsize
            }
        'Disable'
        {
            $Values = "0x0", $Logsize
            }
        }

    $ValueType = "DWORD"

    $EnsurePresent = 'Absent'
    $Result = Get-RegistryValue -Hive HKEY_LOCAL_MACHINE -SubKeyName $RegPath -ValueName $ValueNames[0] -ValueType $ValueType
    [bool]$PathExist = $false

    switch ($Result.ReturnValue)
    {
        0
        {
            $PathExist = $true
            }
        2
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
}


function Set-TargetResource
{
	[CmdletBinding()]
	param
	(
		[parameter(Mandatory = $true)]
		[ValidateSet("Enable","Disable")]
		[System.String]
		$DebugMode,

		[System.Int16]
		$Logsize,
		
        [System.Boolean]
		$Restart,

		[ValidateSet("Present","Absent")]
		[System.String]
		$Ensure
	)

    Write-Verbose "Incoming Param DebugMode : $($DebugMode)"
    Write-Verbose "Incoming Param Logsize   : $($Logsize)"
    Write-Verbose "Incoming Param Restart   : $($Restart)"
    Write-Verbose "Incoming Param Ensure    : $($Ensure)"

    $RegPath = "SYSTEM\CurrentControlSet\Services\Netlogon\Parameters"
    $ValueNames = "DBFlag","MaximumLogFileSize"

    $ValueType = "DWORD"

    switch ($Ensure)
    {
        'Absent'
        {
            switch ($DebugMode)
            {
                'Disable'
                {
                    $Values = "2080FFFF", $Logsize
                    }
                'Enable'
                {
                    $Values = "0x0", $Logsize
                    }
                }
            }
        'Present'
        {
            switch ($DebugMode)
            {
                'Enable'
                {
                    $Values = "2080FFFF", $Logsize
                    }
                'Disable'
                {
                    $Values = "0x0", $Logsize
                    }
                }
            }
        }

    if ($Logsize)
    {
        Write-Verbose "Setting $($ValueName[0]) to $($Value[0])"
        $Result = Set-RegistryValue -Hive HKEY_LOCAL_MACHINE -SubKeyName $RegPath -ValueName $ValueNames[0] -ValueType $ValueType -Value $Values[0]
        if (!($Result.ReturnValue -eq 0))
        {
            throw "Error $($Result.ReturnValue) ocurred"
            }
        if (!($Result.ReturnValue -eq 0))
        {
            throw "Error $($Result.ReturnValue) ocurred"
            }
        Write-Verbose "Setting $($ValueName[1]) to $($Value[1])"
        $result = Set-RegistryValue -Hive HKEY_LOCAL_MACHINE -SubKeyName $RegPath -ValueName $ValueNames[1] -ValueType $ValueType -Value $Values[1]
        if (!($Result.ReturnValue -eq 0))
        {
            throw "Error $($Result.ReturnValue) ocurred"
            }
        if (!($Result.ReturnValue -eq 0))
        {
            throw "Error $($Result.ReturnValue) ocurred"
            }
        }
    else
    {
        $Result = Set-RegistryValue -Hive HKEY_LOCAL_MACHINE -SubKeyName $RegPath -ValueName $ValueNames[0] -ValueType $ValueType -Value $Values[0]
        if (!($Result.ReturnValue -eq 0))
        {
            throw "Error $($Result.ReturnValue) ocurred"
            }
        if (!($Result.ReturnValue -eq 0))
        {
            throw "Error $($Result.ReturnValue) ocurred"
            }
        }
    if ($Restart)
    {
        Write-Verbose "Restarting NETLOGON Service"
        Restart-Service -Name Netlogon -Force
        }
}


function Test-TargetResource
{
	[CmdletBinding()]
	[OutputType([System.Boolean])]
	param
	(
		[parameter(Mandatory = $true)]
		[ValidateSet("Enable","Disable")]
		[System.String]
		$DebugMode,

		[System.Int16]
		$Logsize,
		
        [System.Boolean]
		$Restart,

		[ValidateSet("Present","Absent")]
		[System.String]
		$Ensure
	)

    Write-Verbose "Incoming Param DebugMode : $($DebugMode)"
    Write-Verbose "Incoming Param Logsize   : $($Logsize)"
    Write-Verbose "Incoming Param Restart   : $($Restart)"
    Write-Verbose "Incoming Param Ensure    : $($Ensure)"

    $RegPath = "SYSTEM\CurrentControlSet\Services\Netlogon\Parameters"
    $ValueNames = "DBFlag","MaximumLogFileSize"
    switch ($DebugMode)
    {
        'Enable'
        {
            $Values = "2080FFFF", $Logsize
            }
        'Disable'
        {
            $Values = "0x0", $Logsize
            }
        }

    $ValueType = "DWORD"

	#Write-Verbose "Use this cmdlet to deliver information about command processing."

	#Write-Debug "Use this cmdlet to write debug information while troubleshooting."


	<#
	$result = [System.Boolean]
	
	$result
	#>
}


Export-ModuleMember -Function *-TargetResource

