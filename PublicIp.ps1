$i = Get-Item -Path .\CurrentIpAddress.txt | Get-Content -Tail 1
$newIp = (Invoke-WebRequest ifconfig.me/ip).Content.Trim() 
if ($i -eq $newIp) { 
    Write-Host "IP has not changed $($i)"
    Write-Host "Press Y to copy $($i) to clipboard?"
	$input = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	if ($input.Character  -eq "Y" -or $input.Character -eq "y") {
		Set-Clipboard $i
		Write-Host "Copied"
	} else {}

 }
else { 
	$currentdate = Get-Date -Format "MM/dd/yyyy HH:mm K"
	Write-Host $currentdate
	Add-Content -Path .\CurrentIpAddress.txt -Exclude help* -Value ",$($currentdate),"
	Add-Content -Path .\CurrentIpAddress.txt -Exclude help* -Value "$($newIp)"
	Write-Host "ALERT, NEW IP: $($newIp)"
	Write-Host "Press Y to copy $($newIp) to clipboard?"
	$input = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	if ($input.Character  -eq "Y" -or $input.Character -eq "y") {
		Set-Clipboard $newIp
		Write-Host "Copied"
	} else {}
}
Write-Host "Press any key to exit..."
cmd /c Pause | Out-Null
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
