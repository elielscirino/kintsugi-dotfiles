#!/usr/bin/env python3
import subprocess
import time

def get_workspaces_per_monitor():
    try:
        # Get workspace info for all monitors
        output = subprocess.run(
            "hyprctl monitors",
            shell=True, capture_output=True, text=True
        )
        return output.stdout.strip().split("\n")
    except Exception:
        return []

def main():
    last_workspaces = {}

    while True:
        current_workspaces = get_workspaces_per_monitor()

        # Process each line to extract workspace and monitor information
        for line in current_workspaces:
            if "active workspace:" in line:
                try:
                    # Extract workspace number after "active workspace: "
                    workspace_id = line.split("active workspace: ")[1].split(" ")[0]
                    
                    # Check if line contains the "Monitor " string
                    if "Monitor " in line:
                        monitor_id = line.split("Monitor ")[1].split(":")[0]  # Extract monitor ID
                    else:
                        continue  # Skip this line if it doesn't contain monitor info
                    
                    if monitor_id not in last_workspaces or last_workspaces[monitor_id] != workspace_id:
                        print(f"{monitor_id}: {workspace_id}")  # Output the monitor and workspace number
                        last_workspaces[monitor_id] = workspace_id  # Track the workspace number for each monitor
                except IndexError:
                    # Handle any potential errors due to unexpected format
                    continue

        time.sleep(0.1)

if __name__ == "__main__":
    main()
