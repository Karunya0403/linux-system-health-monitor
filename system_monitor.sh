#!/bin/bash

show_cpu() {
    echo
    echo "===== CPU USAGE ====="
    top -bn1 | head -5
}

show_memory() {
    echo
    echo "===== MEMORY USAGE ====="
    free -h
}

show_disk() {
    echo
    echo "===== DISK USAGE ====="
    df -h
}

show_processes() {
    echo
    echo "===== TOP 5 PROCESSES ====="
    ps aux --sort=-%cpu | head -6
}

generate_report() {
    timestamp=$(date +"%Y_%m_%d_%H_%M_%S")
    filename="report_$timestamp.txt"

    echo "===== SYSTEM HEALTH REPORT =====" > "$filename"

    echo >> "$filename"
    echo "Generated On:" >> "$filename"
    date >> "$filename"

    echo >> "$filename"
    echo "===== CPU USAGE =====" >> "$filename"
    top -bn1 | head -5 >> "$filename"

    echo >> "$filename"
    echo "===== MEMORY USAGE =====" >> "$filename"
    free -h >> "$filename"

    echo >> "$filename"
    echo "===== DISK USAGE =====" >> "$filename"
    df -h >> "$filename"

    echo >> "$filename"
    echo "===== TOP 5 PROCESSES =====" >> "$filename"
    ps aux --sort=-%cpu | head -6 >> "$filename"

    echo
    echo "Report generated successfully!"
    echo "Saved as: $filename"
}

list_reports() {
    echo
    echo "===== SAVED REPORTS ====="
    ls -t report_*.txt 2>/dev/null
}

view_latest_report() {
    latest=$(ls -t report_*.txt 2>/dev/null | head -1)

    if [ -z "$latest" ]
    then
        echo "No reports found."
    else
        echo
        echo "===== LATEST REPORT ====="
        cat "$latest"
    fi
}

while true
do
    echo
    echo "===== SYSTEM HEALTH MONITOR ====="
    echo "1. CPU Usage"
    echo "2. Memory Usage"
    echo "3. Disk Usage"
    echo "4. Top 5 Processes"
    echo "5. Generate System Report"
    echo "6. List Saved Reports"
    echo "7. View Latest Report"
    echo "8. Exit"

    echo
    echo "Choose an option:"
    read choice

    case $choice in
        1)
            show_cpu
            ;;
        2)
            show_memory
            ;;
        3)
            show_disk
            ;;
        4)
            show_processes
            ;;
        5)
            generate_report
            ;;
        6)
            list_reports
            ;;
        7)
            view_latest_report
            ;;
        8)
            echo "Goodbye!"
            break
            ;;
        *)
            echo "Invalid choice"
            ;;
    esac
done
