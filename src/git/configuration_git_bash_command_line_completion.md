Posiblemente al correr comandos de `git` dentro del cluster nos funcionen pero al apretar `TAB` cocasionalmente para utilizar el autocompletado de los comandos no podamos. Para ello, debemos localizar el siguiente archivo dentro del cluster,

```
    @prompt$: /usr/share/bash-completion/completions/git
```

Si este archivo exite simplemente debemos modificar el script de BASH `.bashrc` y agregar la siguiente linea:
```
    source /usr/share/bash-completion/completions/git
```
Otra opción podría ser agregar la siguiente linea que permite al sistema localizar el archivo anterior
```
    source "$(pkg-config --variable=completionsdir bash-completion)"/git
```

Referencias
+ [https://stackoverflow.com/questions/12399002/how-to-configure-git-bash-command-line-completion](https://stackoverflow.com/questions/12399002/how-to-configure-git-bash-command-line-completion)