#!/usr/bin/env bash

# =====================================================================================
#  SysBot v1.0 (Release)
#  System Service Inspection & Diagnostics Utility
#  Target Systems: Linux Mint / Ubuntu 20.x (Systemd-Based Distros)
#
#  Author: Rob Seaverns (K0NxT3D)
#  Project Page: http://www.seaverns.com/
#  Release Date: 2025-12-09
#
# -------------------------------------------------------------------------------------
#  Description:
#  -----------
#  SysBot is a lightweight command-line utility designed to inspect, analyze, 
#  and manage Linux system services. It provides an organized interface for viewing
#  enabled services, active processes, failed units, boot delays, autostart programs,
#  SysV compatibility listings, and direct systemctl control.
#
#  This tool is ideal for:
#   • Diagnosing slow boot issues (via systemd-analyze & critical-chain)
#   • Verifying failed or inactive services
#   • Monitoring startup processes
#   • Managing service states (enable/disable/start/stop/reload/restart)
#   • Researching regression issues after system updates
#
# -------------------------------------------------------------------------------------
#  Features:
#  ---------
#   1) List enabled services (boot)
#   2) List all systemd services
#   3) Display active (running) services
#   4) Display failed services
#   5) Boot time analysis (systemd-analyze blame)
#   6) Critical chain dependency graph
#   7) Legacy SysV init service compatibility listing
#   8) Login-session autostart application detection
#   9) Enable a service
#  10) Disable a service
#  11) Start a service
#  12) Restart a service
#  13) Stop a service
#  14) Option to re-run SysBot as root (sudo)
#
# -------------------------------------------------------------------------------------
#  Requirements:
#  -------------
#   • Bash 4.x or newer
#   • systemd (systemctl, systemd-analyze)
#   • Linux Mint or Ubuntu 20.x recommended (will run on most systemd distros)
#   • Optional: sudo privileges for service management
#
# -------------------------------------------------------------------------------------
#  Legal / License:
#  ----------------
#   SysBot is released under the MIT License.
#   You may modify, distribute, or embed this script in other software freely.
#   Full license text included in project documentation and website.
#
#   Disclaimer:
#   - This tool does not modify service state unless a user explicitly selects 
#     an action requiring elevated permissions.
#   - Service management actions should be executed with caution.
#   - User assumes all responsibility for system changes performed with SysBot.
#
# -------------------------------------------------------------------------------------
#  Version History:
#  ----------------
#  1.0  2025-12-09  Initial release - full systemd and SysV inspection
#
# -------------------------------------------------------------------------------------
#  Script Start Timestamp:
#  ------------------------
#  START_TIME="$(date +'%Y-%m-%d %H:%M:%S')"
#  echo "SysBot started at: $START_TIME"
#
# =====================================================================================


# --- Colors ---
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
MAGENTA="\e[35m"
RESET="\e[0m"
BOLD="\e[1m"

# --- Banner ---
banner() {
    clear
    echo -e "${GREEN}${BOLD}"
    echo -e "######## ######## ######## ######## ######## ######## "
    echo -e "##    ## #  ##  # ##    ## #     ## ##    ## #      # "
    echo -e "#  ##  # #  ##  # #  ##  # #  ##  # #  ##  # ###  ### "
    echo -e "#    ### ##    ## #    ### #     ## #  ##  # ###  ### "
    echo -e "####   # ###  ### ####   # #  ##  # #  ##  # ###  ### "
    echo -e "#  ##  # ###  ### #  ##  # #  ##  # #  ##  # ###  ### "
    echo -e "##    ## ###  ### ##    ## #     ## ##    ## ###  ### "
    echo -e "######## ######## ######## ######## ######## ######## "
    echo -e "          ${YELLOW}SysBot - System Services Utility${CYAN}         "
    echo -e "${RESET}"
}

# --- Ensure service exists ---
validate_service() {
    systemctl list-unit-files --type=service | grep -q "^$1" || {
        echo -e "${RED}Service not found: $1${RESET}"
        pause
        return 1
    }
}

# --- Help Menu ---
show_help() {
cat <<EOF
SysBot - Linux Service Diagnostic Tool
Usage: ./sysbot.sh [option]

Options:
  -m, --menu        Launch interactive menu (default)
  -h, --help        Display this help panel
  -v, --version     Display version information
  -a, --about       About SysBot

Contains:
  - Service inspection tools
  - Full service control: enable, disable, start, restart, stop
  - Root escalation menu option
EOF
exit 0
}

# -----------------------------
#         SERVICE ACTIONS
# -----------------------------
service_enable() { banner; read -p "Service to ENABLE: " srv; validate_service "$srv" || return; sudo systemctl enable "$srv"; echo -e "${GREEN}Service enabled.${RESET}"; pause; }
service_disable() { banner; read -p "Service to DISABLE: " srv; validate_service "$srv" || return; sudo systemctl disable "$srv"; echo -e "${YELLOW}Service disabled.${RESET}"; pause; }
service_start() { banner; read -p "Service to START: " srv; validate_service "$srv" || return; sudo systemctl start "$srv"; echo -e "${GREEN}Service started.${RESET}"; pause; }
service_restart() { banner; read -p "Service to RESTART: " srv; validate_service "$srv" || return; sudo systemctl restart "$srv"; echo -e "${GREEN}Service restarted.${RESET}"; pause; }
service_stop() { banner; read -p "Service to STOP: " srv; validate_service "$srv" || return; sudo systemctl stop "$srv"; echo -e "${RED}Service stopped.${RESET}"; pause; }

# -----------------------------
#         SYSTEM INFO
# -----------------------------
enabled_boot_services() { banner; echo -e "${GREEN}[ Enabled Boot Services ]${RESET}"; systemctl list-unit-files --type=service | grep enabled; pause; }
all_services() { banner; echo -e "${GREEN}[ All Registered Services ]${RESET}"; systemctl list-unit-files --type=service --no-pager; pause; }
running_services() { banner; echo -e "${GREEN}[ Active Running Services ]${RESET}"; systemctl list-units --type=service --state=running --no-pager; pause; }
failed_services() { banner; echo -e "${RED}[ Failed Services ]${RESET}"; systemctl --failed --no-pager; pause; }
boot_blame() { banner; echo -e "${YELLOW}[ systemd-analyze blame ]${RESET}"; systemd-analyze blame --no-pager; pause; }
critical_chain() { banner; echo -e "${YELLOW}[ systemd critical chain ]${RESET}"; systemd-analyze critical-chain --no-pager; pause; }
sysv_services() { banner; echo -e "${MAGENTA}[ SysV Init Services ]${RESET}"; [ -d /etc/init.d ] && ls -1 /etc/init.d || echo -e "${YELLOW}No SysV init scripts found.${RESET}"; pause; }
autostart_apps() { banner; echo -e "${BLUE}[ User Autostart Applications ]${RESET}"; ls -1 ~/.config/autostart 2>/dev/null || echo "No user autostarts found."; pause; }

# -----------------------------
#         UTILITY FUNCTIONS
# -----------------------------
pause() { echo -e "\n${YELLOW}Press Enter to return to menu...${RESET}"; read -r; }
run_as_root() { banner; echo -e "${GREEN}Restarting SysBot with sudo...${RESET}"; sudo bash "$0"; exit 0; }

about_sysbot() {
    clear
    cat <<EOF
======================== SysBot v1.0 ========================
System Service Inspection & Diagnostics Utility
Author: Rob Seaverns (K0NxT3D)
Project: https://github.com/VOIDCRAWLER
License: MIT

SysBot is designed to inspect, manage, and analyze Linux system
services in real-time. It helps with:
 - Boot diagnostics and performance analysis
 - Detecting failed or inactive services
 - Managing service states (enable, disable, start, stop, restart)
 - Researching regression issues post updates
 - Monitoring autostart applications and SysV compatibility

Quick Troubleshooting Tips:
 - Failed services? Check logs: journalctl -u <service>
 - Boot delay? Use: systemd-analyze blame / critical-chain
 - Network services down? Check firewall or systemctl status
 - Autostart issues? Check ~/.config/autostart and SysV init scripts

Recommended Systems: Linux Mint / Ubuntu 20.x (systemd-based)
Usage: ./sysbot.sh [option]

==============================================================
EOF
    read -p "Press Enter to return to menu..." _
}

# -----------------------------
#            MENU
# -----------------------------
menu() {
    while true; do
        banner
        echo -e "${BOLD}${CYAN}SysBot - Main Menu${RESET}"
        echo
        echo -e "${GREEN} 1)${RESET} Enabled boot services"
        echo -e "${GREEN} 2)${RESET} List ALL systemd services"
        echo -e "${GREEN} 3)${RESET} Running (active) services"
        echo -e "${GREEN} 4)${RESET} Failed services"
        echo -e "${GREEN} 5)${RESET} Boot time blame (systemd-analyze)"
        echo -e "${GREEN} 6)${RESET} Critical chain"
        echo -e "${GREEN} 7)${RESET} SysV service list"
        echo -e "${GREEN} 8)${RESET} Login autostart apps"
        echo
        echo -e "${MAGENTA} --- Service Control ---${RESET}"
        echo -e "${GREEN} 9)${RESET} Enable a service"
        echo -e "${GREEN} 10)${RESET} Disable a service"
        echo -e "${GREEN} 11)${RESET} Start a service"
        echo -e "${GREEN} 12)${RESET} Restart a service"
        echo -e "${GREEN} 13)${RESET} Stop a service"
        echo
        echo -e "${YELLOW} 14) Run SysBot as root (sudo)${RESET}"
        echo -e "${GREEN} 15) Exit${RESET}"
        echo
        read -p "Select an option: " choice

        case "$choice" in
            1) enabled_boot_services ;;
            2) all_services ;;
            3) running_services ;;
            4) failed_services ;;
            5) boot_blame ;;
            6) critical_chain ;;
            7) sysv_services ;;
            8) autostart_apps ;;
            9) service_enable ;;
            10) service_disable ;;
            11) service_start ;;
            12) service_restart ;;
            13) service_stop ;;
            14) run_as_root ;;
            15) clear; exit 0 ;;
            *) echo -e "${RED}Invalid choice.${RESET}"; sleep 1 ;;
        esac
    done
}

# -----------------------------
#         ARGUMENT HANDLING
# -----------------------------
case "$1" in
    -h|--help) show_help ;;
    -v|--version) echo "SysBot v1.0 - Service Inspection & Diagnostics Utility"; echo "Author: Rob Seaverns (K0NxT3D)"; exit 0 ;;
    -a|--about) about_sysbot ;;
    -m|--menu|"") menu ;;
    *) echo "Unknown option: $1"; exit 1 ;;
esac

# =====================================================================================
#  End of SysBot v1.0 Script
#  Thank you for using SysBot for Linux system diagnostics.
#  Author: Rob Seaverns (K0NxT3D)
#  Project: https://github.com/VOIDCRAWLER
# 
#   MIT License
#   Copyright (c) 2025 Rob Seaverns (K0NxT3D)
#
#   Permission is hereby granted, free of charge, to any person obtaining a copy
#   of this software and associated documentation files (the "Software"), to deal
#   in the Software without restriction, including without limitation the rights
#   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#   copies of the Software, and to permit persons to whom the Software is
#   furnished to do so, subject to the following conditions:
#
#   The above copyright notice and this permission notice shall be included in all
#   copies or substantial portions of the Software.
#
#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES, OR OTHER
#   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#   SOFTWARE.
# =====================================================================================

