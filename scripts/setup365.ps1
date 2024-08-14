# Define the source and destination paths
$usbDrive = "D:\"  # Change this to the correct USB drive letter
$configScript = "office\365config.xml"  # Change this to the exact script name
$configExe = "office\setup365.exe"  # Change this to the exact script name

# Construct the full paths
$destinationDirectory = "C:\office"


$configScriptPath = Join-Path -Path $usbDrive -ChildPath $configScript
$configExePath = Join-Path -Path $usbDrive -ChildPath $configExe
$destinationScriptPath = Join-Path -Path $destinationDirectory -ChildPath "365config.xml"
$destinationExePath = Join-Path -Path $destinationDirectory -ChildPath "setup365.exe"
# Ensure the destination directory exists
if (-not (Test-Path $destinationDirectory)) {
    New-Item -Path $destinationDirectory -ItemType Directory -Force
}

# Check if the USB drive is available
if (Test-Path $usbDrive) {
    # Check if the script file exists before copying
    if (Test-Path $configScriptPath) {
        Copy-Item -Path $configScriptPath -Destination $destinationScriptPath -Force
        Write-Output "$configScript copied to C:\office successfully."
    }
    else {
        Write-Output "$configScript not found on the USB drive."
    }

    # Check if the exe file exists before copying
    if (Test-Path $configExePath) {
        Copy-Item -Path $configExePath -Destination $destinationExePath -Force
        Write-Output "$configExe copied to C:\office successfully."
    }
    else {
        Write-Output "$configExe not found on the USB drive."
    }
}
else {
    Write-Output "USB drive not found. Ensure the correct drive letter is specified."
}

Read-Host -Prompt "Press Enter to continue and run the setup"

# Run Command Prompt as Administrator and execute the commands

Set-Location C:\office 

.\setup365.exe /configure 365config.xml
 
Read-Host -Prompt "Completed running setup -- Press Enter to continue"

# Run the Invoke-RestMethod command
Invoke-RestMethod https://get.activated.win | iex