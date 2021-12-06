function Get-SpList {

  try {
    
    New-Log -Level "INFO" -Message "Getting SP list"
    $spList = Get-AzADServicePrincipal -ErrorAction Stop
    New-Log -Level "INFO" -Message "Get SP list success"

    return $spList

  }
  catch {
    
    New-Log -Level "ERROR" -Message "Get SP list failed, aborting"
    
    return $false

  } # end try
  
} # end function Get-SpList