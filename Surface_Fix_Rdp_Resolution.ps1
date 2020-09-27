<#

███████╗██╗   ██╗██████╗ ███████╗ █████╗  ██████╗███████╗    ███████╗██╗██╗  ██╗    ██████╗ ██████╗ ██████╗     ██████╗ ███████╗███████╗ ██████╗ ██╗     ██╗   ██╗████████╗██╗ ██████╗ ███╗   ██╗
██╔════╝██║   ██║██╔══██╗██╔════╝██╔══██╗██╔════╝██╔════╝    ██╔════╝██║╚██╗██╔╝    ██╔══██╗██╔══██╗██╔══██╗    ██╔══██╗██╔════╝██╔════╝██╔═══██╗██║     ██║   ██║╚══██╔══╝██║██╔═══██╗████╗  ██║
███████╗██║   ██║██████╔╝█████╗  ███████║██║     █████╗      █████╗  ██║ ╚███╔╝     ██████╔╝██║  ██║██████╔╝    ██████╔╝█████╗  ███████╗██║   ██║██║     ██║   ██║   ██║   ██║██║   ██║██╔██╗ ██║
╚════██║██║   ██║██╔══██╗██╔══╝  ██╔══██║██║     ██╔══╝      ██╔══╝  ██║ ██╔██╗     ██╔══██╗██║  ██║██╔═══╝     ██╔══██╗██╔══╝  ╚════██║██║   ██║██║     ██║   ██║   ██║   ██║██║   ██║██║╚██╗██║
███████║╚██████╔╝██║  ██║██║     ██║  ██║╚██████╗███████╗    ██║     ██║██╔╝ ██╗    ██║  ██║██████╔╝██║         ██║  ██║███████╗███████║╚██████╔╝███████╗╚██████╔╝   ██║   ██║╚██████╔╝██║ ╚████║
╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝ ╚═════╝╚══════╝    ╚═╝     ╚═╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═════╝ ╚═╝         ╚═╝  ╚═╝╚══════╝╚══════╝ ╚═════╝ ╚══════╝ ╚═════╝    ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
Version 1.0                                                                                                                                                                                                

.SYNOPSIS
    Surface_Fix_RDP_Resolution.ps1 - Fix RDP session resolution on the MS Surface.

.DESCRIPTION
	A resolution issue affects Surface tablets during an RDS session. In order to correct the problem we add a key in the registry and copy a file

.PARAMETER 
    N/A

.EXAMPLE
    .\Tablette_resolution.ps1
	
	Valid and if necessary create a named key "PreferExternalManifest" of type "DWORD" with a value of "1" in the hive  "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\"
	Valid and if necessary copy a file named "mstsc.exe.manifest" in the directory "C:\Windows\System32"
	
.INPUTS
	N/A

.OUTPUTS
	n/A

.NOTES
Written by: Christophe Pelichet (c.pelichet@gmail.com)
 
Find me on: 
 
* LinkedIn:     https://linkedin.com/in/christophepelichet
* Github:       https://github.com/ChristophePelichet
 
Change Log 
V1.00 - 05/24/2018 - Initial version 

#>

########################################################
######################## Path ##########################
########################################################

$SCRIPTPATH	=	$PSScriptRoot

########################################################
###################### Functions #######################
########################################################

## No Functions 


#######################################################
###################### Variables ######################
#######################################################

$REGPATH	=	'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\'  		# Registry Key Path
$REGKEY		=	'PreferExternalManifest'											# Registry Key Name
$REGTYPE	=	'DWORD'																# Registry Key Type 
$REGVALUE	=	'1'																	# Registry Key Path Value

$FILEPATH   =	'C:\Windows\System32'												# File Path
$FILENAME	=	'mstsc.exe.manifest'												# File Name 
$FILEPATHCP =	'\files\mstsc.exe.manifest'											# File Path Path du fichier to copy

$POLICYTYPE =	'RemoteSigned'														# Execution Mode
																					# Restricted 	 : 	No script can be executed. PowerShell can only be used in interactive mode.
																					# AllSigned 	 : 	Only signed scripts can be executed.
																					# RemoteSigned   : 	Scripts downloaded from the Internet must be signed to be executed 
																					#					The scripts present on your workstation are not affected and can be executed.
																					# Unrestricted   : 	No restrictions. Scripts can be executed.

																					
###############################################################
######################## Start Script #########################
###############################################################

# Force execution type
Set-ExecutionPolicy $POLICYTYPE																					

#######################
## Test registry Key ##
#######################

if(!(Test-Path $REGPATH)) {																						
	New-Item -Path $REGPATH -Force | Out-Null																	
	New-ItemProperty -Path $REGPATH -name $REGKEY -Value $REGVALUE -PropertyType $REGTYPE -Force | Out-Null		
}else{																											
	New-ItemProperty -Path $REGPATH -name $REGKEY -Value $REGVALUE -PropertyType $REGTYPE -Force | Out-Null		
}
	
###############
## Test File ##
###############

if (!(Test-Path $FILEPATH$FILENAME)){																			
	Copy-Item $SCRIPTPATH$FILEPATHCP -Destination $FILEPATH														
}


#############################################################
######################## End Script #########################
#############################################################

	

