param (
  [Parameter(Mandatory)]
  [string]$FilePath
)

# logging and result
$logPath = "$($scriptDir)\log\"
$resultPath = "$($scriptDir)\result\"
$logPath = Check-PathIsLinuxOrWin -FilePath $logPath
$resultPath = Check-PathIsLinuxOrWin -FilePath $resultPath
$logFile = New-Item -Path $logPath -Name "log-$(get-date -Format ddMMyyyy-hhmmss).txt" -Force
$resultFile = New-Item -Path $resultPath -Name "result-$(get-date -Format ddMMyyyy-hhmmss).csv" -Force

Start-Transcript -Path $logFile.FullName

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

            }
          }
          else {
            break
          }
        }
      }
      else {
        break  
      }
    }
  }
  else {
    break
  }
}
else {
  break
}

Stop-Transcript