#!/bin/bash
# Define the new log file path
LOGFILE="/var/log/new_logfile1.log"
# Initialize log file
echo -e "Network Scan Report --- $(date)" >> "$LOGFILE"
nmap_open_scan() {
    echo -e "\nOpen Ports scanning using Nmap" >> "$LOGFILE"
    sudo nmap -sU -sF -p- $ip >> "$LOGFILE"
    echo -e "\nResult has been saved to logfile" >> "$LOGFILE"
    echo -e "- - - - - - - - - - - - - - - - - - - - -" >> "$LOGFILE"
    echo -e "\nResult has been saved to logfile"
}
common_ports_services_scan_nmap() {
    echo -e "\n\nScanning for common ports and services..." >> "$LOGFILE"
    sudo nmap -p20,21,22,23,53,443,3306,80 -sV -v $ip >> "$LOGFILE"
    echo -e "\nResult has been saved to logfile" >> "$LOGFILE"
    echo -e "- - - - - - - - - - - - - - - - - - - - -" >> "$LOGFILE"
    echo -e "\nResult has been saved to logfile"
}
status_check() {
    echo -e "\tSelect 1 for Checking Open Ports"
    echo -e "\tSelect 2 for Checking Closed Ports"
    read -r status
    if [ "$status" == "1" ]; then
        sudo grep 'open\|filtered' "$LOGFILE"
    elif [ "$status" == "2" ]; then
        sudo grep 'closed' "$LOGFILE"
    else
        echo -e "Wrong Choice"
    fi
    exit
}
scan_using_netstat() {
    echo -e "- - - - - - - - - - - - - - - - - - - - -" >> "$LOGFILE"
    echo "Scanning open ports with netstat..." >> "$LOGFILE"
    netstat -tuln | grep -E '^tcp|^udp' >> "$LOGFILE"
    echo -e "\nNetstat scan completed" >> "$LOGFILE"
    echo -e "\nResult has been saved to logfile"
    exit
}
scan_using_lsof() {
    echo "Scanning open ports and services with lsof..." >> "$LOGFILE"
    sudo lsof -i -P -n >> "$LOGFILE"
    echo "Data from lsof" >> "$LOGFILE"
    echo -e "- - - - - - - - - - - - - - - - - - - - -" >> "$LOGFILE"
    echo -e "\nResult has been saved to logfile"
}
services_with_uncommon_ports() {
    COMMON_PORTS=(22 80 443 3306 5432 6379 27017)
    # Log header
    echo -e "Uncommon Ports and Services\n" | tee -a "$LOGFILE"
    # Get the list of open ports
    open_ports=$(netstat -tuln | awk '/^tcp|^udp/ {print $4}' | sed 's/.*://')
    for port in $open_ports; do
        is_common=0
        for common_port in "${COMMON_PORTS[@]}"; do
            if [ "$port" -eq "$common_port" ]; then
                is_common=1
                break
            fi
        done
        if [ "$is_common" -eq 0 ]; then
            echo -e "\nUncommon port detected: $port" | tee -a "$LOGFILE"
            # Perform a quick nmap scan on the unusual port and display to the screen and log
            sudo nmap -p "$port" localhost | tee -a "$LOGFILE"
            echo -e "- - - - - - - - - - - - - - - - - - - - -" | tee -a "$LOGFILE"
        fi
    done
    echo -e "Ports added to logfile" | tee -a "$LOGFILE"
}
echo -e "\n"
echo -e "Enter an IP Address"
read ip
echo -e "Scanning by Nmap or by Linux/Windows Network Commands"
echo -e "Select 1 for Nmap Scanning"
echo -e "Select 2 for Network Utilities"
read -r method
if [ "$method" == "1" ]; then
    echo -e "<--------------You have Selected Nmap for Scanning--------------->"
    echo -e "\n\nWhat function do you want to perform?"
    echo -e "1: Nmap Open Port Scan"
    echo -e "2: Common Ports and Services Scan"
    echo -e "3: Ports Status and Services Running"
    read -r function
    if [ "$function" == "1" ]; then
        nmap_open_scan ip
        exit
    elif [ "$function" == "2" ]; then
        common_ports_services_scan_nmap ip
        exit
    elif [ "$function" == "3" ]; then
        status_check
        exit
    else
        echo -e "Wrong Choice"
        exit
    fi
elif [ "$method" == "2" ]; then
    echo -e "<--------------You have Selected Linux Network Utilities for Scanning--------------->"
    echo -e "\n\nWhat function do you want to perform?"
    echo -e "1: Scan Open Ports using netstat"
    echo -e "2: Scanning Using lsof"
    echo -e "3: Uncommon Ports Status and Services Running"
    read -r function
    if [ "$function" == "1" ]; then
        scan_using_netstat
        exit
    elif [ "$function" == "2" ]; then
        scan_using_lsof
        exit
    elif [ "$function" == "3" ]; then
        services_with_uncommon_ports
        exit
    else
        echo -e "Wrong Choice"
        exit
    fi
else
    echo -e "Wrong Choice"
fi