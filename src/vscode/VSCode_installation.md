# VSCode installing for Ubuntu 22.04
+ Primero debemos actualizar el sistema operativo como buena práctica de la siguiente manera
```bash
    @prompt$ sudo apt update && sudo apt upgrade -y
```
+ Después, instalamos algunos paquetes que necesitamos, previo a la instalación del editor haciendo:
```bash
    @prompt$ sudo apt install software-properties-common apt-transport-https wget -y
```
+ Luego, tenemos que incluir el repositorio de *Visual Studio Code*, pero antes que eso debemos importar la clave *Microsoft GPG* para autenticar los paquetes instalados anteriormente. Todo esto lo hacemos con los camandos:
```bash
    @prompt$ wget -O- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vscode.gpg
    @prompt$ echo deb [arch=amd64 signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/vscode stable main | sudo tee /etc/apt/sources.list.d/vscode.list
```
+ Cuarto, actualizamos el sistema operativo corriendo el comando `@prompt$ sudo apt update`. Finalmente, instalamos el editor con el comando `@prompt$ sudo apt install code`.

# Referencias
+ [https://linuxhint.com/install-visual-studio-code-ubuntu22-04/](https://linuxhint.com/install-visual-studio-code-ubuntu22-04/)