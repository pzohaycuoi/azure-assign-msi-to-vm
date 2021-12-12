function Get-AllAzSub {

  # get all the subscription the current account has access to
  try {  
    $result = [PSCustomObject]@{}
    $getAllSub = (Get-AzSubscription -ErrorAction Stop).Name
    $result | Add-Member -NotePropertyName "SubscriptionList" -NotePropertyValue $getAllSub
    $result | Add-Member -NotePropertyName "Result" -NotePropertyValue $true
    return $result
  }
  catch {
    $result | Add-Member -NotePropertyName "Log" -NotePropertyValue "Failed: $($_)"
    $result | Add-Member -NotePropertyName "Result" -NotePropertyValue $false
    return $result
  }
}