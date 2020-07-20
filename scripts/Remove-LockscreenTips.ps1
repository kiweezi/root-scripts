# Removes bing tips from the Windows Spotlight lockscreen in Windows 10.
#
# This is part of a repository hosted here: https://github.com/kiweezi/root-scripts
# Created by Kiweezi: https://github.com/kiweezi
#


# -- Global Variables --

# Registry key path.
$keyPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"

# -- End --



# -- Main --

# Enable content delivery which allows dynamic content to work.
Set-ItemProperty -Path $keyPath -Name "ContentDeliveryAllowed" -Value 1
# Enable rotating lock scree allows the image to change instead of a static one.
Set-ItemProperty -Path $keyPath -Name "RotatingLockScreenEnabled" -Value 1
# Turns off the 'get fun facts' option for lock screens.
Set-ItemProperty -Path $keyPath -Name "RotatingLockScreenOverlayEnabled" -Value 0
# Disables showing tips on the lock screen.
Set-ItemProperty -Path $keyPath -Name "SubscribedContent-338387Enabled" -Value 0

# -- End --



# Terminates the script.
exit
