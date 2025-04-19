# Problemas con MCTDH y cómo solucionarlos

> Reporte por: Mendez Martin

## Problem
Al momento de instalar y compilar MCTDH haciendo
```bash
    user@prompt:~$ cdm
    user@prompt:~$ cd install/
    user@prompt:~$ ./install_mctdh
    user@prompt:~$ compile -A mctdh
```
y luego de que los resultados de corridas, tanto de instalación como de compilación, resulten exitosos, al momento de ejecutar el comando mctdhXX el paquete arrojaba el siguiente error:

```bash
    user@prompt:~$ mtdhXX
        ###########################################
        ###  --- no pthread_mutex_lock command ---
        ###  pthread library not linked!
        ###  If your compiler supports pthread,
        ###  modify the script compile.cnf
        ###########################################
```
Debido al mensaje de error detectamos que el problema se debe al linkeo de la libreria phtread.

### Debugging
Una forma rápida de entender este problema sería asegurarnos de que el código objeto (binario) utiliza (o no) los linkeos correspondientes a la librería pthread, para ello ejecutamos el siguiente comando:

```bash
	user@prompt:~$ cdm
	user@prompt:~$ ldd bin/binary/x86_64/mctdhXX
		linux-vdso.so.1 (0x00007ffe51dd4000)
		libgfortran.so.5 => /lib/x86_64-linux-gnu/libgfortran.so.5 (0x00007f1779dc1000)
		libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f1779cda000)
		libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007f1779cba000)
		libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f1779a92000)
		libquadmath.so.0 => /lib/x86_64-linux-gnu/libquadmath.so.0 (0x00007f1779a48000)
		/lib64/ld-linux-x86-64.so.2 (0x00007f179307e000)
```

y, efectivamente, notamos que el linkeo a la librería libpthread no se encuentra en el código binario.

Para asegurarnos de que dichas librerías se encuentran instaladas en nuestro sitema operativo podemo ejecutar el siguiente comando

```bash
	user@prompt:~$ ldconfig -p | grep libpthread
		libpthread.so.0 (libc6,x86-64, OS ABI: Linux 3.2.0) => /lib/x86_64-linux-gnu/libpthread.so.0
		libpthread.so.0 (libc6, OS ABI: Linux 3.2.0) => /lib/i386-linux-gnu/libpthread.so.0
		libpthread.so.0 (libc6, OS ABI: Linux 3.2.0) => /lib32/libpthread.so.0
```

este resultado lo que nos dice es, que existen en el sistema operativo tres linkeos dinámicos asociadas a la libreria libpthread.

Por la arquitectura que tenemos (x86 64-bits) el linkeo que utilizará el sistema será el primero en la lista, es decir, `"libpthread.so.0 (libc6,x86-64, OS ABI: Linux 3.2.0) => /lib/x86_64-linux-gnu/libpthread.so.0"`. Entonces, podemos ir al directorio `/lib/x86_64-linux-gnu/` y ver si existe alguna librería estática. Esto lo hacemos con el siguiente comando:

```bash
	user@prompt:~$ cd /lib/x86_64-linux-gnu/
	user@prompt:~$ ll | grep libpthread
	-rw-r--r--   1 root   root           8 Jul  6 20:23 libpthread.a
	-rw-r--r--   1 mendez mendez     21448 Aug 29 15:59 libpthread.so.0
```

este resultado nos muestra que tenemos, además de la librería dinámica `libpthread.so.0` una libería estática `libpthread.a` que el paquete mctdhXX podría utilizar para compilar. Una opción sería mover dicha libería estática a otra ubicación y forzar a que el paquete mctdhXX utiice la librería dinámica. Esto se probó y no solucionó el problema.

### Solution
Para encontrar el código, dentro del paquete mctdhXX, que útiliza el comando `pthread_mutex_lock` o aquellos programas en lenguaje `C` que utilicen la librería `pthread` se corrieron los siguientes comandos:

```bash
	user@prompt:~$ cdm
	user@prompt:~$ cd source/
	user@prompt:~$ mcg "include <pthread.h>"
	user@prompt:~$ mcg "pthread_mutex_lock"
```
el comando mcg busca dentro de los código fuente que se encuentran sólo en la carpeta `source/`, al ejecutarlos no se encontraron inclusiones de dichas palabras clave. Por ello, se utilizó el siguiente comando:

```bash
	user@prompt:~$ cdm
	user@prompt:~$ cd source/
	user@prompt:~$ grep -r "pthread.h" --include="*.c"
		propwf/parallel.c:#include <pthread.h>
		propwf/DEF_thread.c:*     that the compiler does not support the pthread.h and
		propwf/propwfwrap.c:#include <pthread.h>
```
donde hemos restringido la busqueda a sólo a la palabra `pthread.h` en los codigo fuentes escritos en lenguaje `C`. Entonces, pudimos ver que dichas palabras se encontraban en los programas `parallel.c`, `propwfwrap.c` y `DEF_thread.c`. Si observamos este último programa vemos que:

```bash
	user@prompt:~$ cdm
	user@prompt:~$ cd source/propwf/
	user@prompt:~$ cat DEF_thread.c 
		/*** MRB ** 2007 *******************************************************
		*     In this file dummy routines/functions are defined for the case
		*     that the compiler does not support the pthread.h and
		*     semaphore.h library.
		***********************************************************************/
```

Como vemos se trata de una rutina dummy tal que se ejectua cuando el paquete mctdhXX no encuentra la libreria `pthread.h` o `semaphore.h`. Una forma de solucionar el problema original fue comentar todos los bloques de código del programa fuente `DEF_thread.c` de tal forma de que se cree la función `def_thread_dummyfunction()` pero sin ninguna información. De esta forma los punteros de las funciones que aparecen `DEF_thread.c` (y que se comentarán) no recibirán ningun puntero y no arrojarán ningun mensaje de error. La hipótesis de todos esto sería que al momento de compilar el paquete mctdhXX este no haga ningun tratamiento especial a los errores de linkeo de la librería `pthread` y luego, al ejecutar el código binario `mctdhXX` el sistema operativo se encargue de hacer los linkeos correspondientes a la librería.

El programa `DEF_thread.c` quedaría entonces de la forma:

```C
	/*** MRB ** 2007 *******************************************************
	*     In this file dummy routines/functions are defined for the case
	*     that the compiler does not support the pthread.h and
	*     semaphore.h library.
	***********************************************************************/
	#include <stdlib.h>
	#include <stdio.h>

	void def_thread_dummyfunction(){}
```
Luego de esta modificación se volvió a compilar el programa mctdh obteniendo:

```bash
	user@prompt:~$ cdm
	user@prompt:~$ compile mctdh
			[...]
				Congratulations, the compilation was successful.
		
		------  compile  ---  Fri, 09 Sep 2022, 16:47:29 ---  good bye!  ---------------
		--------------------------------------------------------------------------------
	user@prompt:~$ mctdh85
		--------------------------------------------------------------------------------
		Heidelberg MCTDH. A program for doing multi-dimensional quantum dynamics.
		----  MCTDH  Version  8   ---    Release    5   ---   Revision  14   ----

		Usage:  mctdh85 [options] "inputfile"

		-h   : Provides a help text explaining the options.
		-ver : Version Information.
		-max : List of max... parameters defined in the include files.

		Compiled: Fri, 09 Sep 2022, 16:47:28 ; Host: user                      
		--------------------------------------------------------------------------------
```

Lo cual nos muestra que el binario mctdhXX se ejecuta correctamente y, para verificar si existen linkeos dinámicos del código binario mctdhXX volvemos a usar el comando:

```bash
	user@prompt:~$ cdm
	user@prompt:~$ ldd bin/binary/x86_64/mctdh85
		linux-vdso.so.1 (0x00007ffc344da000)
		libgfortran.so.5 => /lib/x86_64-linux-gnu/libgfortran.so.5 (0x00007f8497ec8000)
		libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f8497de1000)
		libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007f8497dc1000)
		libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f8497b99000)
		libquadmath.so.0 => /lib/x86_64-linux-gnu/libquadmath.so.0 (0x00007f8497b51000)
		/lib64/ld-linux-x86-64.so.2 (0x00007f84b0fa5000)
```

entonces vemos que el binario no utiliza linkeos dinámicos a librería `pthread`, sin embargo funciona correctamente. Entonces, la única opción sería que el sistema operativo se encargó de realizar algún linkeo estático a la librería en cuestión. Para verificar esto ejecutamos el siguiente comando:

```bash
	user@prompt:~$ cdm
	user@prompt:~$ nm bin/binary/x86_64/mctdh85 | grep pthread
		000000000010a820 T dwtcalchapthreadcreate_
		000000000010aa30 T dwthlochphi1mparpthreadcreate_
		000000000010a910 T dwtmatrizen12pthreadcreate_
		000000000010a6e0 T dwtphihphi1mpthreadcreate_
		00000000000e6300 T fpthreadcreate_
		00000000000e6360 T fpthreadjoin_
		000000000010a570 T fpthreadmutexlock_
		000000000010a3d0 T fpthreadmutexlocklb_
		000000000010a5a0 T fpthreadmutexunlock_
		000000000010a3e0 T fpthreadmutexunlocklb_
		0000000018a85e10 B ipthread1_
		0000000018a85980 B ipthread_
		0000000018a85ae0 B lpthread_
		000000000010a5d0 T mctdhfpthreadcreate_
						U pthread_create@GLIBC_2.34
						U pthread_join@GLIBC_2.34
						U pthread_mutex_destroy@GLIBC_2.2.5
						U pthread_mutex_init@GLIBC_2.2.5
						U pthread_mutex_lock@GLIBC_2.2.5
						U pthread_mutex_unlock@GLIBC_2.2.5
		0000000018a85fc0 B rpthread_
```

donde vemos que las librerias se linkean a una cierta versión de la librería estándar de C. Esto último lo podemos entender un poco mejor si consultamos la `man page` del comando `nm` donde vemos que 
```bash
	user@prompt:~$ man nm
		"T" The symbol is in the text (code) section.
		"U" The symbol is undefined.

		•   The symbol name.  If a symbol has version information associated with it, then the version information is displayed as well.  If the versioned symbol is undefined or hidden from linker, the version string is displayed as a suffix to the symbol name, preceded by an @ character.  For example foo@VER_1.  If the version is the default version to be used when resolving unversioned references to the symbol, then it is displayed as a suffix preceded by two @ characters. For example foo@@VER_2.
```