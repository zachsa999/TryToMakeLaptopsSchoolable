.\scripts\wifi.ps1
Read-Host "Removing Naughty Apps--Press Enter:"
.\scripts\removeApps.ps1



Read-Host -Prompt "Starting 365 process--Press Enter to continue"
.\scripts\setup365.ps1

iwr -useb https://christitus.com/win | iex