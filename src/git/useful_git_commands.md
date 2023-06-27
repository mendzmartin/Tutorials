## Common git's commands
+ COMANDO `sudo apt install git`
  + `git --version` comando para ver qué versión de git está instalada
  + `git config --global user.name "tu_usuario"` configurar variable global usuario en local host
  + `git config --global user.email tu@email.com` configurar variable global email en local host
  + `git config --list` permite ver una lista de las configuraciones del git en el local host)
  + `git clone Link.git` crea una carpeta del repositorio que cloné, actua como rama local del repositorio remoto
  + `git branch nombrederama` crear una rama del repositorio que clone
  + `git branch` me dice en qué rama estoy posicionado
  + `git branch -l` me muestra una lista de las ramas que se crearon
  + `git checkout nombrederama` entrar a una determinada rama
  + `git status` permite chequear el estado del repositorio
  + `git add nombredelarchivo` permite agregar un archivo al staging area
  + `git restore --staged nombredelarchivo` permite remover un archivo del area de stage
  + `git commit -m "Comentario de qué se trata el commit"` permite comprometer los archivos, subirlos al repositorio creado
  + `git push` permite subir los commits desde tu rama local en tu repositorio git local al repositorio remoto
  + `git pull` actualizar tu repositorio local al commit más nuevo
  + `git log --online` conocer los codigos de los commits realizados
  + `git merge nombrederama` fusionar una rama con el repositorio master
  + `git help config` ver pagina del manual o manpage de git
  + `git config --help` ver pagina del manual o manpage de git
  + `git filter-branch -f --index-filter 'git rm --cached` Large files detected
    + --ignore-unmatch path_large_file_detected'
  + `man git config` ver pagina del manual o manpage de git
  + `ssh-keygen -t rsa` crea una clave de usuario para logearse a GitHub sin pedir clave)      
+ NOTA: crear documento de texto y guardarlo como `.gitignore` en la carpeta del repositorio, en él poner todos los archivos que queremos que git ignore.

# Clonning specific branch
Para clonar una rama específica de un repositorio remoto podemos correr el siguiente comando dentro del directorio donde queremos intalar: `@prompt$ git clone -b mybranch --single-branch git://sub.domain.com/repo.git`.