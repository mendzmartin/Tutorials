# Environments

_Una descripción de los entornos de Julia. TODO_

## Create new environments

Supongamos que queremos crear un entorno de Julia llamado `myenv`. Para hacerlo, hacemos lo siguiente:

1. Abrimos Julia en el directorio donde queremos crear el entorno.
```bash
    cd /path/to/directory
    julia
```

2. Abrimos el REPL de Julia y ejecutamos los siguientes comandos:
```julia
    ] # Para entrar al modo de paquetes
    activate myenv # Para crear el entorno
    st # Para ver los paquetes instalados, o bien en este caso para crear el archivo Project.toml
```julia	

3. Para salir del modo de paquetes, simplemente presionamos `backspace`.

Un entorno está definido esencialmente por dos archivos: `Project.toml` y `Manifest.toml`. El primero contiene la lista de paquetes que se han instalado en el entorno, mientras que el segundo contiene la lista de paquetes y sus dependencias.

Para activar un entorno de Julia, simplemente ejecutamos el siguiente comando en el REPL de Julia:
```julia
    ] # Para entrar al modo de paquetes
    activate myenv
```

Para desactivar un entorno de Julia, simplemente ejecutamos el siguiente comando en el REPL de Julia:
```julia
    ] # Para entrar al modo de paquetes
    activate
```

Para eliminar un entorno de Julia, simplemente eliminamos el directorio que contiene el entorno.

## Instalar paquetes en un entorno

Para instalar un paquete en un entorno de Julia, simplemente ejecutamos el siguiente comando en el REPL de Julia:
```julia
    ] # Para entrar al modo de paquetes
    add PackageName
```

Esto instalará el paquete `PackageName` en el entorno activo. Si estamos fuera de un entorno, el paquete se instalará en el entorno global. Ahora bien, si tenemos el paquete instalado únicamente en el entorno, esto no debería afectar al entorno global.

## Exportar un entorno

Para exportar un entorno de Julia, simplemente ejecutamos el siguiente comando en el REPL de Julia:
```julia
    ] # Para entrar al modo de paquetes
    activate myenv
    st # Para crear el archivo Project.toml
```

Esto creará un archivo `Project.toml` en el directorio del entorno. Este archivo contiene la lista de paquetes que se han instalado en el entorno. Para exportar también las dependencias de los paquetes, ejecutamos el siguiente comando en el REPL de Julia:
```julia
    ] # Para entrar al modo de paquetes
    activate myenv
    st # Para crear el archivo Project.toml
    instantiate
```

Esto creará un archivo `Manifest.toml` en el directorio del entorno. Este archivo contiene la lista de paquetes y sus dependencias.

Si queremos abrir este entorno en otra PC o en otro directorio, simplemente copiamos el directorio del entorno y ejecutamos el siguiente comando en el REPL de Julia:
```julia
    ] # Para entrar al modo de paquetes
    activate /path/to/directory/myenv
```

