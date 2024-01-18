
# Environment Checker
A Powershell script that helps you automate checking status of enviroment task with email notification feature. 

It provides a quick way to inspect the environment status and ensure that every server/computer is operating correctly in the environment

## Demo
Online notification:

![image](https://github.com/DoanhTran03/EnvironmentChecker/assets/103083272/0d99626f-267c-4c5f-a669-6ffcfc39702f)

Running time notification:

![image](https://github.com/DoanhTran03/EnvironmentChecker/assets/103083272/0195cfe2-c237-4a1b-bd9a-7aa0ae91d2d7)

Offline notification:

![image](https://github.com/DoanhTran03/EnvironmentChecker/assets/103083272/0b240dac-cda7-4691-b047-5be92ab7af5d)
## Technology
* Powershell (v7)
* Task Scheduler
* CSV (comma-separated values) file
## Prerequisite
* Send-MailKitMessage module (from https://github.com/DoanhTran03/Send-MailKitMessage.git)


## Installation
1. Clone the repository
```
https://github.com/DoanhTran03/EnvironmentChecker.git
```
2. Change path to location resource in index.ps1 if neccessary 
Ex: Credential, Attachment

3. Create task scheduler to automate task of environment checking and add following code as script
```
pwsh -file path-to-the-index.ps1
```

## #Reference

Programming, J. (2022, April 4). PowerShell Tutorials : Environment Checker (beginner project). YouTube. https://www.youtube.com/watch?v=aBV4gmdcpjc&t=2635s 

Sdwheeler. (n.d.). Test-connection (microsoft.powershell.management) - powershell. (Microsoft.PowerShell.Management) - PowerShell | Microsoft Learn. https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-connection?view=powershell-7.4 
