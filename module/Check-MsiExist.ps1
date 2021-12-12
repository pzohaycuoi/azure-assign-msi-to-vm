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
    $msiInResourceGroup = Get-AzUserAssignedIdentity -ResourceGroupName $ResourceGroup -ErrorAction Stop
    $msiNameInRg = $msiInResourceGroup.name
    $result | Add-Member -NotePropertyName "MsiName" -NotePropertyValue $msiNameInRg
  
    if ($msiNameInRg -contains $MsiName) {      
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
    $result | Add-Member -NotePropertyName "Log" -NotePropertyValue $_
    $result | Add-Member -NotePropertyName "Result" -NotePropertyValue $false
    return $result
  }
}