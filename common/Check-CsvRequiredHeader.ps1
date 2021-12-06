$scriptDir = $PSScriptRoot
. "$($scriptDir)\New-Log.ps1"

function Check-CsvRequiredHeader {
  
  param (
    [Parameter(Mandatory)]
    [string]$FilePath,

    [Parameter(Mandatory)]
    [string]$RequiredHeaderFile
  )

  $getRequiredHeader = Get-Content -Path $RequiredHeaderFile
  $importCsv = Import-Csv -Path $FilePath
  $CsvHeader = $ImportCsv[0].PsObject.Properties.Name

  foreach ($header in $getRequiredHeader) {

    if (-not($CsvHeader -contains $header)) {

      New-Log -Level "ERROR" -Message "CSV's header doesn't contain required header"

      return $false

    }
    else { 
      
      New-Log -Level "INFO" -Message "CSV's header contains all required header"

      return $true

    }

  }

}