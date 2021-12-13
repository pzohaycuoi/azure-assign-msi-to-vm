function Test-CsvRequiredHeader {  
  param (
    [Parameter(Mandatory)]
    [string]$FilePath,

    [Parameter(Mandatory)]
    [string]$RequiredHeaderFile
  )

  # check if file csv contains all required headers base on a text file

  $result = [PSCustomObject]@{}
  $result | Add-Member -NotePropertyName "FilePath" -NotePropertyValue $FilePath
  $requiredHeaders = Get-Content -Path $RequiredHeaderFile
  $result | Add-Member -NotePropertyName "RequiredHeaders" -NotePropertyValue $requiredHeaders
  $importCsv = Import-Csv -Path $FilePath
  $fileHeaders = $ImportCsv[0].PsObject.Properties.Name
  $result | Add-Member -NotePropertyName "FileHeaders" -NotePropertyValue $fileHeaders
  # check if csv's header contains all the required headers
  foreach ($header in $requiredHeaders) {
    if ($fileHeaders -contains $header) {
      return $true
    }
    else { 
      return $false
    }
  }
}