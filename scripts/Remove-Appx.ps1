# Powershell script to clean up unwanted Windows 10 UWP Apps.
#
# A list of available appx packages to install can be found here:
# https://docs.microsoft.com/en-us/windows/application-management/apps-in-windows-10
#
# This is part of a repository hosted here: https://github.com/kiweezi/root-scripts
# Created by Kiweezi: https://github.com/kiweezi
#


# -- Global Variables --

# Lists Appx packages to install and keep on image.
$appxWhitelist = @(
	# Whitelisted Microsoft appx.
	"Microsoft.WindowsCamera",
	"Microsoft.WindowsStore",
	"Microsoft.MicrosoftStickyNotes",
	"Microsoft.BingWeather",
	"Microsoft.WindowsCalculator"

	# Whitelisted appx that can only be installed via Microsoft Store.
	# "NVIDIAControlPanel"
)

# Lists Appx packages to uninstall from image permanently.
$appxBlacklist = @(
	#Unnecessary Windows 10 AppX Apps
	"*Microsoft.BingNews*"
	"*Microsoft.DesktopAppInstaller*"
	"*Microsoft.GetHelp*"
	"*Microsoft.Getstarted*"
	"*Microsoft.Messaging*"
	"*Microsoft.Microsoft3DViewer*"
	"*Microsoft.MicrosoftOfficeHub*"
	"*Microsoft.MicrosoftMahjong*"
	"*Microsoft.MicrosoftSolitaireCollection*"
    "*Microsoft.MixedReality.Portal*"
    "*Microsoft.MSPaint*"
	"*Microsoft.NetworkSpeedTest*"
	"*Microsoft.Office.OneNote*"
	"*Microsoft.Office.Sway*"
	"*Microsoft.OneConnect*"
	"*Microsoft.People*"
	"*Microsoft.Print3D*"
    "*Microsoft.RemoteDesktop*"
    "*Microsoft.ScreenSketch*"
    "*Microsoft.SkypeApp*"
	"*Microsoft.StorePurchaseApp*"
    "*Microsoft.Todos*"
    "*Microsoft.Windows.Photos*"
	"*Microsoft.WindowsAlarms*"
	"*Microsoft.WindowsCamera*"
	"*microsoft.windowscommunicationsapps*"
	"*Microsoft.WindowsFeedbackHub*"
	"*Microsoft.WindowsMaps*"
	"*Microsoft.WindowsSoundRecorder*"
	"*Microsoft.Xbox.TCUI*"
	"*Microsoft.XboxApp*"
	"*Microsoft.XboxGameOverlay*"
	"*Microsoft.XboxIdentityProvider*"
	"*Microsoft.XboxSpeechToTextOverlay*"
	"*Microsoft.ZuneMusic*"
	"*Microsoft.ZuneVideo*"

	#Sponsored Windows 10 AppX Apps
	#Add sponsored/featured apps to remove in the "*AppName*" format
	"*EclipseManager*"
	"*ActiproSoftwareLLC*"
	"*AdobeSystemsIncorporated.AdobePhotoshopExpress*"
	"*Duolingo-LearnLanguagesforFree*"
	"*PandoraMediaInc*"
	"*CandyCrush*"
	"*Wunderlist*"
	"*Flipboard*"
	"*Twitter*"
	"*Facebook*"
	"*Spotify*"
	"*WhatsAppDesktop*"
	"*PolarrPhotoEditor*"
	"*HotspotShieldFreeVPN*"
	"*Sketchable*"
	"*WinZipDesktop*"
	"*Netflix*"
)

# -- End --



function Remove-Appx {
	# Cleans up windows built in apps.

	# Variables {
	# 	[$appxWhitelist] - Lists Appx packages to install and keep on image.
	# 	[$appxBlacklist] - Lists Appx packages to uninstall from image permanently.
	# }

	Write-Host '<Remove-Appx>'

	try {
		# Loops through the list of packages to install and installs them.
		ForEach ($app in $appxWhitelist) {
			Get-AppxPackage -allusers $app | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
		}
		Write-Host 'Installed and registered whitelisted appx-packages.'

		# Loops for all Blacklisted packages.
		foreach ($app in $appxBlacklist) {
			# Removes each app package that is in the blacklist.
	    Get-AppxPackage -Name $App | Remove-AppxPackage -ErrorAction SilentlyContinue
			# Stops these apps from being installed on new user profiles.
	    Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $App | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
    }
		Write-Host "Blacklisted appx forbidden from auto-installing on image."
		Read-Host -Prompt "Check all appx packages are correct, then press enter to continue..."
		Write-Host "Appx cleaned on image."
	}

	catch {
		Write-Host "<Remove-Appx> ERROR. Could not clean up appx-packages."
		Write-Host "Error message: $($_) `n"
	}
}



# -- MAIN --

# Uninstalls and re-installs only neccesary appx packages.
Remove-Appx

# --END--



# Terminates the script.
exit
