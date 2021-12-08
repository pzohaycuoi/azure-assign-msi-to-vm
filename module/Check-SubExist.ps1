function Check-SubExist {

  param (
      [Parameter(Mandatory)]
      [string]$SubscriptionName,

      [Parameter(Mandatory)]
      [psobject]$SubscriptionList
  )
  
  # check if the subscription name exist in the list
  if ($SubscriptionList -contains $SubscriptionName) {
    
    New-Log -Level "INFO" -Message "subscription $($SubscriptionName) exist"
    return $true

  } else {
    
    New-Log -Level "ERROR" -Message  "Failed: $($SubscriptionName) is not exist"
    return $false

  } # end if ($SubscriptionList -contains $SubscriptionName)

} # end function Check-SubExist