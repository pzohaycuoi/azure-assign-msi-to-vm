function Check-MsiExist {

  param (
    [Parameter(Mandatory)]
    [string]$ResourceGroup,

    [Parameter(Mandatory)]
    [string]$MsiName
  )

  try {
    
    New-Log -Level "INFO" -Message "Check if $($MsiName) is exist"
    $msiInResourceGroup = Get-AzUserAssignedIdentity -ResourceGroupName $ResourceGroup `
      -ErrorAction Stop
    $msiNameInRg = $msiInResourceGroup.name
    if (-not ($msiNameInRg -contains $MsiName)) {
      
      New-Log -Level "WARN" -Message "$($MsiName) not exist in $($ResourceGroup)"

      return $false

    }
    else {
      
      New-Log -Level "INFO" -Message "Check if $($MsiName) is exist"

      return $true

    } # end if ($MsiInResourceGroup.name -contains $MsiName)

  }
  catch {
    
    New-Log -Level "ERROR" -Message "Failed to check $($MsiName) in $($ResourceGroup)"
    
    return $false

  } # end try

} # end function Check-SpExist