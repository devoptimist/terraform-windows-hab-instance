<powershell>
%{ if admin_pass != "" }
$MySecureString = ConvertTo-SecureString -String "${admin_pass}" -AsPlainText -Force
$UserAccount = Get-LocalUser -Name "Administrator"
$UserAccount | Set-LocalUser -Password $MySecureString
%{ endif }
net user ${user} '${pass}' /add /y
net localgroup administrators ${user} /add

winrm quickconfig -q
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB=”300″}'
winrm set winrm/config '@{MaxTimeoutms=”1800000″}'

winrm set winrm/config/client/auth '@{Basic="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'

netsh advfirewall firewall add rule name="WinRM 5985" protocol=TCP dir=in localport=5985 action=allow
netsh advfirewall firewall add rule name="WinRM 5986" protocol=TCP dir=in localport=5986 action=allow

%{ if install_hab }
New-NetFirewallRule -DisplayName 'Habitat TCP' -Direction Inbound -Action Allow -Protocol TCP -LocalPort 9631,9638
New-NetFirewallRule -DisplayName 'Habitat UDP' -Direction Inbound -Action Allow -Protocol UDP -LocalPort 9638
%{ endif }

net stop winrm
sc.exe config winrm start=auto
net start winrm
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
%{ if install_hab }
%{ if hab_version != "" }
C:\ProgramData\chocolatey\choco.exe install habitat --version ${hab_version} -y 
%{ else }
C:\ProgramData\chocolatey\choco.exe install habitat -y
%{ endif }
C:\ProgramData\chocolatey\lib\habitat\hab-*\hab.exe license accept
C:\ProgramData\chocolatey\lib\habitat\hab-*\hab.exe pkg install core/windows-service
C:\ProgramData\chocolatey\lib\habitat\hab-*\hab.exe pkg exec core/windows-service install
Start-Service Habitat
%{ endif }
%{ if docker_image_name != "" }
docker pull ${docker_image_name}
%{ endif }
</powershell>
