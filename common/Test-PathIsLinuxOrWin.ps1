function Test-PathIsLinuxOrWin {
  param (
    [Parameter(Mandatory)]
    [string]$FilePath
  )

  # Check if path type is linux or windows then change $FilePath accordingly

  $getCurrentPath = (pwd).Path  
  
  if ($getCurrentPath -clike "*\*") {    
    $FilePath = $FilePath.Replace("/","\")
    return $FilePath
  } elseif ($getCurrentPath -clike "*/*") {
    $FilePath = $FilePath.Replace("\","/")
    return $FilePath
  } 
}