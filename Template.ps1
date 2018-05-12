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

# Set Error Action to stop - Best set for each command
# $ErrorActionPreference = 'Stop'


#Log File Info
$dir = (get-location).ToString() + '\'
$logFile = $dir + 'Log\' + (get-date -format 'yyyyMMdd') +'_OutputLog.txt'
Try {
    if ((Get-ChildItem -Attributes 'directory').name -notcontains 'Log') {
        New-Item -ErrorAction stop -Type Directory .\Log
    }
}
Catch {
    Write-Host "Error creating log file directory $logfile" -ForegroundColor Red
    Break
}

# EventLog Info
# Set the event log to write events to, the source, event ID and source
# will use the script name unless source is set otherwise
$eventLog = "Application"
$eventSource = (split-path $MyInvocation.MyCommand.Definition -Leaf)
$eventID = 4000
$entryType = "Error"

# Verify that the Event Log Source exists or creates it
If ([System.Diagnostics.EventLog]::SourceExists($eventSource) -eq $False) {
    New-EventLog -LogName $eventLog -Source $eventSource
}



#-----------------------------------------------------------[Functions]------------------------------------------------------------

# Logging Function
function write-log {
    Param($message)
    Write-output "$(get-date -format 'MM/dd/yy HH:mm:ss') $message" | Out-File $logFile -Append
}

# Event Log Logging
function write-appEventLog {
    Param($errorMessage)
    Write-EventLog -LogName $eventLog -EventID $eventID -EntryType $entryType -Source $eventSource -Message $errorMessage 
}


#-----------------------------------------------------------[Execution]------------------------------------------------------------


# Gather User Information
Try {
    write-log -ErrorAction stop ('Script ran by ' + ($env:UserDomain + '\' + $env:username) + ' from ' + $env:COMPUTERNAME)
}
Catch {
    $ErrorMessage = $_.Exception.message
    write-log ('Error gathering user information ' + $ErrorMessage)
    Break
}


# Start code here
Try {
}
Catch {
    $ErrorMessage = $_.Exception.message
    write-log ('Error Message: ' + $ErrorMessage)
    Break
}
