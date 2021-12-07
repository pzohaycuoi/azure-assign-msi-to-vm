function Check-CsvRequiredHeader {
  
  param (
    [Parameter(Mandatory)]
    [string]$FilePath,

    [Parameter(Mandatory)]
    [string]$RequiredHeaderFile
  )

  $requiredHeaders = Get-Content -Path $RequiredHeaderFile
  $importCsv = Import-Csv -Path $FilePath
  $CsvHeader = $ImportCsv[0].PsObject.Properties.Name

  # check if csv's header contains all the required headers
  foreach ($header in $requiredHeaders) {

    if (-not($CsvHeader -contains $header)) {

      New-Log -Level "ERROR" -Message "CSV's header doesn't contain required header"

      return $false

    }
    else { 
      
      New-Log -Level "INFO" -Message "CSV's header contains all required header"

      return $true

    } # end if (-not($CsvHeader -contains $header))

  } # end foreach ($header in $requiredHeaders)

} # end function Check-CsvRequiredHeader