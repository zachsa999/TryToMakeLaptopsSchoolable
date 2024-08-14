
netsh wlan add profile filename="wifi\Network1.xml"
netsh wlan add profile filename="wifi\Network2.xml"
netsh wlan add profile filename="wifi\Network3.xml"

# List of network names to try connecting to
$networks = @("EL", "TRCS", "TRCSSchool")

# Function to check connection status
Read-Host -Prompt "Function to Check Connection Status--Press Enter to continue"
function Test-WiFiConnection {
    param (
        [string]$NetworkName
    )
    
    # Try to connect to the WiFi network
    netsh wlan connect name=$NetworkName
    
    # Wait a few seconds to allow the connection to establish
    Start-Sleep -Seconds 10
    
    # Get the connection status
    $status = netsh wlan show interfaces | Select-String -Pattern "State\s*:\s*connected"
    
    # Return true if connected, false otherwise
    return $status -ne $null
}

# Iterate through the network names and attempt to connect
foreach ($network in $networks) {
    if (Test-WiFiConnection -NetworkName $network) {
        Write-Output "Connected to $network successfully."
        break
    }
    else {
        Write-Output "Failed to connect to $network. Trying next..."
    }
}
