<#

.SYNOPSIS
    A script to give the system complete information

.FUNCTION

Author: Sandeep Sharma P
Email : 
Date  : 

.DESCRIPTION

    

    
.EXAMPLE
    

.NOTES
    
#>



$ip = ((ipconfig | findstr [0-9].\.)[0]).Split()[-1]
$ComputerName = (gi env:\Computername).Value
$UserDirectory = (gi env:\userprofile).value
$User = (gi env:\USERNAME).value
$Date = Get-Date -format MM-dd-yyyy
$Time = Get-Date -Format H:mm:ss

Write-Host "Capturing Host Data : $ComputerName Address: $ip Date: $Date Time: $Time"

#Display IP config
ipconfig -all > $("C:\Users\$env:username\Desktop\"+ $ComputerName +"_IPcnfig.txt")

#Display currently-running tasks
tasklist /V > $("C:\Users\$env:username\Desktop\"+ $ComputerName +"_CurrentTask.txt")

# Display Listening Processes
netstat -ano | findstr -i listening > $("C:\Users\$env:username\Desktop\"+ $ComputerName +"_ListeningProcesses.txt")

# Display running services
net start > $("C:\Users\$env:username\Desktop\"+ $ComputerName +"_RunningServices.txt")

# Display currently Installed Software
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion, Publisher, InstallDate > $("C:\Users\$env:username\Desktop\"+ $ComputerName +"_CurrentlyInstalledSoftwares.txt")

# Get installed AV software
Get-WmiObject -Namespace root\SecurityCenter2 -Class AntiVirusProduct | Select-Object DisplayName > $("C:\Users\$env:username\Desktop\"+ $ComputerName +"_AVInstalled.txt")

# list documents
dir C:\Users\* -Recurse | Select Name, CreationTime, LastAccessTime, Attributes > $("C:\Users\$env:username\Desktop\"+ $ComputerName +"_DcoumentsList.txt")

# list downloaded files
dir C:\Users\*\Downloads\* -Recurse | Select Name, CreationTime, LastAccessTime, Attributes > $("C:\Users\$env:username\Desktop\"+ $ComputerName +"_DownloadsList.txt")

# list TEMP files
dir C:\Users\*\AppData\Local\Temp\* -Recurse | Select Name, CreationTime, LastAccessTime, Attributes > $("C:\Users\$env:username\Desktop\"+ $ComputerName +"_TEMPfiles.txt")

# list recently created Dir's
$todaysDate = Get-Date
ls C:\Users\*\*\* | Where-Object {$_.LastWriteTime -lt $todaysDate.AddDays(-30)} > $("C:\Users\$env:username\Desktop\"+ $ComputerName +"_RecentDirs.txt")



