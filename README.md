# Root Scripts

#### Useful scripts for Windows 10. Personally curated and created by me. Most scripts will be either PowerShell or batch.

---

## Index

<!--toc-start-->
* [Setup](#setup)
* [Usage](#usage)
* [Latest Version](#latest-version)
<!--toc-end-->

---

## Setup
- Download and extract the Zip file from GitHub.
- Run the ```.Allow-PSScripts.bat``` batch file with administrator to allow execution of downloaded PowerShell scripts.

## Usage
- Open a PowerShell terminal.
- Set your execution location to the scripts folder:
```powershell
Set-Location "C:\test\scripts\"
```
- Call a script by typing ```.\``` before the script filename: 
```powershell
.\Remove-LockscreenTips.ps1
```

## Latest Version

### 1.0.1 - Remove Lockscreen Tips
Adds a script to clean up Windows 10 lockscreen.

### Changes:
- Added script to remove Windows Lockscreen tips for Windows Spotlight.
- Renamed script files appropriately.

### Fixes:
- None
