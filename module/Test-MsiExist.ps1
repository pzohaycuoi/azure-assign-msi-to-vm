function Test-MsiExist {
  param (
    [Parameter(Mandatory)]
    [string]$ResourceGroup,

    [Parameter(Mandatory)]
    [string]$MsiName
  )

  # check if the provided MSI exist in the resource group
  try {
    $result = [PSCustomObject]@{}
    $result | Add-Member -NotePropertyName "MsiName" -NotePropertyValue $msiName
    $getMsi = Get-AzUserAssignedIdentity -ResourceGroupName $ResourceGroup -Name $MsiName -ErrorAction Stop
  
    if ($getMsi.Name -eq $MsiName) {      
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