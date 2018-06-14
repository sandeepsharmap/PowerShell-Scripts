<#

.SYNOPSIS
    A script to get Hostname from Hosttoip.txt file placed in your desktop

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
$InputFile = 'Get-content "C:\Users\$env:username\Desktop\Hosttoip.txt'
$Names = get-content $InputFile

foreach($Name in $Names){
       try {
                $ip = (Test-Connection -ComputerName $Name -Count 1 -ErrorAction SilentlyContinue).IPV4Address.IPAddressToString
                $Output+= "$Name : $ip"
                Write-host "$Name : $ip" -ForegroundColor Green }

       catch {
                    $Output+= "$Name NOTound"
                    Write-host "$Name was not found."-ForegroundColor Red }           
}

#Write Output to Desktop
$Output | Out-file "C:\Users\$env:username\Desktop\Hosttoip_Result.txt"