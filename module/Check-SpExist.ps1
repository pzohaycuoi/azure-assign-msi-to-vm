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
  
    New-Log -Level "WARN" -Message "$($SpCheck) is not exist"

    return $false

  }
  else {

    New-Log -Level "INFO" -Message "$($SpCheck) is exist"

    return $true

  } # end if ($checkIfSpExist -eq $false)

} # end function Check-SpExist