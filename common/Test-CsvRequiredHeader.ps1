function Test-CsvRequiredHeader {  
  param (
    [Parameter(Mandatory)]
    [string]$FilePath,

    [Parameter(Mandatory)]
    [string]$RequiredHeaderFile
  )

  # check if file csv contains all required headers base on a text file

  $requiredHeaders = Get-Content -Path $RequiredHeaderFile
  $importCsv = Import-Csv -Path $FilePath
  $CsvHeader = $ImportCsv[0].PsObject.Properties.Name

  # check if csv's header contains all the required headers
  foreach ($header in $requiredHeaders) {
    if ($CsvHeader -contains $header) {
      return $true
    }
    else { 
      return $false
    }
  }
}