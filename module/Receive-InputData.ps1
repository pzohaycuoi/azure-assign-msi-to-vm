function Receive-InputData {

  param (

    [Parameter(Mandatory)]
    [string]$Subscription,

    [Parameter(Mandatory)]
    [string]$ResourceGroup,

    [Parameter(Mandatory)]
    [string]$Region,

    [AllowEmptyString()]
    [string]$MsiName,

    [Parameter(Mandatory)]
    [string]$VmName

  )

  New-Log -Level "INFO" -Message "Convert input to Object"
  
  # Put input data into an object, passing this into other module
  $inputData = [PsCustomObject]@{  

    Subscription  = $Subscription
    ResourceGroup = $ResourceGroup
    Region        = $Region
    MsiName       = $MsiName
    VmName        = $VmName

  }

  return $inputData

} # end function Receive-InputData