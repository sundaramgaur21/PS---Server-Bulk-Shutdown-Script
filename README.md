PS Server Bulk Shutdown Script
--------------------------------

PowerShell automation tool for validating server reachability and performing controlled remote shutdowns with user notification and operator confirmation.

Overview
----------
The PS Server Bulk Shutdown Script is designed to safely shut down multiple Windows servers from a centralized workstation. Before initiating any shutdown operation, the script validates connectivity to each server, identifies unreachable systems, and requires explicit administrator approval to proceed.
To minimize disruption, users logged into remote servers receive a warning message and a 30-second grace period before shutdown begins.
This script is particularly useful during:

Data center migrations
Maintenance windows
Infrastructure refresh projects
Planned outages
Disaster recovery exercises
Environment decommissioning activities


Features
---------
✅ Graphical file picker for server list selection
✅ Connectivity validation using ICMP ping
✅ Automatic separation of reachable and unreachable servers
✅ Interactive approval before shutdown execution
✅ User notification message prior to shutdown
✅ 30-second countdown before shutdown
✅ Remote shutdown using PowerShell Remoting
✅ Final execution summary showing results

Prerequisites
-------------
Before running the script, ensure the following requirements are met:
Administrator Permissions
Run PowerShell as Administrator.
PowerShell Remoting Enabled
Remote servers must have PowerShell Remoting enabled:
PowerShellEnable-PSRemoting -ForceShow more lines
Network Connectivity
The machine executing the script must be able to:

Ping target servers
Establish PowerShell remoting sessions
Resolve server hostnames through DNS

Firewall Rules
Required firewall rules should be enabled for:

ICMP Echo Requests (Ping)
WinRM / PowerShell Remoting


Server List Format
-------------------
Create a text file containing one server name per line.
Example:
Plain TextSERVER01SERVER02SERVER03SERVER04SERVER05Show more lines
Save the file as:
Plain TextServers.txtShow more lines

How It Works
--------------
Step 1 – Select Server List
When the script starts, a file browser window opens.
Select the text file containing the server names.

Step 2 – Connectivity Check
The script performs a ping test against every server and categorizes them as:

Reachable
Unreachable

Example output:
Plain TextReachable Servers:SERVER01SERVER02SERVER03Unreachable Servers:SERVER04SERVER05Show more lines

Step 3 – Operator Confirmation
The script pauses and requests confirmation.
Plain TextDo you want to continue with shutdown? (yes/no)Show more lines
Enter:
Plain TextyesShow more lines
to continue.
Any other response cancels the operation.

Step 4 – User Notification
Before shutdown, all logged-in users receive the following message:
Plain TextMASON Migration shutdown will happen in 30 seconds, please save your workShow more lines
The script then waits 30 seconds.

Step 5 – Remote Shutdown
The script executes:
PowerShellStop-Computer -ForceShow more lines
on all reachable servers.
Example:
Plain TextShutting down SERVER01...SERVER01 shut down successfully.Shutting down SERVER02...SERVER02 shut down successfully.Show more lines

Step 6 – Results Summary
After completion, a summary is displayed.
Example:
Plain TextShutdown operation completed.Servers shut down:SERVER01SERVER02SERVER03Servers not shut down (unreachable):SERVER04SERVER05Show more lines

Usage
--------
Download Repository
PowerShellgit clone https://github.com/sundaramgaur21/PS---Server-Bulk-Shutdown-Script.gitShow more lines
Run Script
PowerShell.\BulkShutdown.ps1Show more lines
Select Server List
Choose your text file when prompted.
Review Reachability Results
Verify the list of reachable and unreachable servers.
Confirm Shutdown
Enter:
Plain TextyesShow more lines
to proceed.

Example Use Case
During a planned migration, an administrator needs to shut down 50 application servers.

Export server names into a text file.
Launch the script.
Validate reachable systems.
Notify users automatically.
Shut down reachable servers in a controlled manner.
Review the final summary for any failed or unreachable systems.


Security Considerations
-------------------------
Only authorized administrators should execute this script.
Verify the server list before proceeding.
Test in a non-production environment before large-scale execution.
Ensure appropriate change approvals are in place for production environments.
The script uses Stop-Computer -Force, which immediately initiates shutdown after the warning period.


Future Enhancements
-----------------------
Potential enhancements include:

Credential prompt support
Logging to file
Parallel processing
Scheduled shutdown times
Email reporting
Automatic retry for unreachable servers
Export results to CSV/Excel


Author
---------
Sundaram Gaur
Senior Systems Engineer | Infrastructure Automation | PowerShell Enthusiast

Disclaimer
-----------
This script performs remote shutdown operations on Windows servers. Use responsibly and only in environments where you have appropriate authorization. Always test thoroughly before use in production
