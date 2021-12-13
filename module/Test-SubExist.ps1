function Test-SubExist {
  param (
    [Parameter(Mandatory)]
    [string]$SubscriptionName,

    [Parameter(Mandatory)]
    [psobject]$SubscriptionList
  )
  
  # check if the subscription name exist in the list
  
  $result = [PSCustomObject]@{}
  $result | Add-Member -NotePropertyName "SubscriptionName" -NotePropertyValue $SubscriptionName
  if ($SubscriptionList -contains $SubscriptionName) {
    $result | Add-Member -NotePropertyName "Result" -NotePropertyValue $true
    return $result
  }
  else {
    $result | Add-Member -NotePropertyName "Result" -NotePropertyValue $false
    return $result
  }
}