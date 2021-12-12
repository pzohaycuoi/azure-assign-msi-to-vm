function Test-ResourceGroupExit {
  param (
    [Parameter(Mandatory)]
    [string]$ResourceGroupName
  )
  
  # check if resource group exist
  try {
    $result = [PSCustomObject]@{}
    $result | Add-Member -NotePropertyName "ResourceGroupName" -NotePropertyValue $ResourceGroupName
    $getRg = Get-AzResourceGroup -Name $ResourceGroupName -ErrorAction Stop

    if ($getRg.ResourceGroupName -eq $ResourceGroupName) {      
      $result | Add-Member -NotePropertyName "Result" -NotePropertyValue $true
      return $result
    }
  }
  catch {
    $result | Add-Member -NotePropertyName "Log" -NotePropertyValue "Failed: $($_)"
    $result | Add-Member -NotePropertyName "Result" -NotePropertyValue $false
    return $result
  }
}