# Current path where the script run
$scriptDir = $PSScriptRoot

# need to manually check because need to determine which type of path
# if current path contain \ then it's Windows, / then it's Linux
# import module Test-PathIsLinuxOrWin
$getCurrentPath = (pwd).Path

if ($getCurrentPath -clike "*\*") {   
  $ChecKPathIsLinuxOrWinPath = "$($scriptDir)\common\Test-PathIsLinuxOrWin.ps1"
  . $ChecKPathIsLinuxOrWinPath
}
elseif ($getCurrentPath -clike "*/*") {
  $ChecKPathIsLinuxOrWinPath = "$($scriptDir)/common/Test-PathIsLinuxOrWin.ps1"
  . $CheckPathIsLinuxOrWinPath
}

# Path to module and common folder
$modulePath = "$($scriptDir)\module\"
$commonPath = "$($scriptDir)\common\"
$binPath = "$($scriptDir)\bin\"
$modulePath = Test-PathIsLinuxOrWin -FilePath $modulePath
$commonPath = Test-PathIsLinuxOrWin -FilePath $commonPath
$binPath = Test-PathIsLinuxOrWin -FilePath $binPath
$moduleList = Get-ChildItem -Path $modulePath.FilePath | Where-Object { $_.name -like "*.ps1" }
$commonModuleList = Get-ChildItem -Path $commonPath.FilePath | Where-Object { $_.name -like "*.ps1" }
$binModuleList = Get-ChildItem -Path $binPath.FilePath | Where-Object { $_.name -like "*.ps1" }

# foreach module in module folder, import it
foreach ($module in $moduleList) {
  . "$($module.FullName)"
}
# foreach module in common folder, import it
foreach ($module in $commonModuleList) {
  . "$($module.FullName)"
}
# foreach module in bin folder, import it
foreach ($module in $binModuleList) {
  . "$($module.FullName)"
}