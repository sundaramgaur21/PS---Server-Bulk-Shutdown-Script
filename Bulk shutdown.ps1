Add-Type -AssemblyName System.Windows.Forms

# Prompt for input file
$FileDialog = New-Object System.Windows.Forms.OpenFileDialog
$FileDialog.Filter = "Text Files (*.txt)|*.txt"
$FileDialog.Title = "Select Server List File"
$null = $FileDialog.ShowDialog()
$ServerListFile = $FileDialog.FileName

# Read server list from file
$Servers = Get-Content -Path $ServerListFile

# Arrays to store reachable and unreachable servers
$ReachableServers = @()
$UnreachableServers = @()

# Check if each server is reachable
foreach ($Server in $Servers) {
    if (Test-Connection -ComputerName $Server -Count 1 -Quiet) {
        $ReachableServers += $Server
    } else {
        $UnreachableServers += $Server
    }
}

# Display reachable and unreachable servers
Write-Host "Reachable Servers:"
$ReachableServers | ForEach-Object { Write-Host $_ }
Write-Host "Unreachable Servers:"
$UnreachableServers | ForEach-Object { Write-Host $_ }

# Prompt for confirmation to continue with shutdown
$Response = Read-Host "Do you want to continue with shutdown? (yes/no)"
if ($Response -ne "yes") {
    Write-Host "Shutdown cancelled."
    exit
}

# Shutdown reachable servers
foreach ($Server in $ReachableServers) {
    Write-Host "Shutting down $Server..."
  Invoke-Command -ComputerName $Server -ScriptBlock {
msg * "MASON Migration shutdown will happen in 30 seconds, please save your work"
Start-Sleep -Seconds 30
Stop-Computer -Force
}
    Write-Host "$Server shut down successfully."
}

# Display final status
Write-Host "Shutdown operation completed."
Write-Host "Servers shut down:"
$ReachableServers | ForEach-Object { Write-Host $_ }
Write-Host "Servers not shut down (unreachable):"
$UnreachableServers | ForEach-Object { Write-Host $_ }