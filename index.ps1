$ServerList_Path = '.\ServerList.csv'
$ServerList = Import-Csv -Path "$ServerList_Path" -Delimiter ','
$Export = [System.Collections.ArrayList]@()

foreach ($Server in $ServerList) {
    $ServerName = $Server.Name
    $LastStatus = $Server.LastStatus

    $Connection = Test-Connection $Server.Name -Count 1
    $Time = Get-Date

    if ($Connection.Status -eq "Success") {
        if ($LastStatus -eq "Success") {
            Write-Host "$ServerName is still online"
            $Server.OnFor = ((Get-Date -Date $Time) - (Get-Date -Date $Server.OnSince)).Minutes
            $LastAlertFor = ((Get-Date -Date $Time) - (Get-Date -Date $Server.LastOnAlert)).Minutes
            $OnFor = $Server.OnFor
            if (($Server.OnFor -ge 1) -and ($LastAlertFor -ge 2)) {
                Write-Output "The Computer has been running for $OnFor minutes"
                Write-Output "It is no on alert for $LastAlertFor minutes"
                $Server.LastOnAlert = $Time
            }
        }
        else {
            Write-Host "$ServerName is now online"
            $Server.OnSince = $Time
            $Server.LastOnAlert = $Time
        }
    }
    else 
    {
        if ($LastStatus -eq "Success") {
            Write-Host "$ServerName is now offline"
        }
    }
    $Server.LastStatus = $Connection.Status
    $Server.LastCheckIn = $Time
    [void]$Export.Add($Server)
}
$Export | Export-Csv -Path $ServerList_Path -Delimiter ',' -NoTypeInformation