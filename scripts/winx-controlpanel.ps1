# Puts control panel option in WinX menu without replacing any other options.
#
# Source: https://superuser.com/questions/1220328/control-panel-missing-from-right-click-on-start-menu
# This is part of a repository hosted here: https://github.com/kiweezi/root-scripts
# Created by Kiweezi: https://github.com/kiweezi
#


# -- Global Variables --

# Path to WinX menu.
$path = "$env:LOCALAPPDATA\Microsoft\Windows\WinX\Group2"

# Base64 encoded shortcut file to Control Panel.
$x = "UEsDBBQAAAAIAEphSkmJ5YBS0QAAAPcDAAARAAAAQ29udHJvbCBQYW5lbC5sbmvzYWBgYBRhYgCBA2CSwa2B
mQEiQAAwovEnAzEnA8MCXSBtGBwQ/Kgrwm2Pj4Xz7j/Ck9Vm5J4ThCkURtIEUxyq4TO/cr6l94oLD6/oPrz6GaRYCK
aYEU1xtW7v74sTTPz2J+St4ZykvR+kmAmm+Og13laY6SLMYM0LVMsz81Iyi1RjiiuLS1JzjY1ikvPzSoryc/RSK1KJ
8eswAKoM5QyZDHkMKUCyCMiLYShmqATiEoZUhlwGYwYjoEgyQz5QRQlQPp8hh0EPKFPBMFLCZyQBAFBLAQIUABQAAA
AIAEphSkmJ5YBS0QAAAPcDAAARAAAAAAAAAAAAAAAAAAAAAABDb250cm9sIFBhbmVsLmxua1BLBQYAAAAAAQABAD8A
AAAAAQAAAAA=".replace("`n","")

# -- End --



# -- Main --

# Create a temporary zipped folder including the shortcut file.
[Convert]::FromBase64String($x) | Set-Content $path\temp.zip -Encoding Byte
# Extract the shortcut file to the WinX menu path.
Expand-Archive $path\temp.zip -DestinationPath $path
# Delete the temporary zip.
Remove-Item $path\temp.zip
# Close explorer which Windows will automatically start again.
Stop-Process -Name Explorer

# -- End --



# Terminates the script.
exit
