<#

.SYNOPSIS
    A script to test ping status for a IP subnet range

.FUNCTION

Author: Sandeep Sharma P
Email : 
Date  : 

.DESCRIPTION

    

    
.EXAMPLE
    

.NOTES
    
#>

$Output= @()

$IPArray = @()
$IPArray = 1..255 | %{"x.x.x.$_"}


for ($i=0;$i -lt 256 ;$i++) 
{
    $sIP = $IPArray[$i]

    if(Test-Connection $sIP -Count 1 -Quiet)
    {
        $Output+= "The Ping Status of $Server is UP |$(Get-Date)"
   	Write-Host "The Ping Status of $Server is UP |$(Get-Date)"
    }

    else
    {
        $Output+= "The Ping Status of $Server is Down |$(Get-Date)"
    	Write-Host "The Ping Status of $Server is Down |$(Get-Date)"
    }
}

#Write Output to Desktop
$Output | Out-file "C:\Users\$env:username\Desktop\PingStatus_Result.txt" 