$scriptDir = $PSScriptRoot
. "$($scriptDir)\New-Log.ps1"

function Check-FileExist {
 
  param (
    [Parameter(Mandatory)]
    [string]
    $FilePath
  )

  # check if the file exist and has the right extension
  if (Test-Path -Path $FilePath) {

    # Check if file extension is .csv
    if ([IO.Path]::GetExtension($FilePath) -eq ".csv") {

      # Import Csv file
      try {

        $importCsv = Import-Csv -path $FilePath -ErrorAction Stop
        New-Log -Level "INFO" -Message "Import Input Csv file success"

      }
      catch {

        New-Log -Level "ERROR" -Message $_.Exception

        Break

      } # end try

    }
    else {

      New-Log -Level "ERROR" -Message "File type is not csv,"

      Break

    } # end if ([IO.Path]::GetExtension($FilePath) -eq ".csv")

  }
  else {

    New-Log -Level "ERROR" -Message "Path to file not exist, aborting"

    Break
  
  }  # end if (Test-Path -Path $FilePath)z

}