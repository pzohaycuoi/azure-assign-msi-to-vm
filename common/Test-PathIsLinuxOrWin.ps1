function Test-PathIsLinuxOrWin {
  param (
    [Parameter(Mandatory)]
    [string]$FilePath
  )

  # Check if path type is linux or windows then change $FilePath accordingly
  
  $result = [PSCustomObject]@{}
  $getCurrentPath = (pwd).Path  
  
  if ($getCurrentPath -clike "*\*") {    
    $FilePath = $FilePath.Replace("/","\")
    $result | Add-Member -NotePropertyName "FilePath" -NotePropertyValue $FilePath
    $result | Add-Member -NotePropertyName "OS" -NotePropertyValue "Windows"
    return $result
  } elseif ($getCurrentPath -clike "*/*") {
    $FilePath = $FilePath.Replace("\","/")
    $result | Add-Member -NotePropertyName "FilePath" -NotePropertyValue $FilePath
    $result | Add-Member -NotePropertyName "OS" -NotePropertyValue "Linux"
    return $result
  } 
}