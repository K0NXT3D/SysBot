# SysBot
============================================================
                     SysBot - Users Guide
            System Services Inspection Utility
               Linux Mint / Ubuntu 20.x
============================================================

Overview:
---------
SysBot is a command-line utility designed for inspecting,
monitoring, and managing Linux services on systems using
systemd (Linux Mint / Ubuntu 20.x). It provides both
diagnostic insights and service control capabilities
to help administrators, developers, and power users
troubleshoot system and network issues effectively.

Core Features:
--------------
1) Inspect Services
   - List enabled boot services.
   - List all registered systemd services.
   - Display active/running services.
   - Show failed services.
   - Analyze boot times and critical chains using
     systemd-analyze.

2) Service Management
   - Start, stop, restart services.
   - Enable or disable services for future boots.
   - Access legacy SysV init services.
   - Inspect user autostart applications.

3) Root Escalation
   - Relaunch SysBot as sudo for privileged actions.

Why SysBot Matters:
------------------
SysBot is more than a service viewer—it’s a diagnostic
platform for understanding and maintaining Linux systems.

- Bug Hunting:
  Quickly identify failing services, trace dependencies,
  and locate root causes for application or OS issues.

- Production Systems:
  Monitor critical services for uptime, performance, and
  reliability in live environments.

- Network Diagnostics:
  Verify network-related services (ssh, nginx, cups, dns)
  are active and functioning.

- OS Fundamentals:
  Learn which services start at boot, which are running,
  and how they interact with each other.

- OS Repair:
  Restart, enable, or disable services to restore system
  stability. Audit autostart applications for unnecessary
  processes.

Recommended Workflow:
---------------------
1) Launch SysBot: `./sysbot.sh -m`
2) Inspect running and failed services:
   - Start with "Running Services" (option 3)
   - Check "Failed Services" (option 4)
3) Analyze boot performance:
   - Boot blame (option 5)
   - Critical chain (option 6)
4) Review legacy services and autostart apps:
   - SysV init scripts (option 7)
   - Login autostart (option 8)
5) Apply service actions as needed:
   - Enable/disable services (option 9 & 10)
   - Start/stop/restart services (options 11-13)
6) Use root mode if required (option 14)

Tips & Best Practices:
----------------------
- Always validate services before starting/stopping them.
- Keep track of failed services to prevent recurring issues.
- Use SysBot to analyze boot times after system updates.
- Audit autostart apps to reduce boot time and resource usage.
- In production, monitor critical network services regularly.
- For OS repairs, combine SysBot diagnostics with log
  inspection (`journalctl -xe`) for deeper insights.

Keyboard Shortcuts (Modal/HTML Docs):
-------------------------------------
- Open documentation modal: click "Documentation"
- Close modal: ESC or ✖ button
- Copyable content: click or select text for terminal commands.

Installation:
-------------
1) Place `sysbot.sh` in a directory, e.g., `/usr/local/bin`
2) Make it executable:
   chmod +x sysbot.sh
3) Run:
   ./sysbot.sh -m

Optional:
- Open `sysbot.html` in a browser for a detailed GUI
  style reference with interactive cards and buttons.

Security Notes:
---------------
- Certain operations require root privileges.
- Always verify services before disabling critical system
  processes.

Credits:
--------
Author: Rob Seaverns (K0NxT3D)
SysBot - Linux Service Utility v2.x

============================================================

=====================================================================================
 SysBot v1.0 (Release)
 System Service Inspection & Diagnostics Utility
 Target Systems: Linux Mint / Ubuntu 20.x (Systemd-Based Distros)

 Author: Rob Seaverns (K0NxT3D)
 Project Page: http://www.seaverns.com/
 Release Date: 2025-12-09

-------------------------------------------------------------------------------------
 Description:
 -----------
 SysBot is a lightweight command-line utility designed to inspect, analyze, 
 and manage Linux system services. It provides an organized interface for viewing
 enabled services, active processes, failed units, boot delays, autostart programs,
 SysV compatibility listings, and direct systemctl control.

 This tool is ideal for:
  • Diagnosing slow boot issues (via systemd-analyze & critical-chain)
  • Verifying failed or inactive services
  • Monitoring startup processes
  • Managing service states (enable/disable/start/stop/reload/restart)
  • Researching regression issues after system updates

-------------------------------------------------------------------------------------
 Features:
 ---------
  1) List enabled services (boot)
  2) List all systemd services
  3) Display active (running) services
  4) Display failed services
  5) Boot time analysis (systemd-analyze blame)
  6) Critical chain dependency graph
  7) Legacy SysV init service compatibility listing
  8) Login-session autostart application detection
  9) Enable a service
 10) Disable a service
 11) Start a service
 12) Restart a service
 13) Stop a service
 14) Option to re-run SysBot as root (sudo)

-------------------------------------------------------------------------------------
 Requirements:
 -------------
  • Bash 4.x or newer
  • systemd (systemctl, systemd-analyze)
  • Linux Mint or Ubuntu 20.x recommended (will run on most systemd distros)
  • Optional: sudo privileges for service management

-------------------------------------------------------------------------------------
 Legal / License:
 ----------------
  SysBot is released under the MIT License.
  You may modify, distribute, or embed this script in other software freely.
  Full license text included in project documentation and website.

  Disclaimer:
  - This tool does not modify service state unless a user explicitly selects 
    an action requiring elevated permissions.
  - Service management actions should be executed with caution.
  - User assumes all responsibility for system changes performed with SysBot.

-------------------------------------------------------------------------------------
 Version History:
 ----------------
 1.0  2025-12-09  Initial release - full systemd and SysV inspection

-------------------------------------------------------------------------------------
 Script Start Timestamp:
 ------------------------
 START_TIME="$(date +'%Y-%m-%d %H:%M:%S')"
 echo "SysBot started at: $START_TIME"

-------------------------------------------------------------------------------------

MIT License

Copyright (c) 2025 Rob Seaverns (K0NxT3D)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES, OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
