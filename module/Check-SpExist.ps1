$scriptDir = $PSScriptRoot
. "$($scriptDir)\..\common\New-Log.ps1"

function Check-SpExist {

  param (
    [Parameter(Mandatory)]
    [psobject]$SpList,

    [Parameter(Mandatory)]
    [string]$SpCheck
  )
  
  New-Log -Level "INFO" -Message "Check if $($SpCheck) is exist"
  $spListDisplayName = $SpList.DisplayName
  $checkIfSpExist = $spListDisplayName -contains $SpCheck

  if ($checkIfSpExist -eq $false) {
  
    New-Log -Level "INFO" -Message "$($SpCheck) is exist"

    return $false

  }
  else {

    New-Log -Level "WARN" -Message "$($SpCheck) is not exist"
      
    return $true

  }

}