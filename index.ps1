#Import modules
Import-Module ".\Send-MailKitMessage\MailKitMessage.psm1"

$ServerList_Path = '.\ServerList.csv'
$ServerList = Import-Csv -Path "$ServerList_Path" -Delimiter ','
$Export = [System.Collections.ArrayList]@()

#Get credential from local .Net object saved in xml
$Credential = Import-Clixml -Path "C:\Scripts\EmailCred\outlook.xml"

foreach ($Server in $ServerList) {
    $ServerName = $Server.Name
    $LastStatus = $Server.LastStatus

    $Connection = Test-Connection $Server.Name -Count 1
    $Time = Get-Date
    $Alert = $false
    $Subject = ""
    $Body = ""

    if ($Connection.Status -eq "Success") {
        if ($LastStatus -eq "Success") {
            Write-Host "$ServerName is still online"
            $Server.OnFor = ((Get-Date -Date $Time) - (Get-Date -Date $Server.OnSince)).Minutes
            $LastAlertFor = ((Get-Date -Date $Time) - (Get-Date -Date $Server.LastOnAlert)).Minutes
            $OnFor = $Server.OnFor
            $OnSince = $Server.OnSince
            if (($Server.OnFor -ge 1) -and ($LastAlertFor -ge 2)) {
                $Alert = $true
                $Subject = "Computer $ServerName Running Time Alert"
                $Body = "<h3>The Computer $ServerName has been running for $OnFor minutes</h3> <br>
                             The Computer $ServerName has been running since $OnSince minutes"
                $Server.LastOnAlert = $Time
            }
        }
        else {
            $Alert = $true
            $Subject = "Computer $ServerName Online Alert"
            $Body = "<h3>Computer $ServerName is now online!</h3> <br>
                     Computer $ServerName is online at $Time"
            $Server.OnSince = $Time
            $Server.LastOnAlert = $Time
        }
    }
    else 
    {
        if ($LastStatus -eq "Success") {
            $Alert = $true
            $Subject = "Computer $ServerName Offline Alert"
            $Body = "<h3>Computer $ServerName is now offline!</h3><br>
                     Computer is offline at $Time"
        }
    }

    if($Alert) {
        Send-MailKitMessage -From "gofortest79@outlook.com" -To "gofortest79@outlook.com" -Subject $Subject -Body $Body -BodyAsHTML -SMTPServer "smtp-mail.outlook.com" -Port 587 -Credential $Credential -Attachment "C:\Scripts\Images\companylogo.jpg"
    }

    $Server.LastStatus = $Connection.Status
    $Server.LastCheckIn = $Time
    [void]$Export.Add($Server)
}
$Export | Export-Csv -Path $ServerList_Path -Delimiter ',' -NoTypeInformation