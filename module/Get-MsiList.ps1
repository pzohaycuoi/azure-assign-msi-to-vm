function Get-MsiList {

  # get all the msi in the current subscription

  try {
    
    New-Log -Level "INFO" -Message "Getting SP list"
    $msiList = Get-AzUserAssignedIdentity -ErrorAction Stop
    New-Log -Level "INFO" -Message "Get SP list success"
    return $msiList

  }
  catch {
    
    New-Log -Level "ERROR" -Message "Get SP list failed, aborting"
    return $false

  } # end try
  
} # end function Get-SpList