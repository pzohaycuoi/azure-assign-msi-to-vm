param (
  [Parameter(Mandatory)]
  [string]$FilePath
)

# import module Check-PathIsLinuxOrWin
# need to manually check because need to determine which type of path
if (Test-Path -Path $FilePath) {

  # Check if file extension is .csv
  if ([IO.Path]::GetExtension($FilePath) -eq ".csv") {

    # Import Csv file
    try {

      $importCsv = Import-Csv -path $FilePath -ErrorAction Stop
      New-Log -Level "INFO" -Message "Import Input Csv file success"

    }
    catch {

      New-Log -Level "ERROR" -Message $_.Exception

      Break

    } # end try

  }
  else {

    New-Log -Level "ERROR" -Message "File type is not csv,"

    Break

  } # end if ([IO.Path]::GetExtension($FilePath) -eq ".csv")

}
else {

  New-Log -Level "ERROR" -Message "Path to file not exist, aborting"

  Break

}  # end if (Test-Path -Path $FilePath)z

}

# Current path where the script run
$scriptDir = $PSScriptRoot
$modulePath = "$($scriptDir)\module\"
$commonPath = "$($scriptDir)\common\"

# foreach module in that folder, import it
foreach ($module in $moduleList) {

  . "$($module.FullName)"

} # end foreach ($module in $moduleList)

# foreach module in that folder, import it
foreach ($module in $commonModuleList) {

  . "$($module.FullName)"

} # end foreach ($module in $moduleList)

# Get all managed identities/service principals
$getSpList = Get-SpList

if ($getSpList -eq $false) {
  
  break

}
else {
  


}