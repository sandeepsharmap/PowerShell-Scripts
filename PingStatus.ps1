<#

.SYNOPSIS
    A script to check PING status of PingStatus.txt file placed in your desktop

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
$Input = Get-content "C:\Users\$env:username\Desktop\PingStatus.txt"

foreach ($Server in $Input)
{
  if (Test-Connection -ComputerName $Server -Count 1 -ErrorAction SilentlyContinue)
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