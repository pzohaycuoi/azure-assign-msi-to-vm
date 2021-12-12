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

# logging and result
$logPath = "$($scriptDir)\log\"
$resultPath = "$($scriptDir)\result\"
$logPath = Check-PathIsLinuxOrWin -FilePath $logPath
$resultPath = Check-PathIsLinuxOrWin -FilePath $resultPath
$logFile = New-Item -Path $logPath -Name "log-$(get-date -Format ddMMyyyy-hhmmss).log" -Force
$resultFile = New-Item -Path $resultPath -Name "result-$(get-date -Format ddMMyyyy-hhmmss).csv" -Force

Start-Transcript -Path $logFile.FullName

# Path to module and common folder
$modulePath = "$($scriptDir)\module\"
$commonPath = "$($scriptDir)\common\"
$modulePath = Check-PathIsLinuxOrWin -FilePath $modulePath
$commonPath = Check-PathIsLinuxOrWin -FilePath $commonPath
$moduleList = Get-ChildItem -Path $modulePath | Where-Object { $_.name -like "*.ps1" }
$commonModuleList = Get-ChildItem -Path $commonPath | Where-Object { $_.name -like "*.ps1" }

# foreach module in module folder, import it
foreach ($module in $moduleList) {

  . "$($module.FullName)"

} # end foreach ($module in $moduleList)

# foreach module in common folder, import it
foreach ($module in $commonModuleList) {

  . "$($module.FullName)"

} # end foreach ($module in $moduleList)

# check if path of the FilePath is valid
$checkFileExist = Check-FileExist -FilePath $FilePath -FileExtension ".csv"

if ($checkFileExist -eq $true) {

  
  # check if csv has all the required headers
  $reqCsvHeaderDataPath = "$($scriptDir)\Data\required-csv-header.txt"
  $checkCsvReqHeader = Check-CsvRequiredHeader -FilePath $FilePath -RequiredHeaderFile $reqCsvHeaderDataPath

  if ($checkCsvReqHeader -eq $true) {
      
    # if csv has the all the required header - get all the avail subscripition for checking
    $CsvData = Import-Csv -Path $FilePath
    $allSub = Get-AllAzSub
 
    # loop through each row in the csv file
    foreach ($row in $CsvData) {
         
      $subscription = $row.Subscription
      $msiResourceGroup = $row.MsiResourceGroup
      $region = $row.Region
      $msiname = $row.MsiName
      $vmResourceGroup = $row.VmResourceGroup
      $vmname = $row.VmName
 
      $checkSubExist = Check-SubExist -SubscriptionName $subscription -SubscriptionList $allSub

      # check if the provided sub is valid
      if ($checkSubExist -contains $true) {
 
        $getCurSub = Get-CurrentSub
 
        if ($getCurSub -eq $true) {
             
          # set the current cli sub to the target subscription
          if ($getCurSub -eq $subscription) {
               
            $setAzSub = Set-AzSub -SubscriptionName $subscription
 
            if ($setAzSub -eq $true) {
                 
              # check if the resource group exist

 
            } # end if ($setAzSub -eq $false)
 
          }
          else {
           
            break
 
          } # end if (-not ($getCurSub -eq $subscription))
 
        } # end if ($getCurSub -eq $false)
 
      }
      else {
 
        break
         
      } # end if (-not ($allSub -contains $subscription))
 
    } # end foreach ($row in $CsvData)

  }
  else {
    
    break

  } # end if ($checkCsvReqHeader -eq $true)

}
else {

  break

} # end if ($checkFileExist -eq $true)

Stop-Transcript