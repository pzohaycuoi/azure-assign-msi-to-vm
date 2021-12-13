function Set-AzSub {
  param (
    [Parameter(Mandatory)]
    [string]$SubscriptionName
  )

  # Set cli subscription to the $SubscriptionName

  try {
    $result = [PSCustomObject]@{}
    $result | Add-Member -NotePropertyName "SubscriptionName" -NotePropertyValue $SubscriptionName
    Set-AzContext -Subscription $SubscriptionName -ErrorAction Stop | Out-Null
    $result | Add-Member -NotePropertyName "Result" -NotePropertyValue $true  
    return $result
  }
  catch {   
    $result | Add-Member -NotePropertyName "Log" -NotePropertyValue "Failed: $($_)"
    $result | Add-Member -NotePropertyName "Result" -NotePropertyValue $false
    return $result
  }
}