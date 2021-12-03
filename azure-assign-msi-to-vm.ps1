param (
    [Parameter(Mandatory)]
    [string]
    $FilePath
)

# Current path where the script run
$scriptDir = $PSScriptRoot
$commonPath = "$($scriptDir)\common\"

# foreach module in that folder, import it
foreach ($module in $commonModuleList) {

  . "$($module.FullName)"

} # end foreach ($module in $moduleList)

