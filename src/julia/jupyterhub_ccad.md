# Guía de Uso: JupyterHub en el CCAD (UNC)

Este tutorial explica cómo configurar y utilizar **JupyterHub** en el cluster del CCAD, incluyendo la instalación de **Julia** y la configuración de kernels multihilo para computación científica.

## 1\. Configuración del Túnel SSH (Local)

Para acceder a la interfaz web, primero debés configurar un túnel en tu máquina local. Editá tu archivo `~/.ssh/config` y agregá:

```ssh
Host jupyterhubCCAD
    HostName jupyterhub.ccad.unc.edu.ar
    User tu_usuario_ccad
    LocalForward 8888 localhost:8888
    ServerAliveInterval 60
```

Luego, conectate desde la terminal:

```bash
ssh jupyterhubCCAD
```

## 2\. Acceso a la Plataforma

1.  Entrá a [https://jupyterhub.ccad.unc.edu.ar/](https://jupyterhub.ccad.unc.edu.ar/) e iniciá sesión.
2.  En **Server Options**, seleccioná el recurso según tu necesidad:
      * **Boogie:** Ideal para edición y cómputo general (AMD EPYC).
      * **Gordito:** Para tareas pesadas que requieran GPUs NVIDIA A30.
3.  Hacé clic en **Start**.

## 3\. Instalación de Julia en el Cluster

Una vez dentro de la terminal de JupyterHub, instalamos Julia usando el instalador oficial:

```bash
curl -fsSL https://install.julialang.org | sh
```

Para que el sistema reconozca el ejecutable permanentemente, editá tu perfil de Bash:

```bash
vi .bash_profile.sh
```

Agregá la siguiente línea (ajustando a la versión instalada):

```bash
export PATH="$PATH:~/.julia/juliaup/julia-1.12.5/bin"
```

## 4\. Configuración de Kernels Multihilo

Para aprovechar el paralelismo del cluster en tus Notebooks (útil para herramientas como `FEMTISE.jl`), configuraremos kernels con distintas capacidades de hilos:

Entrá a Julia en la terminal y ejecutá:

```julia
using Pkg
Pkg.add("IJulia")
using IJulia

# Instalación de kernels con diferentes hilos (threads)
IJulia.installkernel("julia_4threads", env=Dict("JULIA_NUM_THREADS" => "4"))
IJulia.installkernel("julia_8threads", env=Dict("JULIA_NUM_THREADS" => "8"))
IJulia.installkernel("julia_16threads", env=Dict("JULIA_NUM_THREADS" => "16"))
IJulia.installkernel("julia_32threads", env=Dict("JULIA_NUM_THREADS" => "32"))
```

## 5\. Uso de los Notebooks

Al crear un nuevo archivo o abrir uno existente, ahora podrás seleccionar en el menú superior derecho el kernel que mejor se adapte a tu simulación.

> **Tip:** Podés verificar que el kernel está usando los hilos correctos ejecutando `Threads.nthreads()` en una celda de Julia.

-----

**Autor:** Martin Mendez
**Afiliación:** FAMAF-UNC / IFEG-CONICET