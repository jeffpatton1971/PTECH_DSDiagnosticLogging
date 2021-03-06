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
            $Values = "0x2080ffff", $Logsize
            }
        'Disable'
        {
            $Values = "0", $Logsize
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
                    $Values = "0x2080ffff", ($Logsize * 1mb)
                    }
                'Enable'
                {
                    $Values = "0", ($Logsize * 1mb)
                    }
                }
            }
        'Present'
        {
            switch ($DebugMode)
            {
                'Enable'
                {
                    $Values = "0x2080ffff", ($Logsize * 1mb)
                    }
                'Disable'
                {
                    $Values = "0", ($Logsize * 1mb)
                    }
                }
            }
        }

    if ($Logsize)
    {
        Write-Verbose "Setting $($ValueNames[0]) to $($Values[0])"
        $Result = Set-RegistryValue -Hive HKEY_LOCAL_MACHINE -SubKeyName $RegPath -ValueName $ValueNames[0] -ValueType $ValueType -Value $Values[0]
        if (!($Result.ReturnValue -eq 0))
        {
            throw "Error $($Result.ReturnValue) ocurred"
            }
        if (!($Result.ReturnValue -eq 0))
        {
            throw "Error $($Result.ReturnValue) ocurred"
            }
        Write-Verbose "Setting $($ValueNames[1]) to $($Values[1])"
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
            $Values = "0x2080ffff", $Logsize
            }
        'Disable'
        {
            $Values = "0", $Logsize
            }
        }

    $ValueType = "DWORD"

    $Result = Get-RegistryValue -Hive HKEY_LOCAL_MACHINE -SubKeyName $RegPath -ValueName $ValueNames[0] -ValueType $ValueType
    if ($RegValue.uValue -eq $Values[0])
    {
        Write-Verbose "$($ValueNames[0]) == $($Values[0])"
        $Status = "Present"
        }
    else
    {
        Write-Verbose "$($ValueNames[0]) != $($Values[0])"
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

