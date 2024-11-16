# Run notebook from CCA using VSCode

Primero debemos hacer uso de las herramientas que nos provee OpenSSH para configurar las diferentes conecciones mediante SSH (todo esto funcionará siempre que usemos sistemas operativos Linux o macOS).

En general, el directorio `~/.ssh/` se crea automáticamente cuando corremos el comando `ssh` por primera vez. Aunque, si el directorio no existe en el sistema podemos crearlo mediante el comando:
```bash
    @prompt$: mkdir -p ~/.ssh && chmod 700 ~/.ssh
```

Por default, el archivo de configuración ssh no existe por ello debemo crearlo de la siguiente manera
```bash
    @prompt$ touch ~/.ssh/config
    @prompt$ chmod 600 ~/.ssh/config
```
donde le hemos dado permisos de lectura/escritura solamente al usuario.

Luego, en el archivo creado debemos agregar la siguiente línea:
```bash
    Host jupyterCCAD
        HostName  jupyter.ccad.unc.edu.ar
        User username
```

For more information check: [https://linuxize.com/post/using-the-ssh-config-file/](https://linuxize.com/post/using-the-ssh-config-file/)

La configuración anterior nos permite prescindir del script `.bash_aliases` y poder loguearnos al servidor de jupyter de CCAD corriendo el comando `@prompt$ ssh jupyterCCAD`


Ahora bien, debemos abrir VSCode (consultar [aquí](https://github.com/mendzmartin/Tutorials/blob/main/src/vscode/VSCode_installation.md) en caso de no tenerlo instalado) e instalar ((Ctrl+Shift+X)) las extenciones *Remote - SSH*. Luego abriendo la paleta de comandos (`Ctrl+Shift+P`) buscamos la opción `Remote-SSH: Connect to Host...` y seleccionamos el host `jupyterCCAD` que debería aparecernos en la lista desplegable.

Luego de esto, se nos abrirá una nueva sesión de VSCode y ya estaremos dentro del nodo de jupyter de CCAD para poder abrir cualquier archivo.

Para poder correr un notebook previamente creado debemos intalar (Ctrl+Shift+X) en `SSH:jupyterCCAD` las extensiones *Jupyter* y *Julia*. Luego de esto al abrir un notebook de Julia VSCode detectará automáticamente el kernel de julia (siempre que hayamos instalado julia dentro del nodo jupyterCCAD).

# Configure the Jupyter kernel

Para poder hacer visible el kernel de Julia para Jupyter es necesario instalar el paquete `IJulia`. Para ello, debemos abrir julia y ejecutar los siguientes comandos:
```julia
    julia> using Pkg
    julia> Pkg.add("IJulia")
```

Luego de esto, al abrir un notebook de Julia en VSCode deberíamos poder seleccionar el kernel de Julia en la parte superior derecha del notebook.