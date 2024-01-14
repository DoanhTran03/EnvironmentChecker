$ServerList_Path = '.\ServerList.csv'
$ServerList = Import-Csv -Path "$ServerList_Path" -Delimiter ','

foreach ($Server in $ServerList) {
    $ServerName = $ServerName
    $Connection = Test-Connection -TargetName $Server.Name -Count 1

    if ($Connection.Status -eq "Success") {
        Write-Host "$ServerName is online"
    }
    else {
        Write-Host "$ServerName is offline"
    }
}