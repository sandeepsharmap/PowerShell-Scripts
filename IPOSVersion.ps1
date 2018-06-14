<#

.SYNOPSIS
    A script to get OS version from given IP.

.FUNCTION

Author: Sandeep Sharma P
Email : 
Date  : 

.DESCRIPTION

    TTL value tells us the OS Version (in assumption of  no explict change in TTL value)

    
.EXAMPLE
    

.NOTES
    
#>

$Output= @()

$IPArray = @()
$IPArray = 1..255 | %{"10.1.33.$_"}


for ($i=0;$i -lt 256 ;$i++) 
{
    $sIP = $IPArray[$i]

    if(Test-Connection $sIP -Count 1 -Quiet)
    {
        $TTL=(Test-Connection "$sIP"  -Count 1).ResponseTimeToLive

        if($TTL -eq "64" -OR $TTL -eq "255"){
				$OS = "LINUX" }

        elseif($TTL -eq "32" -OR $TTL -eq "128"){
                $OS = "Windows"}

		else {
				$OS = "Non-Linux" }

        Write-Host "$sIP is $OS"
        $Output+= "$sIP is LINUX Machine"

    }

    else
    {
        Write-Host "$sIP is not reachable"
        $Output+= "$sIP is NOT Rechable"
    }
}

#Write Output to Desktop
$Output | Out-file "C:\Users\$env:username\Desktop\IPOSVersion.txt" 