-----

# 💾 Linux Disk Space Troubleshooting Guide (`df -h` at 100%)

This guide assumes your root partition (`/dev/sda2` or `/`) is full.

## 1\. 🔍 Identify the Biggest Space Hogs

Use the `du` (disk usage) command to locate the directories consuming the most space.

1.  **Change directory to root:**

    ```bash
    cd /
    ```

2.  **Run `du` and sort the results:**

    ```bash
    sudo du -sh /* | sort -h
    ```

    *This lists the sizes of all top-level directories (e.g., `/var`, `/home`, `/usr`) in human-readable format, sorted by size.*

3.  **Drill down:** If `/var` shows a huge size, investigate it further:

    ```bash
    sudo du -sh /var/* | sort -h
    ```

    *Focus your cleanup efforts on the largest directories (often `/var/log` or `/home`).*

-----

## 2\. 🧹 Essential Cleanup Commands

The fastest way to free up gigabytes of space is usually by clearing system caches and logs.

### A. System Logs (`journalctl`)

The system journal can grow extremely large. Set a maximum size and remove the excess immediately.

  * **Clean logs, keeping the last 500MB (or less, if space is critical):**
    ```bash
    sudo journalctl --vacuum-size=500M
    ```
    *You can substitute `500M` with a lower value if needed.*

### B. Package Cache & Dependencies (Debian/Ubuntu)

Remove stored installation packages (`.deb` files) and unnecessary libraries/old kernels.

  * **Clear the package cache:**
    ```bash
    sudo apt clean
    ```
  * **Remove unused dependencies and old kernel files:**
    ```bash
    sudo apt autoremove --purge
    ```

### C. Find "Deleted but Open" Files

Files that have been deleted but are still being held open by a running process (like a large log file) still consume disk space.

1.  **List open deleted files:**
    ```bash
    sudo lsof | grep deleted
    ```
    *Note the **PID** (Process ID) and the file **NAME**.*
2.  **Truncate or restart:**
      * **Truncate (Clear contents) a log file** (safer than killing the process):
        ```bash
        sudo truncate -s 0 /path/to/large/log/file
        ```
      * **Restart the associated service** (e.g., `sudo systemctl restart nginx`).

-----

## 3\. ⚙️ Long-Term Prevention (Configure Log Limits)

Set a permanent size limit on your system journal to prevent future disk saturation.

1.  **Edit the configuration file:**

    ```bash
    sudo nano /etc/systemd/journald.conf
    ```

2.  **Set the maximum log usage** (e.g., to 1 Gigabyte) by adding/editing this line under the `[Journal]` section:

    ```ini
    SystemMaxUse=1G
    ```

3.  **Save, exit, and restart the service:**

    ```bash
    sudo systemctl restart systemd-journald
    ```

-----

## 4\. ✅ Final Check

Always confirm the fix by checking the available space:

```bash
df -h
```

*Goal: See the `/dev/sda2` usage percentage drop significantly.*