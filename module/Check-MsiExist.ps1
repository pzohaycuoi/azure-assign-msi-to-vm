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
    $result | Add-Member -NotePropertyName "MsiName" -NotePropertyValue $MsiName
  
    if ($msiNameInRg -contains $MsiName) {      
      $result | Add-Member -NotePropertyName "Result" -NotePropertyValue $true
      return $result
    }
    else {    
      $result | Add-Member -NotePropertyName "Log" -NotePropertyValue "Failed: Msi $($MsiName) not exist"
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