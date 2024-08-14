# Instructitions to install operative system from a bootable pendrive

## Download ISO
Download `*.iso` file of operative system from oficial web page. If you want to install Ubuntu operative system check following web page to find download file [https://ubuntu.com/download/desktop](https://ubuntu.com/download/desktop).

## Intall Startup Disk Creator

Now, and if we not have installed Startup Disk Creator yet, we need to install the software which we need to use to make a bootable pendrive. Run in terminal those commands (first two are optional, to update the repos, and upgrade what should be upgraded, but if you just want to make pendrive with installer, just skip to the third line):

```bash
    @prompt: sudo apt update
    @prompt: sudo apt upgrade
    @prompt: sudo apt install usb-creator-gtk
```

Then you may also start this from terminal:
```bash
    @prompt: usb-creator-gtk
```

## Launch Startup Disk Creator
We’re going to use an application called ‘Startup Disk Creator’ to write the ISO image to your USB stick. This is installed by default on Ubuntu, and can be launched as follows:

+ Insert your USB stick (select ‘Do nothing’ if prompted by Ubuntu).
+ On Ubuntu 18.04 and later, use the bottom left icon to open ‘Show Applications’.
+ In older versions of Ubuntu, use the top left icon to open the dash
+ Use the search field to look for Startup Disk Creator
+ Select Startup Disk Creator from the results to launch the application

## ISO and USB selection

When launched, Startup Disk Creator will look for the ISO files in your Downloads folder, as well as any attached USB storage it can write to.

It’s likely that both your Ubuntu ISO and the correct USB device will have been detected and set as ‘Source disc image’ and ‘Disk to use’ in the application window. If not, use the ‘Other’ button to locate your ISO file and select the exact USB device you want to use from the list of devices.

Click Make Startup Disk to start the process.

## Confirm USB device

Before making any permanent changes, you will be asked to confirm the USB device you’ve chosen is correct. This is important because any data currently stored on this device will be destroyed.

After confirming, the write process will start and a progress bar appears.

## Installation complete

That’s it! You now have Ubuntu on a USB stick, bootable and ready to go.


# References
+ [https://discourse.ubuntu.com/t/create-a-bootable-usb-stick-on-ubuntu/14011](https://discourse.ubuntu.com/t/create-a-bootable-usb-stick-on-ubuntu/14011)
+ [https://askubuntu.com/questions/952385/how-can-i-install-startup-disk-creator-on-ubuntu-17-04](https://askubuntu.com/questions/952385/how-can-i-install-startup-disk-creator-on-ubuntu-17-04)
+ [https://askubuntu.com/questions/22381/how-to-format-a-usb-flash-drive](https://askubuntu.com/questions/22381/how-to-format-a-usb-flash-drive)
+ [https://unetbootin.github.io/#features](https://unetbootin.github.io/#features)
+ [https://ubuntu.com/download/desktop](https://ubuntu.com/download/desktop)