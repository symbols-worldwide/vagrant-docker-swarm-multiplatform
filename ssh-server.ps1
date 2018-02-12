choco install openssh -params '"/SSHServerFeature /KeyBasedAuthenticationFeature /PathSpecsToProbeForShellEXEString:$env:programfiles\PowerShell\*\pwsh.exe;$env:programfiles\PowerShell\*\Powershell.exe;c:\windows\system32\windowspowershell\v1.0\powershell.exe"' -confirm
New-NetFirewallRule -Name "SSHServer" -DisplayName "SSH Server TCP/22" -Protocol tcp -LocalPort 22 -Action Allow -Enabled True
