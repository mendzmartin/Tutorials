# Instalación por primera vez
Una vez que que recibió el alta de la cuenta seguir estos pasos

Conectarse al servidor
```
ssh <user>@jupyter.ccad.unc.edu.ar
```

Instalar micromamba
```
curl micro.mamba.pm/install.sh | bash
```

Verificar que micromamba está instalado
```
micromamba env list
```
Debería listar el entorno base. Si no encuentra `micromamaba` salir y vover a conectarse.


Instalar Jupyter Lab en el entrno BASE
```
micromamba activate base
micromamba install -c conda-forge jupyterlab pip
```

# Crear uno o varios entornos específico (opcional)
Definir archivos environment.yml con los paquetes a instalar. Recomendamos instalar pip en todos los entornos
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
y luego crear el entorno
```
micromamba create -f environment.yml
```


# Conectarse

```
ssh <user>@jupyter.ccad.unc.edu.ar
[jupyter]$ micromamba:wq activate <nombre_entorno>   (opcinal)
[jupyter]$ jupyter notebook --no-browser --port 8888 --ip 0.0.0.0
...
[jupyter]$ exit (cierra la notebook)
```
Esto puede hacerce dentro de screen o tmux tambien

En otra consola establecer el tunel:
```
ssh -NL 1234:localhost:8888 <user>@jupyter.ccad.unc.edu.ar
<browser> localhost:1234/?token=...
```
con varios users hay que usar ${UID} como port ( en vez de 8888) o ver que hacemos

# TODO
actualizar un entorno es algo parecido a (ver micromamba):
```
mamba env upgrade --file environment.yml --prefix ~/some/path
```