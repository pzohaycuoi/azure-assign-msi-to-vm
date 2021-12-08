function Check-MsiExist {

  param (
    [Parameter(Mandatory)]
    [string]$ResourceGroup,

    [Parameter(Mandatory)]
    [string]$MsiName
  )

  # check if the provided MSI exist in the resource group

  try {
    
    New-Log -Level "INFO" -Message "Check if $($MsiName) is exist"
    $msiInResourceGroup = Get-AzUserAssignedIdentity -ResourceGroupName $ResourceGroup `
      -ErrorAction Stop
    $msiNameInRg = $msiInResourceGroup.name
    
    if ($msiNameInRg -contains $MsiName) {
      
      New-Log -Level "INFO" -Message "Check if $($MsiName) is exist"
      return $true

    }
    else {
      
      New-Log -Level "WARN" -Message "Warn: $($MsiName) not exist in $($ResourceGroup)"
      return $false

    } # end if ($MsiInResourceGroup.name -contains $MsiName)

  }
  catch {
    
    New-Log -Level "ERROR" -Message "Failed: check $($MsiName) in $($ResourceGroup)"
  
    return $false

  } # end try

} # end function Check-SpExist