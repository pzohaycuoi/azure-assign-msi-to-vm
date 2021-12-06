function Check-FileExist {

  param (
    [Parameter(Mandatory)]
    [string]$FilePath
  )

  # check if the file exist and has the right extension
  if (Test-Path -Path $FilePath) {

    # Check if file extension is .csv
    if ([IO.Path]::GetExtension($FilePath) -eq ".csv") {

      New-Log -Level "INFO" -Message "File type is csv"

      return $true

    }
    else {

      New-Log -Level "ERROR" -Message "File type is not csv,"

      return $false

    } # end if ([IO.Path]::GetExtension($FilePath) -eq ".csv")

  }
  else {

    New-Log -Level "ERROR" -Message "Path to file not exist, aborting"

    return $false
  
  }  # end if (Test-Path -Path $FilePath)z

} # end function Check-FileExist