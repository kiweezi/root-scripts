# Removes bing tips from the Windows Spotlight lockscreen in Windows 10.
# Schedules a task at startup to momentarily enable spotlight to recieve the next lock screen image.
#
# This is part of a repository hosted here: https://github.com/kiweezi/root-scripts
# Created by Kiweezi: https://github.com/kiweezi
#


# -- Global Variables --

# Registry key path.
$keyPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"

# -- End --



# -- Main --

# If the script is not being run as administrator then elevate it.
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { 
	# Relaunch as an elevated process.
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit
}

# Set the following reg keys once as they are not effected by settings changes.
# Enable content delivery which allows dynamic content to work.
Set-ItemProperty -Path $keyPath -Name "ContentDeliveryAllowed" -Value 1
# Enable rotating lock scree allows the image to change instead of a static one.
Set-ItemProperty -Path $keyPath -Name "RotatingLockScreenEnabled" -Value 1
# Turns off the 'get fun facts' option for lock screens.
Set-ItemProperty -Path $keyPath -Name "RotatingLockScreenOverlayEnabled" -Value 0

# Schedule a task under the system account to run an update at startup.
# Set the action to momentarily re-enable the spotlight to get the next image.
$command = "-NonInteractive -NoLogo -NoProfile -Command &{$keyPath = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'; 
Set-ItemProperty -Path $keyPath -Name 'SubscribedContent-338387Enabled' -Value 1; Set-ItemProperty -Path $keyPath -Name 'SubscribedContent-338387Enabled' -Value 0}"
$Action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument $command
# Set the task to run at startup.
$Trigger = New-ScheduledTaskTrigger -AtStartup
# Set the principal to be run as system so that the task can run with no users logged in.
$Principle = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -RunLevel Highest
# Merge all arguments to a task.
$Settings = New-ScheduledTaskSettingsSet
$description = "This will update Windows Spotlight lockscreen background."
$Task = New-ScheduledTask -Action $Action -Trigger $Trigger -Settings $Settings -Principal $Principle -Description $description

# Register the task to set it in task scheduler.
Register-ScheduledTask -TaskName "Update-Spotlight" -InputObject $Task

# -- End --



# Terminates the script.
exit
