# Create a new powershell with the same environment and elevate it
# return the exit code from the process
function Request-AdministrativeRights
{
    $process = Start-Process -WorkingDirectory (Get-Location) -FilePath "PowerShell" -verb runas -Wait;
    return $process.ExitCode
}

# shamelessly stolen from https://stapp.space/sudo-under-windows/
# added !! support
function sudo  
{
    if ($args -eq "!!") {
        $args = (Get-History -Count 1).ToString()
    }
    $file, [string]$arguments = $args;
    $psi = new-object System.Diagnostics.ProcessStartInfo $file;
    $psi.Arguments = $arguments;
    $psi.Verb = "runas";
    $psi.WorkingDirectory = get-location;
    [System.Diagnostics.Process]::Start($psi);
}

set-alias su Request-AdministrativeRights;
set-alias rqAdmin Request-AdministrativeRights;
Export-ModuleMember Request-AdministrativeRights
Export-ModuleMember sudo
Export-ModuleMember -Alias su
Export-ModuleMember -Alias rqAdmin