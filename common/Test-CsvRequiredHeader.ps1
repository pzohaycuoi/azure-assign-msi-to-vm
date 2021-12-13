function Test-CsvRequiredHeader {  
  param (
    [Parameter(Mandatory)]
    [string]$FilePath,

    [Parameter(Mandatory)]
    [string]$RequiredHeaderFile
  )

  # check if file csv contains all required headers base on a text file

  $result = [PSCustomObject]@{}
  $requiredHeaders = Get-Content -Path $RequiredHeaderFile
  $importCsv = Import-Csv -Path $FilePath
  $fileHeaders = $ImportCsv[0].PsObject.Properties.Name
  $result | Add-Member -NotePropertyName "FilePath" -NotePropertyValue $FilePath
  $result | Add-Member -NotePropertyName "RequiredHeaders" -NotePropertyValue $requiredHeaders
  $result | Add-Member -NotePropertyName "FileHeaders" -NotePropertyValue $fileHeaders
  $headerIncluded = @()
  $headerNotIncluded = @()
  
  # check if csv's header contains all the required headers
  foreach ($header in $requiredHeaders) {
    if ($fileHeaders -contains $header) {
      $headerIncluded += $header
    }
    else { 
      $headerNotIncluded += $header
    }
  }

  $result | Add-Member -NotePropertyName "HeaderIncluded" -NotePropertyValue $headerIncluded
  $result | Add-Member -NotePropertyName "HeaderNotIncluded" -NotePropertyValue $headerNotIncluded
  return $result
}