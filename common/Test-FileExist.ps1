function Test-FileExist {
  param (
    [Parameter(Mandatory)]
    [string]$FilePath,

    [Parameter(Mandatory)]
    [string]$FileExtension
  )

  # check if the file exist and has the right extension

  $result = [PSCustomObject]@{}
  $result | Add-Member -NotePropertyName "FilePath" -NotePropertyValue $FilePath

  if (Test-Path -Path $FilePath) {
    # Check if file extension is .csv
    if ([IO.Path]::GetExtension($FilePath) -eq $FileExtension) {
      $result | Add-Member -NotePropertyName "Log" -NotePropertyValue "Success: File path $($FilePath) exist, file extension is $($FileExtension)"
      $result | Add-Member -NotePropertyName "Result" -NotePropertyValue $true
      return $result
    }
    else {
      $result | Add-Member -NotePropertyName "Log" -NotePropertyValue "Failed: File extension is not $($FileExtension)"
      $result | Add-Member -NotePropertyName "Result" -NotePropertyValue $false
      return $result
    }
  }
  else {
    $result | Add-Member -NotePropertyName "Log" -NotePropertyValue "Failed: File path $($FilePath) not exist"
    $result | Add-Member -NotePropertyName "Result" -NotePropertyValue $false
    return $result
  }
}