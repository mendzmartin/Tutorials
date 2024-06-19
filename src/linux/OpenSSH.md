# OpenSSH configuration

Primero debemos hacer uso de las herramientas que nos provee OpenSSH para configurar las diferentes conecciones mediante SSH (todo esto funcionará siempre que usemos sistemas operativos Linux o macOS).

En general, el directorio ~/.ssh/ se crea automáticamente cuando corremos el comando ssh por primera vez. Aunque, si el directorio no existe en el sistema podemos crearlo mediante el comando:

```bash
    @prompt$ mkdir -p ~/.ssh && chmod 700 ~/.ssh
```

Por default, el archivo de configuración ssh no existe por ello debemo crearlo de la siguiente manera

```bash
    @prompt$ touch ~/.ssh/config
    @prompt$ chmod 600 ~/.ssh/config
```

donde le hemos dado permisos de lectura/escritura solamente al usuario.

Luego, en el archivo creado debemos agregar la siguiente línea (es un ejemplo):

```bash
    Host jupyterCCAD
        HostName  jupyter.ccad.unc.edu.ar
        User username
```

For more information check: [https://linuxize.com/post/using-the-ssh-config-file/](https://linuxize.com/post/using-the-ssh-config-file/)