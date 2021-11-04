<#
.SYNOPSIS
    Template for powershell scripts.
.DESCRIPTION
    Cmdlet for a template for other scripts.
.PARAMETER Test
    Specifies whether the execution is a test or not.
.PARAMETER ComputerName
    Lists the name(s) of the computers to perform the script on.
    
.EXAMPLE
    .template -Test -ComputerName "MyPC01", "MyPC02"
    
    Performs a test on the network machines MyPC01 and MyPC02.
.NOTES
    This file serves as a template for other scripts.
    This is part of a project hosted here: https://github.com/{org/profile}/{repo}
    Created by Kiweezi: https://github.com/kiweezi
#>



# -- Global Variables --



# -- End --



# -- Main --

function Start-Main {
    # Calls the rest of the commands in the script.
    
}


Start-Main

# -- End --



# Terminates the script.
exit
