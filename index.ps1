$ServerList_Path = '.\ServerList.csv'
$ServerList = Import-Csv -Path "$ServerList_Path" -Delimiter ','
$Export = [System.Collections.ArrayList]@()

foreach ($Server in $ServerList) {
    $ServerName = $Server.Name
    $LastStatus = $Server.$LastStatus
    $Connection = Test-Connection $Server.Name -Count 1

    if ($Connection.Status -eq "Success") {
        Write-Host "$ServerName is online"
        $Server.LastStatus = $LastStatus
    }
    else {
        Write-Host "$ServerName is offline"
        $Server.LastStatus = $LastStatus
    }
    $Export.Add($Server)
}
$Export | Export-Csv -Path .\ServerList.csv -Delimiter ','
