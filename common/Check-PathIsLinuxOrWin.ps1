function Check-PathIsLinuxOrWin {

  param (
    [Parameter(Mandatory)]
    [string]$FilePath
  )

  # Check if path type is linux or windows then change $FilePath accordingly

  $getCurrentPath = (pwd).Path

  # if current path contain \ then it's Windows, / then it's Linux
  if ($getCurrentPath -clike "*\*") {
    
    $FilePath = $FilePath.Replace("/","\")
    return $FilePath

  } elseif ($getCurrentPath -clike "*/*") {

    $FilePath = $FilePath.Replace("\","/")
    return $FilePath

  } # end if ($getCurrentPath -clike "*\*")
  
} # end function Check-PathIsLinuxOrWin