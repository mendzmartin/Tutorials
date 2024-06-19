# Installing FileZilla on Ubuntu 22.04

FileZilla is available in the default Ubuntu repositories. You can install it using the APT package manager.

+ Open a terminal window.
+ Update the package list to ensure you have the latest information:

```bash
    @prompt$ sudo apt update
```

+ Install FileZilla:

```bash
    @prompt$ sudo apt install filezilla
```

+
  + Confirm the installation by typing 'Y' when prompted.
  + FileZilla is now installed on your Ubuntu 22.04 system.

+ Launching FileZilla:
You can launch FileZilla from the application menu or by running the following command in the terminal:

```bash
    @prompt$ filezilla
```

This will open the FileZilla FTP client, allowing you to connect to remote servers.

Please Note: It is recommended that you use the package manager of your distribution.

If you're using GNU/Linux, you can also try using the precompiled binaries. After extracting the files to any location (location does not matter, FileZilla can detect its own installation prefix), you can start the program using the filezilla executable in the bin/ subdirectory. Please note that due to differences in distributions, the provided binaries might not work on your system.

Alternatively you can also compile FileZilla from source.


## Reference source

+ [https://wiki.filezilla-project.org/Client_Installation](https://wiki.filezilla-project.org/Client_Installation)