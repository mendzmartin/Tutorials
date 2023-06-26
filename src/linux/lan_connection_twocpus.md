## 1.0 - Actualizar repositorio de software

`sudo apt update && sudo apt upgrade`

## 2.0 - Instalar Samba en Ubuntu en Compu1 y Compu2

`sudo apt-get install samba`

## 3.0 - Consultar direcciones IP en Compu1 y Compu2

`ip a`

Debemos localizar la primera línea en donde ponga "link/ether" así localizaremos la dirección IP del equipo en el adaptador de red principal. Verificamos que ambos equipos se ven a través de la red. Para ello, tendremos que conocer al menos la dirección de IP de alguno de ellos, luego hacemos ping en Compu1, por ejemplo, con la direccion de IP de Compu2

`ping <direccion-IP-de-Compu2>`

de esta forma verificamos que el destino responde correctamente. Para parar el proceso de peticiones, pulsamos "Ctrl + z"

## 4.0 - Compartir carpeta en Ubuntu y acceder a ella
Creamos carpeta a compartir en el directorio que querramos de Compu1 luego right-click > "recurso compartido en red local". Nos aparecera una ventana para configurar las distintas opciones de uso compartido. Para este caso hacemos "Compartir esta carpeta" y activamos las dos opciones en la zona inferior para asignar permisos de lectura y escritura para cualquier usuario 

## 5.0 - Configuramos usuario y contraseña en samba de Compu1 para que las carpetas
que compartamos necesiten de esta autenticación para acceder a ellas

`sudo smbpasswd -a <nombre-de-usuario>`

Seguidamente solicitará establecer nueva password para el usuario creado debemos tener presente que el usuario tendremos que tenerlo creado en nuestro sistema Ubuntu previamente, podemos consultar el nombre de usuario con el siguiente comando

`whoami`

Cada vez que queramos acceder a una carpeta compartida en Ubuntu tendremos que colocar en el cliente este usuario y su password para autenticarnos

## 6.0 - Acceder a carpeta compartida por Compu1 desde Ubuntu en Compu2
Abrimos el explorador de archivos de Ubuntu y accedemos al directorio de "Otras ubicaciones". Nos situamos en el cuadro de introducción de texto en la zona inferior con título "Conectar al servidor", y colocamos la ruta de acceso siguiente y pulsamos en "Conectar"

`smb://<direccion-IP-de-Compu1>`

Luego nos solicitará usuario y password de acceso a la carpeta

## 7.0 - Cuando el invitado (Compu2) escribe sobre la carpeta compartida
Cuando un invitado coloca un fichero dentro del recurso compartido se puede apreciar que el usuario del sistema anfitrión (Copmpu1) tiene permisos restringido sobre este. Esto debido a que Ubuntu establece "nobody" como propietario y "nogroup" como grupo. Para ello abrimos el siguiente fichero de configuración

`sudo nano /etc/samba/smb.conf`

buscamos la linea correpondiente a "create mask = 0700", decomentarla (;) y asignarle el valor 0777 para que el anfitrión (Compu1) tenga permisos totales sobre los ficheros y carpetas creados por el invitado (Compu2). Este mask funciona al revés que el comando umask de Bash. Luego guardamos los cambios con Ctrl + o. Cerramos el fichero y reiniciamos el servicio de Samba para que se apliquen los cambios, de la siguiente manera

```
sudo systemctl restar smbd
sudo systemctl restar nmbd
```

## 8.0 - Posiblemente el grupo de trabajo sobre el cual está trabajando la red no
Es el que está por defecto "WORKGROUP", por lo que podría ser conveniente cambiarlo. Para ello cambiamos de nuevo el fichero de configuración de Samba

`sudo nano /etc/samba/smb.conf`

Hay que asignar a "Workgroup" el nombre del grupo de trabajo al cual se qiere añadir el equipo. Luego hay que reiniciar los servicio de smbd y nmbd para que el cambio haga efecto.
```
sudo systemctl restar smbd
sudo systemctl restar nmbd
```

## Fuentes bibliográficas
+ (1) [https://www.muylinux.com/2016/09/23/carpeta-ubuntu-16-04-samba/](https://www.muylinux.com/2016/09/23/carpeta-ubuntu-16-04-samba/)
+ (2) [https://www.taringa.net/+linux/la-manera-mas-facil-de-conectar-dos-equipos-en-red_ydlw8](https://www.taringa.net/+linux/la-manera-mas-facil-de-conectar-dos-equipos-en-red_ydlw8)	
+ (3) [https://luiszambrana.com.ar/2020/05/19/instalar-samba-en-ubuntu-20-04-para-compartir-desde-gnu-linux-con-usuarios-de-windows/](https://luiszambrana.com.ar/2020/05/19/instalar-samba-en-ubuntu-20-04-para-compartir-desde-gnu-linux-con-usuarios-de-windows/)	
+ (4) [https://www.muylinux.com/2016/09/23/carpeta-ubuntu-16-04-samba/](https://www.muylinux.com/2016/09/23/carpeta-ubuntu-16-04-samba/)	


En el PC que está conectado por Wifi a internet configuraremos una conexión compartida por cable. Abriremos un emulador de terminal y ejecutaremos el siguiente comando `nm-connection-editor`. Nos aparecerá una ventana de conexiones de red pulsaremos el botón con el signo + que aparece en la parte inferior izquierda, para crear una nueva conexión. Nos abrirá la otra ventana. Donde elegiremos el tipo de conexión que será cableada. Seguidamente pulsaremos en el botón "Crear".

Nos mostrará otra ventana. Iremos a la pestaña "Ajustes de IPv4" y en el apartado "Método" elegiremos la opción "Compartida con otros equipos", como se observa en la imagen superior.

Ahora solo nos queda cambiarle el nombre a esta nueva conexión. Y solo nos queda guardamos los cambios, pulsando el botón "Guardar". Y volvemos a ejecutar, en el emulador de terminal, el comando `nm-connection-editor`.
 
## Fuentes bibliográficas
+ (1) [https://ubuntinux.blogspot.com/2020/11/compartir-internet-de-un-pc-otro-con.html?showComment=1623439005508#c3508929036198889075](https://ubuntinux.blogspot.com/2020/11/compartir-internet-de-un-pc-otro-con.html?showComment=1623439005508#c3508929036198889075)
+ (2) [https://help.ubuntu.com/community/Internet/ConnectionSharing](https://help.ubuntu.com/community/Internet/ConnectionSharing)