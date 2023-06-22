# Instalación de Julia

Dentro de nuestro usuario de CCAD debemos instalar Julia. Esto lo hacemos desde la página oficial de Julia como sigue:

+ Ingresamos a la página de descargas oficial [https://julialang.org/downloads/](https://julialang.org/downloads/) y seleccionamos el el archivo comprimido *Generic Linux on x86 - 64-bit*. Esto nos descargará un archivo comprimido con el nombre `julia-1.9.1-linux-x86_64.tar.gz`.

+ Para instalar este archivo comprimido y descomprimirlo desde CCAD podemos hacer los siguiente: 
```
    @[user@serafin ~]$ wget https://julialang-s3.julialang.org/bin/linux/x64/1.9/julia-1.9.1-linux-x86_64.tar.gz
    @[user@serafin ~]$ tar zxvf julia-1.9.1-linux-x86_64.tar.gz
```

+ Lo anterior nos creará una carpeta denominada `julia-1.9.1`.

Ya tenemos instalado Julia en CCAD pues, si hacemos los siguientes pasos podremos abrir el REPL de Julia:
```
    @[user@serafin ~]$ cd julia-1.9.1/bin/
    @[user@serafin bin]$ ./julia
    
_       _ _(_)_     |  Documentation: https://docs.julialang.org
    (_)     | (_) (_)    |
    _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
    | | | | | | |/ _` |  |
    | | |_| | | | (_| |  |  Version 1.9.1 (2023-06-07)
    _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
    |__/                   |

    julia>
```

Sin embargo, para poder correr julia simplemente ejecutando `@propt$ julia` desde cualquier ubicación dentro de CCAD debemos setear las variables de entorno según su ubicación específica dentro de CCAD como sigue:

+ Abrimos el uno de los script de Bash para definir las configuraciones del sistema ejecutando `[user@serafin ~]$ vi .bash_profile` y agregamos la siguiente linea dentro del script `export PATH="$PATH:~/julia-1.9.1/bin"`. Luego, para que se hagan efectivos los cambios debemos cerrar la sesión de CCAD e ingresar nuevamente. Luego podemos abrir el REPL de julia simplemente ejecutando desde cualquier ubicación lo siguiente:
```
    @[user@serafin ~]$ julia
    
_       _ _(_)_     |  Documentation: https://docs.julialang.org
    (_)     | (_) (_)    |
    _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
    | | | | | | |/ _` |  |
    | | |_| | | | (_| |  |  Version 1.9.1 (2023-06-07)
    _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
    |__/                   |

    julia>
```

# Actualizar versión de Julia desde el REPL

Julia agregó una función nueva para actualizar las versiones de Julia si ya tenemos instalado previamente una versión antigua, para ello debemos abrir el REPL de Julia y ejectuar los siguientes comandos:

```
    @[user@serafin ~]$ julia
    
_       _ _(_)_     |  Documentation: https://docs.julialang.org
    (_)     | (_) (_)    |
    _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
    | | | | | | |/ _` |  |
    | | |_| | | | (_| |  |  Version 1.9.1 (2023-06-07)
    _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
    |__/                   |

    julia> ]add UpdateJulia
    julia> using UpdateJulia
    julia> update_julia()
```

Esto nos descargá una versión nueva de Julia y debemos luego modificar el script `bash_profile` con la nueva versión, tal como se mencionó anteriormente.