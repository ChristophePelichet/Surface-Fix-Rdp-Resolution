## Surface Fix RDP Resoltion

# Description
	A resolution issue affects Surface tablets during an RDS session. In order to correct the problem we add a key in the registry and copy a file

# Example 
    .\Tablette_resolution.ps1
	
	Valid and if necessary create a named key "PreferExternalManifest" of type "DWORD" with a value of "1" in the hive  "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\"
	Valid and if necessary copy a file named "mstsc.exe.manifest" in the directory "C:\Windows\System32"
 
# Change Log 
V1.00 - 05/24/2018 - Initial version 

