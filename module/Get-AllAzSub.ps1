function Get-AllAzSub {

  try {
    
    New-Log -Level "INFO" -Message "get all subscription name"
    $getAllSub = (Get-AzSubscription -ErrorAction Stop).Name

    return $getAllSub
  
  }
  catch {
    
    New-Log -Level "ERROR" -Message "failed to get all subscription name"
    
    return $false

  } # end try
  
} # end function Get-AllAzSub