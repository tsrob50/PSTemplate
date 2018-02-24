<#
.SYNOPSIS
  <Overview of script>
.DESCRIPTION
  <Brief description of script>
.PARAMETER <Parameter_Name>
  <Brief description of parameter input required. Repeat this attribute if required>
.INPUTS
  <Inputs if any, otherwise state None>
.OUTPUTS
  The script log file stored in \log in the current directory
.NOTES
  Version:        1.0
  Author:         <Name>
  Creation Date:  <Date>
  Purpose/Change: Initial script development
.EXAMPLE
  <Example explanation goes here>
  
  <Example goes here. Repeat this attribute for more than one example>
#>

#---------------------------------------------------------[Script Parameters]------------------------------------------------------

Param (
  #Script parameters go here
)


#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
$sScriptVersion = '1.0'

#Set Error Action to Silently Continue
$ErrorActionPreference = 'SilentlyContinue'


#Log File Info
$dir = (get-location).ToString() + '\'
$logFile = $dir + 'Log\' + (get-date -format 'yyyymmdd') +'_OutputLog.txt'
Try {
    if ((Get-ChildItem -Attributes 'directory').name -notcontains 'Log') {
        New-Item -Type Directory .\Log
    }
}
Catch {
    Write-Host "Error creating log file directory $logfile" -ForegroundColor Red
    Break
}



#-----------------------------------------------------------[Functions]------------------------------------------------------------

# Logging Function
function write-log {
    Param($message)
    Write-output "$(get-date -format 'MM/dd/yy HH:mm:ss') $message" | Out-File $logFile -Append
}

#-----------------------------------------------------------[Execution]------------------------------------------------------------


# Gather User Information
Try {
    write-log ('Script ran by ' + ($env:UserDomain + '\' + $env:username) + ' from ' + $env:COMPUTERNAME)
}
Catch {
    $ErrorMessage = $_.Exception.message
    write-log ("Error Message: " + $ErrorMessage)
    Break
}
