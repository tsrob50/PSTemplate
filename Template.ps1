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

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

#Set Error Action to Silently Continue
$ErrorActionPreference = 'SilentlyContinue'

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
$sScriptVersion = '1.0'



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

<#
Function <FunctionName> {
  Param ()
  Begin {
    Write-LogInfo -LogPath $sLogFile -Message '<description of what is going on>...'
  }
  Process {
    Try {
      <code goes here>
    }
    Catch {
      Write-LogError -LogPath $sLogFile -Message $_.Exception -ExitGracefully
      Break
    }
  }
  End {
    If ($?) {
      Write-LogInfo -LogPath $sLogFile -Message 'Completed Successfully.'
      Write-LogInfo -LogPath $sLogFile -Message ' '
    }
  }
}
#>

#-----------------------------------------------------------[Execution]------------------------------------------------------------

# Start-Log -LogPath $sLogPath -LogName $sLogName -ScriptVersion $sScriptVersion
#Script Execution goes here
#Stop-Log -LogPath $sLogFile

# Gather User Information
Try {
    write-log ('Script ran by ' + ($env:UserDomain + '\' + $env:username) + ' from ' + $env:COMPUTERNAME)
}
Catch {
    write-log "Error gathering user information" -ForegroundColor Red
    Break
}
