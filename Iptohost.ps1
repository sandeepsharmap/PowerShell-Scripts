<#

.SYNOPSIS
    A script to get Hostname from Iptohost.txt file placed in your desktop

.FUNCTION

Author: Sandeep Sharma P
Email : 
Date  : 

.DESCRIPTION

    

    
.EXAMPLE
    

.NOTES
    
#>

cls
# Clear All variables- Exclude Default
Get-Variable -Exclude PWD,*Preference | Remove-Variable -EA 0

#Create Empty Array
$Output= @()

# Get Input file
$InputFile = Get-content "C:\Users\$env:username\Desktop\Hosttoip.txt"
#$Addresses = get-content $InputFile 

foreach($ip in $InputFile){
       try {
                $HName = [System.Net.Dns]::GetHostByAddress("$ip").HostName
                $Output+= "$HName : $ip"
                Write-host "$HName : $ip" -ForegroundColor Green }

       catch {
                    if(Test-Connection -ComputerName $ip -Count 1 -ErrorAction SilentlyContinue){
                            $Output+= "$IP is reachble. But Could not find the Host Name"
                            Write-host "$IP is reachble. But Could not find the Host Name"-ForegroundColor Red
                    } 

                    else{
                            $Output+= "$IP is NOT reachable"
                            Write-host "$IP is NOT reachable"-ForegroundColor Red }
                }           
}

# Write Output to Desktop
$Output | Out-file "C:\Users\$env:username\Desktop\Iptohost_Result.txt"