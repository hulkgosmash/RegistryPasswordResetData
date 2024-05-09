# Get a list of possible keys that contain Reset data
$listofusers = Get-ChildItem -Path 'HKLM:\SAM\SAM\Domains\Account\Users\' | Where-Object { $_.Name -notmatch 'name' }
# Iterate through each found user and print out the ResetData key if it exists.  
foreach ($user in $listofusers) {
    If (($user | Get-ItemProperty).ResetData) {
    [System.Text.Encoding]::Unicode.GetString([System.Byte[]]($user | Get-ItemProperty).ResetData) | 
    ConvertFrom-Json | Select-Object -ExpandProperty questions
    }
}
