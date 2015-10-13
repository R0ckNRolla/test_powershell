Function Create-ScheduledTask   {            
    param(            
      [string]$ComputerName = "localhost",            
      [string]$RunAsUser = "System",            
      [string]$TaskName = "Configure-DC1",            
      [string]$TaskRun = "'PowerShell.exe -NoLogo -File C:\Configure-DC1.ps1'",            
      [string]$Schedule = "ONLOGON"            
           )                            
                                                            
  $Command = "schtasks.exe /create /s $ComputerName /ru $RunAsUser /tn $TaskName /tr $TaskRun /sc $Schedule /F"            
  Invoke-Expression $Command            
 }