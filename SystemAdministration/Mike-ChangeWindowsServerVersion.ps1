#This script is to overcome an MSDN SSO issue that prevents access to the CD Images. Since microsoft doesn't distribute their pure CD Images online outside of MSDN
#this script allows you to change it.

#Collect the CD Key for Verification
Write-Host "This is script to update the edition to WS2019 Datacenter"
$productkey = Read-Host "Enter a CD Key"

# change the edition to Datacenter Addition
dism /online /set-edition:ServerDatacenter /productkey:$productkey /accepteula