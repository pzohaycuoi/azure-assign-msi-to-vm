$scriptDir = $PSScriptRoot
. "$($scriptDir)\..\common\New-Log.ps1"

function Check-SpExist {

  param (
    [Parameter(Mandatory)]
    [psobject]$SpList,

    [Parameter(Mandatory)]
    [string]$SpCheck
  )
  
  $spListDisplayName = $SpList.DisplayName
  $checkIfSpExist = $spListDisplayName -contains $SpCheck

  if ($checkIfSpExist -eq $false) {
      
    return $false

  }
  else {
      
    return $true

  }

}