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

    if ($CsvHeader -contains $header) {

      New-Log -Level "INFO" -Message "CSV's header contains all required headers"
      return $true

    }
    else { 
      
      New-Log -Level "ERROR" -Message "Failed: CSV's header doesn't contain required headers"
      return $false

    } # end if (-not($CsvHeader -contains $header))

  } # end foreach ($header in $requiredHeaders)

} # end function Check-CsvRequiredHeader