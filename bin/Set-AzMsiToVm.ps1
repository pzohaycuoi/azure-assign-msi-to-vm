function Set-AzMsiToVm {
  param (
    [Parameter(Mandatory)]
    [string]$FilePath
  )

  # logging and result
  $logPath = "$($scriptDir)\log\"
  $resultPath = "$($scriptDir)\result\"
  $logPath = Test-PathIsLinuxOrWin -FilePath $logPath
  $resultPath = Test-PathIsLinuxOrWin -FilePath $resultPath
  $logFile = New-Item -Path $logPath.FilePath -Name "log-$(get-date -Format ddMMyyyy-hhmmss).log" -Force
  $resultFile = New-Item -Path $resultPath.FilePath -Name "result-$(get-date -Format ddMMyyyy-hhmmss).csv" -Force

  # check if path of the FilePath is valid
  New-Log -Level "INFO" -Message "Check if $($FilePath) exist and extension is .csv" -LogFile $logFile
  $checkInputFileExist = Test-FileExist -FilePath $FilePath -FileExtension ".csv"
  if ($checkInputFileExist.Result -eq $true) {
    New-Log -Level "INFO" -Message $checkInputFileExist.Log -LogFile $logFile
    # check if csv has all the required headers
    $reqCsvHeaderFilePath = "$($scriptDir)\data\required-csv-header.txt"
    $reqCsvHeaderFilePath = Test-PathIsLinuxOrWin -FilePath $reqCsvHeaderFilePath
    New-Log -Level "INFO" -Message "Check if $($reqCsvHeaderFilePath.FilePath) exist and extension is .txt" -LogFile $logFile
    $checkCsvReqHeaderFileExist = Test-FileExist -FilePath $reqCsvHeaderFilePath.FilePath -FileExtension ".txt"
    if ($checkCsvReqHeaderFileExist.Result -eq $true) {
      New-Log -Level "INFO" -Message $checkCsvReqHeaderFileExist.Log -LogFile $logFile
      $checkCsvReqHeader = Test-CsvRequiredHeader -FilePath $FilePath -RequiredHeaderFile $reqCsvHeaderFilePath.FilePath
    }
    else {
      New-Log -Level "ERROR" -Message $checkCsvReqHeaderFileExist.Log -LogFile $logFile
      break
    }    
  }
  else {
    New-Log -Level "ERROR" -Message $checkInputFileExist.Log -LogFile $logFile
    break
  }
}
