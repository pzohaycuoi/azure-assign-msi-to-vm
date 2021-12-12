function Check-MsiExist {
  param (
    [Parameter(Mandatory)]
    [string]$ResourceGroup,

    [Parameter(Mandatory)]
    [string]$MsiName
  )

  # check if the provided MSI exist in the resource group
  try {
    $result = [PSCustomObject]@{}
    $getMsi = Get-AzUserAssignedIdentity -ResourceGroupName $ResourceGroup -Name $MsiName -ErrorAction Stop
    $result | Add-Member -NotePropertyName "MsiName" -NotePropertyValue $msiNameInRg
  
    if ($getMsi.Name -contains $MsiName) {      
      $result | Add-Member -NotePropertyName "Result" -NotePropertyValue $true
      return $result
    }
    else {    
      $result | Add-Member -NotePropertyName "Log" -NotePropertyValue "Failed: Msi $($msiNameInRg) not exist"
      $result | Add-Member -NotePropertyName "Result" -NotePropertyValue $false
      return $result
    }
  }
  catch {    
    $result | Add-Member -NotePropertyName "Log" -NotePropertyValue "Failed: $($_)"
    $result | Add-Member -NotePropertyName "Result" -NotePropertyValue $false
    return $result
  }
}