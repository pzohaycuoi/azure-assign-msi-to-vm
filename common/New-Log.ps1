function New-Log {
  param (
    # level of the log
    [ValidateSet("INFO", "WARN", "ERROR")]
    [string]$Level = "INFO",

    # log message
    [Parameter(Mandatory)]
    [string]$Message,

    # Log file
    [Parameter(Mandatory)]
    [string]$LogFile
  )

  # Log message output to the console

  # get the time that function is executed
  $getExecTime = Get-Date -Format ddMMyyyy-hhmmss
  $messageLog = "$($getExecTime) - [$($Level)] - $($Message)"
  Write-Host -Message $messageLog
  Add-Content -Path $LogFile -Value $messageLog
}