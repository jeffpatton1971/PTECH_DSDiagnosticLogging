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

	#Write-Verbose "Use this cmdlet to deliver information about command processing."

	#Write-Debug "Use this cmdlet to write debug information while troubleshooting."


	<#
	$returnValue = @{
		DebugMode = [System.String]
		Logsize = [System.Int16]
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

	#Include this line if the resource requires a system reboot.
	#$global:DSCMachineStatus = 1


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

