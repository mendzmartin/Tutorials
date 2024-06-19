# Howto

## SFTP using SSH-2: Key based authentication

Our Knowledge Base includes a step-by-step guide and video tutorial on how to set up SFTP.

There are three mechanisms for use of the FileZilla client with SSH-2 keys.

In the profile settings in the Site Manager of the FileZilla client. If the SFTP Protocol is specified, it is possible to specify the Logon Type as "Key File" and specify the location of the private key file (in PuTTY's .ppk or OpenSSH's .pem format). The user is prompted for the key file's password if necessary, which may optionally be cached by FileZilla until it is next shut down.
In the Edit → Settings menu of the FileZilla client, you can [Add key file...] under Connection → SFTP, and FileZilla can then use the public key authentication in the site manager with the 'Interactive' Logontype on connection. Note: Importing a site's public key is not supported.
(Windows only) Using the excellent PuTTY tools. To allow the use of RSA / DSA key files with FileZilla, you'll need to download two more tools from PuTTY: Pageant and (assuming your key file isn't already in PPK format) PuTTYgen.

## Generate the SSH key

FileZilla can use an existing SSH key, but it cannot generate the SSH key itself. You can generate an SSH key with PuTTY or OpenSSH. (Now OpenSSH is built-in in Windows.)

PuTTY: use the GUI program PuTTYgen to generate an SSH key.
OpenSSH: open cmd.exe or PowerShell, and type command

```bash
@prompt$ ssh-keygen -t rsa -b 2048 -f my-ssh-key`
```

It will generate a private key, my-ssh-key, and a public key, `my-ssh-key.pub`.
After generating a new key, you need to add the public key to the file `~/.ssh/authorized_keys`, or contact the system administrator, and then you can log in with the private key.

## Reference source

+ [https://wiki.filezilla-project.org/Client_Installation](https://wiki.filezilla-project.org/Howto)
+ [https://github.com/mendzmartin/Tutorials/blob/main/src/linux/OpenSSH.md](https://github.com/mendzmartin/Tutorials/blob/main/src/linux/OpenSSH.md)