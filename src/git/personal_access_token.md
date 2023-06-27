# Personal access token configuration
Si tenemos una clave token generada previamente en GitHub podemos realizar una configuración para que cada vez que hagamos pushing nos detecte automáticamente usuario y contraseña. Para ello debemos modificar el archivo de configuraciones del repositorio una vez clonado haciendo `@prompt$ vi my_repository/.git/config` y modificando la siguiente linea de script `url = https://token_key@github.com/user/repositoryname`.

More information about
+ [https://stackoverflow.com/questions/68775869/message-support-for-password-authentication-was-removed-please-use-a-personal](https://stackoverflow.com/questions/68775869/message-support-for-password-authentication-was-removed-please-use-a-personal)


# References
+ [https://docs.github.com/en](https://docs.github.com/en)
+ [https://rogerdudler.github.io/git-guide/index.es.html](https://rogerdudler.github.io/git-guide/index.es.html)