# Opción 1
Una vez que recibimos el alta de la cuenta seguir los siguientes pasos:

+ Primero debemos conectarnos al servidor `@prompt$ ssh <user>@jupyter.ccad.unc.edu.ar`

+ Luego, instalamos micromamba `@[user@jupyterCCAD ~]$ curl micro.mamba.pm/install.sh | bash`, y verificamos que está instalando corriendo `@[user@jupyterCCAD ~]$ micromamba env list` que debería listar el entorno base. Si no encuentra `@[user@jupyterCCAD ~]$ micromamaba` salir y vover a conectarse al servidor.

+ Ahora, debemos instalar Jupyter Lab en el entrno BASE con:
```bash
  @[user@jupyterCCAD ~]$ micromamba activate base
  @[user@jupyterCCAD ~]$ micromamba install -c conda-forge jupyterlab pip
```

+ Luego podemos crear uno o varios entornos específicos (opcional), para ello debemos definir archivos environment.yml con los paquetes a instalar de la siguiente forma (se recomienda instalar pip en todos los entornos):
```yml
  name: nombre_entorno
  channels:
      - conda-forge
  dependencies:
    - python=3.11
    - numpy
    - pandas
    - matplotlib
    - seaborn
    - pip
    - pip:
      - scikit-learn
      - tensorflow==2.12.0
```

+ Creamos el entorno ejecutando `micromamba create -f environment.yml`.

+ Nos conectamos al servidor:
```bash
  @prompt$ ssh <user>@jupyter.ccad.unc.edu.ar
  @[user@jupyterCCAD ~]$ micromamba:wq activate <nombre_entorno>   (opcinal)
  @[user@jupyterCCAD ~]$ jupyter notebook --no-browser --port 8888 --ip 0.0.0.0
...

Lo anterior puede hacerce dentro de screen o tmux tambien.

+ En otra consola local establecer el tunel:
```bash
  @prompt$ ssh -NL 1234:localhost:8888 <user>@jupyter.ccad.unc.edu.ar
```
y en un buscador pegar los siguiente `localhost:1234/?token=...` (con varios users hay que usar ${UID} como port ( en vez de 8888) o ver que hacemos).

+ Actualizar un entorno es algo analogo al comando de mamba que sería (ver micromamba):
```
  @[user@jupyterCCAD ~]$ mamba env upgrade --file environment.yml --prefix ~/some/path
```


# Opción 2

+ Definir aliases en el .bashrc de tu maquina de escritorio. Te muestro los mios como ejemplo. El primero es para conectarse de la manera usual (lanzar scripts con sbatch, etc). El segundo es para conectarse para usar notebooks. Fijate que el comando especifica dos numeros de puertos. Vos proba con 8080. Uno especifica el puerto de comunicaciones que va a usar el cluster jupyterCCAD, y el otro el puerto que va a usar tu maquina.
```bash
alias jupyterCCAD='ssh user@jupyter.ccad.unc.edu.ar'
alias nodejupyterCCAD='ssh -L 8082:localhost:8082 user@jupyter.ccad.unc.edu.ar'
```

+ Una vez en el cluster bajamos la última versión de Julia. (si no tenemos instalado o actualizado Julia podemos consultar el tutorial aquí).

+ Luego, en el nodo de JupyterCCAD abrimos una terminal de Julia e instala los paquetes necesarios. En  particular, el paquete IJulia haciendo
```julia
    @[user@jupyterCCAD ~]$ julia
    
_       _ _(_)_     |  Documentation: https://docs.julialang.org
    (_)     | (_) (_)    |
    _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
    | | | | | | |/ _` |  |
    | | |_| | | | (_| |  |  Version 1.9.1 (2023-06-07)
    _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
    |__/                   |

    julia> using Pkg; Pkg.add("IJulia")
    julia> using IJulia; notebook(dir=pwd())
```
Probablemente cuando intentemos abrir una notebook en el cluster jupyterCCAD con el ùltimo comando nos pida instalar Jupyter y lo hacemos.

+ Una vez instalado el jupyter en el cluster jupyterCCAD, agregamos el siguiente alias al script `.bashrc` del cluster jupyterCCAD: `alias jnnb='~/.julia/conda/3/bin/jupyter notebook --no-browser --port=8082'`. Esto sirve para iniciar el jupyter que instala Julia en formato "no browser". 

+ Finalmente, tipeamos el alias en la terminal de bash del cluster jupyterCCAD para que levante un kernel de Jupyter con julia en modo "no browser". Esto deberia arrojarnos un link que debemos copiar y pegar en el browser de nuestra PC local, y de esta manera estaríamos conectàndonos con nuestro browser a la instancia de jupyter que levantamos en el cluster jupyterCCAD.