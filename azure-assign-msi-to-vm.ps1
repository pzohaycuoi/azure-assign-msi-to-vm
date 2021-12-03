param (
  [Parameter(Mandatory)]
  [string]$FilePath
)

# Current path where the script run
$scriptDir = $PSScriptRoot
$modulePath = "$($scriptDir)\module\"
$commonPath = "$($scriptDir)\common\"

# foreach module in that folder, import it
foreach ($module in $moduleList) {

  . "$($module.FullName)"

} # end foreach ($module in $moduleList)

# foreach module in that folder, import it
foreach ($module in $commonModuleList) {

  . "$($module.FullName)"

} # end foreach ($module in $moduleList)

# Get all managed identities/service principals
$servicePrincipalList = Get-AzADServicePrincipal