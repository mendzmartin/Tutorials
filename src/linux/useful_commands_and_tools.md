# HERRAMIENTAS BÁSICAS DE LINUX

## LEER NOMBRE DE DISPOSITIVO Y NÚMERO DE MAC
+ NOMBRE DE DISPOSITIVO: Actividades > En buscador escribir "dispositivo"  >Abrir Configuraciones > Acerca de
+ NÚMERO DE MAC
+ NOTA: La MAC address (Media Access Control) es un identificador único del dispositivo o interfaz de red de una computadora. Se representa como una serie de 12 dígitos hexadecimales agrupados en pares.
```
	@prompt$: ifconfig -a > Interfaz inalámbrica "wlp3s0" > Valor de ether es la MAC adress
```
## SACAR CAPTURA DE PANTALLA
+ CAPTURA DE PANTALLA GENERAL: Apretar `Shift+Impr Pant` (la imágen se guarda en el directorio "Imágenes")

## INFORMAR DE DIA, MES Y HORA, MINUTOS SEGUNDOS
```
	@prompt$: date
	@prompt$: cal
	@prompt$: calendar
```
## CALCULADORA EN MODO CONSOLA
+ COMANDO `bc` al ingresar por consola este comando ya puedo hacer operaciones matemáticas
+ COMANDO `bc -l` al ingresar por consola este comando ya puedo hacer operaciones matemáticas
+ COMANDO `scale = numero` me permite definir con "numero" la cantidad de decimales con los que trabajar
+ COMANDO `quit` salgo del comando bc
	
## MOVIMIENTOS EN EL DIRECTORIO
+ COMANDO `cd nombredelacarpeta` dentro de la terminal ingreso a la carpeta especificada
  + `cd "nombre de carpeta"` caso en que el nombre tiene espacios entremedio
  + `cd /` acceder a la raiz del sistema de archivos
  + `cd ..` subir un nivel

  + COMANDO `mkdir nombredirectorio` crear un directorio
  + COMANDO `cp ../nombre_de_carpeta/* .` copiar "cp" del directorio anterior `../` la carpeta nombre_de_carpeta y todo su contenido `/*` en el lugar en donde estoy posicionado `.`
  + COMANDO `mv nombre_archivo/nombre_directorio /ruta` mover a otra carpeta
    + `mv nombre_archivo/nombre_directorio nombre_nuevo_archivo/nombre_nuevo_directorio` cambio de nombre
  + COMANDO `rm nombredirectorio` borrar un directorio que esté vacío
    + `rm -r nombredirectorio` borrar un directorio y su interior
	+ `rm *.c` borra todos los archivos con extensión ".c"	        
  + COMANDO `pwd` nos muestra la ubicación actual mostrando toda la ruta de directorios
  + COMANDO `ls` nos muestra el contenido del directorio en el que estamos posicionados
    + `sl` trencito jajajaja!
	+ `ls -a` nos muestra los archivos o directorios ocultos
	+ `ls -l` mostrara toda la información completa de cada archivo
	+ `ls -l /directorio` mostrar una lista larga del contenido del directorio actual
	+ `ls -R` veremos los subdirectorios que tenga cada directorio
  + COMANDO `Ctrl + H` mostrar archivos ocultos en un directorio
	
## IMPRIMIR ARCHIVOS POR CONSOLA
+ `cat <nombredelarchivo.extension>` permite crear, fusionar o imprimir archivos en la pantalla de salida estándar
		
## FORMATEAR PENDRIVE
+ COMANDO `df` para saber qué unidades están conectadas en el sistema
  + `sudo umount  /dev/sdaX` desmontar la unidad sdaX del sistema para que se pueda formatear
  + `sudo mkfs.vfat -F 32 -n "Nombre_pendrive_que_quiero" /dev/sdaX` formateo de la unidad sdaX en sistema de archivos Fat32

# HERRAMIENTAS TÉCNICAS BÁSICAS

+ COMANDO `sudo apt-get update && sudo apt-get upgrade` para actualizar el sistema operativo
+ `COMANDO hostname` me informa en qué host estoy, en qué maquina estoy trabajando
+ COMANDO `nm nombre-del-programa` me dice todas las funciones que utiliza el programa internamente y las direcciones de memoria
  + `grep MHz /proc/cpuinfo` me dice la frecuencia de los "nucleos" reales y threads
  + `watch -n 1 grep MHz /proc/cpuinfo` me dice la frecuencia de los "nucleos" reales y threads actualizada cada 1 segundo
  + `watch -d 1 grep MHz /proc/cpuinfo` me dice la frecuencia de los "nucleos" reales y threads actualizada cada 1 segundo, y temarca los cambios de dígitos en cada actualización
  + `echo off > /sys/devices/system/cpu/smt/control` deshabilita los threadsm, sólo me quedan los cores reales
  + `echo on > /sys/devices/system/cpu/smt/control` habilita los threads
  + `exit` salir de la terminal
  + `Cltr+d` salir de la terminal
				
## ENLACE DINÁMICO DE UNIX
+ COMANDO `ldd nombre_del_programa` me dice todas las bibliotecas de enlace dinámico que va a utilizar el programa
  + `LD_LIBRARY_PATH=opt/cuda` esto me permite cargar en opt/cuda ciertas bibliotecas de enlaces dinámicos

## INFORMACIÓN DEL MICROPROCESADOR DE LA MAQUINA
+ `x86info --cache` INFORMACIÓN SOBRE MEMORIA CACHE TLB

## TARJETA GRÁFICA (GPUs)
+ COMANDO `lspci | grep VGA` muestra tarjeta gráfica instalada
  + `lspci | grep -i NVIDIA` muestra los buspci express a los cuales está conectada cada placa y los modelos de dispositivos, gráficos y de audio
  + `inxi -Gx` muestra distintas características gráficas
+ NVIDIA
  + COMANDO nvidia-smi nos permite fijarnos si está ocupada o no la GPU
    + `nvidia-smi -a` lo mismo que el anterior pero con más detalles
    + `nvidia-smi dmon -s puct` muestra en tiempo real datos de las GPUs, potencia, temperatura, etc.

## ACTIVIDAD DE LA MAQUINA, A NIVEL MUY GENERAL
+ COMANDO htop
	
## TOPOLOGÍA DE PROCESAMIENTO, MEMORIA Y BASE
+ COMANDO `lstopo`
+ COMANDO `lscpu` INFO DE LA ARQUITECTURA Y DATOS DE LA MAQUINA
+ COMANDO `free -m` información sobre la RAM, total, usada, libre y reservada. Información sobre la swap
	
## SISTEMA OPERATIVO UBUNTU
+ COMANDO `lsb_release -a` conocer la versión de Ubuntu que estás ejecutando

## MAN PAGES DE DIFERENTES FUNCIONES QUE ESTAN EN LA LIBRERIA DE C
+ COMANDO `man memset` esto me muestra la hoja de especificaciones de la función memset

# COMPILADORES
## `gcc` (suit de compiladores de GNU para C)
+ guardar el archivo con el formato "ejemplo.c". Entrar en la términal, ubicada en el directorio del archivo.
+ COMANDO `gcc ejemplo.c` ejecuta el archivo
  + `./a.out` muestra los resultados
  + `gcc --version` consultar versión del compilador instalado
  + `mpicc --version` consultar versión del compilador instalado
  + `gcc -c -fdump-tree-gimple programa.c` genera representación intermedia GIMPLE de programa.c
  + `gcc -S programa.c` genera código assembler
  + `sudo ls -la /usr/bin | grep gcc-XX` nos muestra cuántas y qué versiones de gcc-XX están instaladas en nuestro sistema
    + `sudo rm /usr/bin/gcc` borramos enlaces simbolicos que apuntan a una dirección en concreto
	+ `sudo ln -s /usr/bin/gcc-XX /usr/bin/gcc` creamos enlaces simbolicos con versión que queremos que sea por default
  + FLAGS
    + `-ffast-math`
	+ `-ftree-vectorize` autovectorización
	+ `-fopt-info-vec` para ver si pudo vectorizar
	+ `-fopt-info-vec-missed` para ver qué no pudo vectorizar
	+ `-fopt-info-vec-note` info sobre loops no vectorizados
	+ `-fopt-info-vec-all` info detallada
	+ `-O3` optimización. Incluye vectorización pero dificulta lectura de assembler
	
## g++ (suit de compiladores de GNU para C++)
+ COMANDO `sudo apt install g++` instala g++
	
## clang (suit de compiladores de LLVM)
+ COMANDO `sudo apt install clang` instalar el paquete de compilación clang
+ FLAGS
  + `-ffast-math`
  + `-fno-vectorize` deshabilita autovectorización
  + `-Rpass=loop-vectorize` identifica loops vectorizados
  + `-Rpass=missed=loop-vectorize` identifica loops no vectorizados
  + `-Rpass-analysis=loop-vectorize` identifica por que fallo vectorización
  + `-Rpass-analysis=loop-vectorize-fsave-optimization-record` enumera múltiples causas de falla de vectorización
				
## icx (suit de compiladores de INTEL-CLANG)
  + COMANDO `source /opt/intel/oneapi/setvars.sh` para instalar
	
## icc (suit de compiladores de INTEL)
	
## BASH
+ COMANDO `objdump -d --disassembler-options=intel tiny_mc` genera codigo assembler a partir del ejecutable
+ `chmod +x myscript` darle al archivo myscript permisos de ejecución, luego ejecutar con ./myscript

## SHELL
+ COMANDO `export PS1="algo"` me redefine la variable de entorno PS1 y modifica el prompt del shell
	+ `unset PS1` borra la variable entorno PS1.

## ISPC
+ COMANDO `--target` te dice para qué arquitecturas compilar SSE, AVX, AVX512, etc.
    
## NUMA (tiene sentido usarlo en servidores)
+ COMANDO `sudo apt install numactl` instalar numactl
  + `numactl --hardware` muestra como se distribuyen los nodos y sus distancias
  + `numatop`
                
## OpenMP y OpenMPI
+ COMANDO `sudo apt-get install libomp-dev` instalar libreria de OpenMP
+ COMANDO `sudo apt-get update -y` y luego `sudo apt-get install -y openmpi-bin` instalar paquete de OpenMPI

# PROGAMAS

## GIMP (editor de imágenes)
+ COMANDO `sudo apt-get install gimp` comando para instalar el paquete del editor GIMP, GNU Image Manipulation Program
		
## VIM (editor de texto)
+ COMANDO `sudo apt-get update && sudo apt-get install vim` para instalación
```
	i 		(para ingresar al modo de edición)
	v       (para ingresar al modo de vision)
	:wq     (para guardar-write y salir-quit)
	dd      (cortar una línea)
	$d      (cortar desde una posición dada dentro de una línea hasta el final de la misma)
	Xdd     (cortar más de una línea, debemos anteponer el número de líneas deseado (X) a dd)
	yy      (copiar una línea)
	$y      (copiar desde una posición dada dentro de una línea hasta el final de la misma)
	Xyy     (copiar más de una línea, debemos anteponer el número de líneas deseado (X) a yy)
	p       (pegar una línea debajo de la línea actual)
	P       (pegar una línea envimaí de la lnea actual)
	Esc+u   (deshacer los cambios realizados)
```

## SPYDER
+ COMANDO `sudo apt install spyder` comando para instalar entorno interactivo Spyder
+ `sudo apt remove spyder && sudo apt autoremove` comando para desinstalar el entrono interactivo Spyder
		
## MESON
+ COMANDO `pip3 install --user meson` instalar el paquete meson en el home
  + `pip3 install --user ninja` instala el paquete ninja en el home
  + `meson setup directorio` configura un proyecto, especificando directorio donde se compila y guarda el ejecutable
  + `meson compile` decirle a meson que compile, leyendo parámetros de meson.build
  + `meson compile --clean` borra los contenidos que genero al compilar
  + `meson compile -v` nos muestra más información de los parametros que corrió meson
		
## MAKE
+ COMANDO `make` decir a make que compile, leyendo parametros de Makefile
  + `make clean` borra los contenidos que generó al compilar
		        
## PERF
+ COMANDO `perf stat -M FLOPS ./nombre` arroja una medida de los FLOPS Y FLOPC al correr el programa nombre
  + `perf list metricgroup` arroja una lista de grupos de eventos
  + `perf record ./nombre` el profile se fija de qué forma distribuye el tiempo el programa nombre
    + `perf report` una vez hecho `perf record ./nombre` me puedo fijar en el reporte del profile
  + `perf stat -e cycles,instructions,cache-references,cache-misses -r 20 ./tiny_mc` script para correr 20 veces y hacer perf
  + `perf c2c record ./nombre` false sharing
  + `perf top` muestra el overhead
+ COMMAND `sysctl kernel.perf_event_paranoid` check default value
  + `sudo sh -c 'echo -1 >/proc/sys/kernel/perf_event_paranoid'` set new value
		
## PYHTON
+ COMANDO `sudo apt install pythonXX` instala paquete de python
  + `pythonXX --version`
  + `python` entrar al interprete de python
  + `Clt+D` salir del interprete de python
		        
## OPEN MPI
+ COMANDO `mpirun --version` consultar versión de MPI
## GNUPLOT
+ COMANDO `sudo apt install gnuplot-qt` instalar paquete
+ COMANDO `gnuplot` permite entrar a la interfaz de genuplot
	
## CURL ( "browser de internet" que tira requests http para bajar cosas)
+ COMANDO sudo apt install curl
  + SCRIPT `/bin/bash -c "$(curl -fsSL link_URL_de_la_pagina_web)"`
		
## JAVA
+ COMANDO `sudo apt-get install default-jdk` Instala Java
  + `sudo apt-get install default-jre` Instala el entorno de ejecución
  + `java --version` consultar versión de Java instalada
  + `sudo update-alternatives --config java` nos muestra las diferentes versiones de Java instaladas
  + `java -jar nombre_del_programa.jar`
	
## TELEGRAM
+ COMANDO `sudo  apt install telegram-desktop`
	
## MATHCHA NOTEBOOK
+ COMANDO `sudo snap install math-notebook` instalación
		
	
## SLURM
+ COMANDO `squeue -l` lista los trabajos en ejecución y espera
  + `sinfo` muestra estado de los nodos de cada partición
  + `scancel JOB_ID` cancela un trabajo
  + `slurm j JOB_ID` muestra detalles de un trabajo
    
## KEEPASS
+ COMANDO `sudo apt-add-repository ppa:jtaylor/keepass` agregar repositorio KeePass a Linux
  + `sudo apt-get update && sudo apt-get upgrade` actualización apt
  + `sudo apt-get install keepass2 -y` Install KeePass
  + `keepass2 --version` check version
  + `cd /usr/lib/keepass2` ingresar a directorio
    + `sudo mkdir Languages` crear carpeta de idiomas
                
+ Desde la página [https://keepass.info/translations.html](https://keepass.info/translations.html) podemos descargar paquete de idioma español, descomprimir y obtener `Spanish.lngx`.
+ COMANDO `sudo mv Spanish.lngx cd /usr/lib/keepass2/Languages` agregar paquete de idiomas a keepass
+ References
  + [https://keepass.es/](https://keepass.es/)
  + [https://www.taringa.net/+comunidad_gnu_linux/instalar-keepass-2_1erv0o](https://www.taringa.net/+comunidad_gnu_linux/instalar-keepass-2_1erv0o)
  + [https://keepass.info/download.html](https://keepass.info/download.html)
  + [https://linuxhint.com/install_keepass_ubuntu/](https://linuxhint.com/install_keepass_ubuntu/)
	
## UNetbootin
+ COMANDO `sudo add-apt-repository ppa:gezakovacs/ppa`
  + `sudo apt-get update && sudo apt-get install unetbootin`
				
## Kate
+ COMANDO `sudo apt-get update && sudo apt-get install kate`
	
## Okular
+ COMANDO `sudo apt-get update && sudo apt-get install okular`
                    
# JUEGOS
## supertuxkart-juego-clasico-ubuntu
+ [https://github.com/supertuxkart/stk-code/releases/tag/1.2](https://github.com/supertuxkart/stk-code/releases/tag/1.2) repositorio para descargar comprimidos
+ [https://ubunlog.com/supertuxkart-juego-clasico-ubuntu/](https://ubunlog.com/supertuxkart-juego-clasico-ubuntu/) blog de ayuda
+ COMANDO `sudo sh run_game.sh` ejecutar el script para jugar


# BUGS LINUX

## Error en la BIOS initramfs ubuntu
```bash
	/dev/sda5: ***** FILE SYSTEM WAS MODIFIED *****
	/dev/sda5: 491715/3022848 files (0.7% non-contiguous), 8643760/1207508 blockss
```

+ COMANDO `fsck -f /dev/sdaX` hay que cambiar la X por la partición que requiera chequeo
+ References:
  + [https://slimbook.es/tutoriales/linux/315-error-initramfs-como-arreglarlo](https://slimbook.es/tutoriales/linux/315-error-initramfs-como-arreglarlo)