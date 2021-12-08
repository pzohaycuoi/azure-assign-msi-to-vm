function Check-FileExist {

  param (
    [Parameter(Mandatory)]
    [string]$FilePath,

    [Parameter(Mandatory)]
    [string]$FileExtension
  )

  # check if the file exist and has the right extension
  if (Test-Path -Path $FilePath) {

    New-Log -Level "INFO" -Message "File $($FilePath) exist"

    # Check if file extension is .csv
    if ([IO.Path]::GetExtension($FilePath) -eq $FileExtension) {

      New-Log -Level "INFO" -Message "File type is $($FileExtension)"
      return $true

    }
    else {

      New-Log -Level "ERROR" -Message "Failed: File type is not $($FileExtension)"
      return $false

    } # end if ([IO.Path]::GetExtension($FilePath) -eq $FileExtension)

  }
  else {

    New-Log -Level "ERROR" -Message "Failed: Path to file $($FilePath) not exist, aborting"
    return $false
  
  }  # end if (Test-Path -Path $FilePath)z

} # end function Check-FileExist