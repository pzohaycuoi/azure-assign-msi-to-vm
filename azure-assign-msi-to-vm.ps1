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

  $reqCsvHeaderDataPath = "$($scriptDir)\Data\required-csv-header.txt"
  $checkCsvReqHeader = Check-CsvRequiredHeader -FilePath $FilePath -RequiredHeaderFile $reqCsvHeaderDataPath

  if ($checkCsvReqHeader -eq $false) {
      
    break

  }
  else {
      
    $CsvData = Import-Csv -Path $FilePath
    $allSub = Get-AllAzSub

    foreach ($row in $CsvData) {
        
      $subscription = $row.subsciprtion
      $msiResourceGroup = $row.msiresourcegroup
      $region = $row.region
      $msiname = $row.msiname
      $vmResourceGroup = $row.vmResourceGroup
      $vmname = $row.vmname

      if (-not ($allSub -contains $subscription)) {
          
        break

      }
      else {

        $getCurSub = Get-CurrentSub
        if ($getCurSub -eq $false) {
            
          break

        }
        else {
            
          if (-not ($getCurSub -eq $subscription)) {
              
            $setAzSub = Set-AzSub -SubscriptionName $subscription

            if ($setAzSub -eq $false) {
                
              break

            } # end if ($setAzSub -eq $false)

          } # end if (-not ($getCurSub -eq $subscription))



        } # end if ($getCurSub -eq $false)
          
      } # end if (-not ($allSub -contains $subscription))

    } # end foreach ($row in $CsvData)

  } # end if ($checkCsvReqHeader -eq $false)

} # end if ($checkFileExist -eq $false)

