function New-Log {
  
  param (
    # level of the log
    [ValidateSet("INFO", "WARN", "ERROR")]
    [string]$Level = "INFO",

    # log message
    [Parameter(Mandatory)]
    [string]$Message
  )

  # get the time that function is executed
  $getExecTime = Get-Date -Format ddMMyyyy-hhmmss
  $messageLog = "$($getExecTime) - [$($Level)] - $($Message)"
  Write-Host $messageLog
  
} # end function New-Log