Add-Type -AssemblyName System.Windows.Forms

# Prompt for input file
$FileDialog = New-Object System.Windows.Forms.OpenFileDialog
$FileDialog.Filter = "Text Files (*.txt)|*.txt"
$FileDialog.Title = "Select Server List File"
$null = $FileDialog.ShowDialog()
$ServerListFile = $FileDialog.FileName

# Read server list from file
$Servers = Get-Content -Path $ServerListFile

# Initialize array to store powered off servers
$PoweredOffServers = @()

# Check if each server is reachable
foreach ($Server in $Servers) {
    if (Test-Connection -ComputerName $Server -Count 1 -Quiet) {
        Write-Host "$Server is still reachable, shutdown may not have completed."
    } else {
        Write-Host "$Server is unreachable, shutdown confirmed."
        $PoweredOffServers += $Server
    }
}

# Display powered off servers
Write-Host "Powered Off Servers:"
$PoweredOffServers | ForEach-Object { Write-Host $_ }