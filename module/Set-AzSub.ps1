function Set-AzSub {
  
  param (
      [Parameter(Mandatory)]
      [string]$SubscriptionName
  )

  try {
    
    New-Log -Level "INFO" -Message "Select Azure subscription $($SubscriptionName)"
    Set-AzContext -Subscription $SubscriptionName -ErrorAction Stop

    return $true

  }
  catch {
    
    New-Log -Level "ERROR" -Message "Failed to select Azure subscription $($SubscriptionName)"

    return $false

  } # end try
  
} # end function Set-AzSub