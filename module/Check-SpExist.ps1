$scriptDir = $PSScriptRoot
. "$($scriptDir)\..\common\New-Log.ps1"

function Check-SpExist {

  param (
      [Parameter(Mandatory)]
      [psobject]$SpList
  )
  
  # loop through object array and check if sp exist
  foreach ($sp in $SpList) {
    
    $spDisplayName = $sp.DisplayName
    $checkIfSpExist = $SpList | Where { $_.DisplayName -eq $spDisplayName }

    if ($checkIfSpExist -eq $null) {
      
      return $false

    } else {
      
      return $true

    }

  }

}