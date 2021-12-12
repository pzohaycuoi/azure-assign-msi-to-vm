function Get-CurrentSub {
  
  # get current subsciption that the CLI is set to
  try {
    $result = [PSCustomObject]@{}
    $subName = (Get-AzContext -ErrorAction Stop).Subscription.Name
    $result | Add-Member -NotePropertyName "CurrentSubscriptionName" -NotePropertyValue $subName
    $result | Add-Member -NotePropertyName "Result" -NotePropertyValue $true
    return $result
  }
  catch {
    $result | Add-Member -NotePropertyName "Log" -NotePropertyValue "Failed: $($_)"
    $result | Add-Member -NotePropertyName "Result" -NotePropertyValue $false
    return $result
  }
}