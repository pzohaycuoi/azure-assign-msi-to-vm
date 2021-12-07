function Get-CurrentSub {
  
  # get current subsciption that the CLI is set to

  try {
    
    New-Log -Level "INFO" -Message "Get current subscription name"
    $subName = (Get-AzContext -ErrorAction Stop).Subscription.Name
    New-Log -Level "INFO" -Message "Current subscription name $($subName)"

    return $subName

  }
  catch {
    
    New-Log "ERROR" -Message "Failed to get current subscription name"

    return $false

  } # end try
  
} # end function Get-CurrentSub