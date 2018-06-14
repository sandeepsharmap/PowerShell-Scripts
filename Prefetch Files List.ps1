<#

.SYNOPSIS
    A script to get Prefetch files listing.

.FUNCTION

Author: Sandeep Sharma P
Email : 
Date  : 

.DESCRIPTION

What are Prefetch Files?
Prefetch files are great artifacts for forensic investigators trying to analyze applications that have been run on a system. 
Windows creates a prefetch file when an application is run from a particular location for the very first time. 
This is used to help speed up the loading of applications.
For investigators, these files contain some valuable data on a user’s application history on a computer.

Why are Prefetch Files Important to Your Digital Forensics Investigation?

Evidence of program execution can be a valuable resource for forensic investigators. 
They can prove that a suspect ran a program like CCleaner to cover up any potential wrongdoing. 
If the program has since been deleted, a prefetch file may still exist on the system to provide evidence of execution. 
Another valuable use for prefetch files is in malware investigations which can assist examiners in determining when a malicious program was run. 
Combining this with some basic timeline analysis, investigators can identify any additional malicious files that were downloaded or created on the system, and help determine the root cause of an incident.

    
.EXAMPLE
    

.NOTES
    
#>
$pfconf = (Get-ItemProperty "hklm:\system\currentcontrolset\control\session manager\memory management\prefetchparameters").EnablePrefetcher 
Switch -Regex ($pfconf) {
    "[1-3]" {
        $o = "" | Select-Object FullName, CreationTimeUtc, LastAccessTimeUtc, LastWriteTimeUtc
        ls $env:windir\Prefetch\*.pf | % {
            $o.FullName = $_.FullName;
            $o.CreationTimeUtc = Get-Date($_.CreationTimeUtc) -format o;
            $o.LastAccesstimeUtc = Get-Date($_.LastAccessTimeUtc) -format o;
            $o.LastWriteTimeUtc = Get-Date($_.LastWriteTimeUtc) -format o;
            $o
        } | ConvertTo-Html -Fragment >> PSRecon\process\prefetch.html
    }
    default {
        echo "" >> PSRecon\process\prefetch.html
        echo "Prefetch not enabled on ${env:COMPUTERNAME}" >> PSRecon\process\prefetch.html
        echo "" >> PSRecon\process\prefetch.html
    }
}
#$prefetch = type PSRecon\process\prefetch.html