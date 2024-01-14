$ServerList_Path = '.\ServerList.csv'
$ServerList = Import-Csv -Path "$ServerList_Path" -Delimiter ','
$Export = [System.Collections.ArrayList]@()

foreach ($Server in $ServerList) {
    $ServerName = $Server.Name
    $LastStatus = $Server.$LastStatus
    $Connection = Test-Connection $Server.Name -Count 1

    if ($Connection.Status -eq "Success") {
        if ($LastStatus -eq "Success") {
            Write-Host "$ServerName is still online"
        }
        else {
            Write-Host "$ServerName is now online"
        }
    }
    else {
        if ($LastStatus -eq "Success") {
            Write-Host "$ServerName is now offline"
        }
    }
    $Server.LastStatus = $Connection.Status
    $Export.Add($Server)
}
$Export | Export-Csv -Path .\ServerList.csv -Delimiter ','
