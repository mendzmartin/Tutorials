# Cómo ejecutar programas de julia en CCAD?

# Instalación de Julia desde CCAD

Primeramente debemos crearnos una cuenta de CCAD. Esta cuenta viene asociada con un hardware específico (pc que especificamos al momento de crearnos la cuenta de CCAD con una public key) donde podremos iniciar loggearnos y ejecutar dentro de CCAD.

+ Ingresamos corriendo lo siguiente dentro una terminal desde nuestra PC especifica
```
    @prompt$ ssh user@serafin.ccad.unc.edu.ar
```

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

+ Abrimos el uno de los script de Bash para definir las configuraciones del sistema ejecutando `[user@serafin ~]$ vi .bash_profile` y agregamos la siguiente linea dentro del script `export PATH="$PATH:/home/martinmendez/julia-1.9.1/bin"`. Luego, para que se hagan efectivos los cambios debemos cerrar la sesión de CCAD e ingresar nuevamente. Luego podemos abrir el REPL de julia simplemente ejecutando desde cualquier ubicación lo siguiente:
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

# Gestor de colas SLURM

Bien ya tenemos instalado y configurado correctamente Julia. Ahora, para poder correr un programa cualesquiera dentro de CCAD debemos crear un script para encolar el mismo mediante el sistema de gestor de colas SLURM. Podemos simplemente agregar un script con extensión *.sh (supongamos que este script lo llamamos `script_slurm.sh`) y dentro de el escribir lo siguiente:

```
    #!/bin/bash
    
    # Metadatos para ejecutar con slurm
    # Nombre para identificar el trabajo. Por defecto es el nombre del script
    #SBATCH --job-name=test
    #SBATCH --output=output_test.log
    #SBATCH --partition=multi
    # Solicita N cores, por defecto se asignan consecutivamente dentro de un nodo. Si N excede la cantidad de cores continúa en otro nodo
    #SBATCH --ntasks-per-node=1
    # Especifico en cuantos hilos correra cada uno de los procesos anteriores
    #SBATCH --cpus-per-task=1
    # Especifico que no quiero a nadie más en el nodo cuando corra esta tarea (con doble # comentamos)
    ##SBATCH --exclusive
    # Envía un correo cuando el trabajo finaliza correctamente o por algún error
    #SBATCH --mail-type=END
    #SBATCH --mail-user=user@mi.unc.edu.ar
    # La linea siguiente es ignorada por Slurm porque empieza con ##
    ##SBATCH --mem-per-cpu=4G # cantidad de memoria por core
    
    # comando a ejecutar
    srun julia location_path/code.jl
```

Ahora bien, para correr el código `code.jl` debemos ejecutar el comando `@[user@serafin ~]$ sbatch script.sh` y luego, podremos ver el estado de nuestro trabajo consultando el gestor de cola con el siguiente comando: `squeue --me`. 

# Notas adicionales

Si nuestro codigo `code.jl` usa paquetes específicos es conveniente crear un environment asociado a este código que contenga dichos paquetes y, cada vez que querramos ejecutar el código simplemente activando el environmente podremos hacerlo. Esto se hace de la siguiente manera:

+  Supongamos que `code.jl` utiliza los paquetes Plots y DifferentialEquations. Entonces no dirigimos a la carpeta que contiene el archivo a ejectuar y ejecutamos los siguientes comando
```
    @[user@serafin ~]$ cd location_path/
    @[user@serafin location_path]$ julia
    
_       _ _(_)_     |  Documentation: https://docs.julialang.org
    (_)     | (_) (_)    |
    _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
    | | | | | | |/ _` |  |
    | | |_| | | | (_| |  |  Version 1.9.1 (2023-06-07)
    _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
    |__/                   |

    julia> using Pkg
    julia> Pkg.activate(".")
    julia> Pkg.add("Plots")
    julia> Pkg.add("DifferentialEquations")
    julia> Pkg.status()
        Status `~/prueb_julia/Project.toml`
        [0c46a032] DifferentialEquations v7.8.0
        [91a5bcdd] Plots v1.38.16
```

+ Los pasos anteriores nos generan dos archivos `Manifest.toml` (contiene especificacones exactas de todas las dependencias directas y recursivas de nuestro proyecto) y `Project.toml` (lista la información escencial acerca de las dependencias directas).

+ Luego, si agregamos la linea `using Pkg; Pkg.activate(".");` en nuestro código `code.jl` cada ve que se se ejecuta activa el su environment específico y utiliza los paquetes instalados allí dentro.