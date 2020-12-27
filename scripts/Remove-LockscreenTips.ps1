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
# Turns off Windows Spotlight, keeping the still image.
Set-ItemProperty -Path $keyPath -Name 'SubscribedContent-338387Enabled' -Value 0

# Schedule a jon under the current user to run an update at startup.
# Define the script content to run as the action from the scheduled job.
# Momentarily enable Windows Spotlight to get the new image, then disable it.
$script = {
	$keyPath = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'
	Set-ItemProperty -Path $keyPath -Name 'SubscribedContent-338387Enabled' -Value 1
	Start-Sleep -Seconds 5
	Set-ItemProperty -Path $keyPath -Name 'SubscribedContent-338387Enabled' -Value 0
}
# Set the job to run elevated at the current user's sign in.
$trigger = New-JobTrigger -AtLogOn -User $env:USERNAME
$option = New-ScheduledJobOption -StartIfOnBattery -RunElevated
# Register the scheduled job.
Register-ScheduledJob -Name "Update-Spotlight" -ScheduledJobOption $option -Trigger $trigger -ScriptBlock $script

# -- End --



# Terminates the script.
exit
