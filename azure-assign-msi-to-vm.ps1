param (
  [Parameter(Mandatory)]
  [string]$FilePath
)

# Current path where the script run
$scriptDir = $PSScriptRoot

# need to manually check because need to determine which type of path
# if current path contain \ then it's Windows, / then it's Linux
# import module Check-PathIsLinuxOrWin
$getCurrentPath = (pwd).Path

if ($getCurrentPath -clike "*\*") {
    
  $ChecKPathIsLinuxOrWinPath = "$($scriptDir)\common\Check-PathIsLinuxOrWin.ps1"
  . $ChecKPathIsLinuxOrWinPath

}
elseif ($getCurrentPath -clike "*/*") {

  $ChecKPathIsLinuxOrWinPath = "$($scriptDir)/common/Check-PathIsLinuxOrWin.ps1"
  . $CheckPathIsLinuxOrWinPath

}

# Path to module and common folder
$modulePath = "$($scriptDir)\module\"
$commonPath = "$($scriptDir)\common\"
$modulePath = Check-PathIsLinuxOrWin -FilePath $modulePath
$commonPath = Check-PathIsLinuxOrWin -FilePath $commonPath

# foreach module in module folder, import it
foreach ($module in $moduleList) {

  . "$($module.FullName)"

} # end foreach ($module in $moduleList)

# foreach module in common folder, import it
foreach ($module in $commonModuleList) {

  . "$($module.FullName)"

} # end foreach ($module in $moduleList)

# check if path of the FilePath is valid
$checkFileExist = Check-FileExist -FilePath $FilePath

if ($checkFileExist -eq $false) {

  break

}
else {

  # Get all managed identities/service principals
  $getSpList = Get-SpList

  if ($getSpList -eq $false) {

    break

  }
  else {
  
    $importCsv = Import-Csv -Path $FilePath

  } # end if ($getSpList -eq $false)

} # end if ($checkFileExist -eq $false)

