function Set-AzSub {
  
  param (
    [Parameter(Mandatory)]
    [string]$SubscriptionName
  )

  # Set cli subscription to the $SubscriptioknName

  try {
    
    New-Log -Level "INFO" -Message "Switch to Azure subscription: $($SubscriptionName)"
    Set-AzContext -Subscription $SubscriptionName -ErrorAction Stop
    return $true

  }
  catch {
    
    New-Log -Level "ERROR" -Message "Failed: select Azure subscription $($SubscriptionName)"
    return $false

  } # end try
  
} # end function Set-AzSub