# How can I upgrade Visual Studio Code?

1) Download the latest Visual Studio Code (.deb) package to your computer on this link:

[https://go.microsoft.com/fwlink/?LinkID=760868](https://go.microsoft.com/fwlink/?LinkID=760868)

, or this there: [Getting Started](https://code.visualstudio.com/docs/)

2) then open a terminal in the folder where you downloaded the .deb file and write:

```bash
sudo dpkg -i <the downloaded file>.deb
```

3) finally, if you have apt-get, do (if not, install apt-get first):

```bash
sudo apt-get install -f
```