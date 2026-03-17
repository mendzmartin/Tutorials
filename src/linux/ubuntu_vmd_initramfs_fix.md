# Fix: Ubuntu no arranca — `(initramfs)` y disco NVMe no detectado (ASUS TUF Gaming)

## Descripción del problema

Al encender la notebook, en lugar de cargar Ubuntu aparece el prompt:

```
BusyBox v1.36.1 (Ubuntu) built-in shell (ash)
Enter 'help' for a list of built-in commands.

(initramfs) _
```

Al ejecutar `ls /dev/sd*` o `ls /dev/nvme*` no aparece ningún disco. El sistema no puede montar el sistema de archivos y no arranca.

## Entorno

- **Hardware:** ASUS TUF Gaming (Intel 12th Gen, NVMe WD SN740 512GB, Intel CNVi WiFi Alder Lake)
- **OS:** Ubuntu 24.04 LTS (HWE kernel)
- **Causa raíz:** El kernel de Ubuntu fue actualizado automáticamente y dejó de ser compatible con el modo **Intel VMD (Volume Management Device)**, que controla el acceso al NVMe en este hardware.

## Diagnóstico

### 1. Verificar que el disco no es detectado por el kernel

```bash
# Desde el prompt (initramfs):
ls /dev/nvme*
# Salida: No such file or directory
ls /dev/
# No aparece ningún dispositivo nvme* ni sd*
```

### 2. Verificar en el BIOS

Reiniciar y entrar al BIOS (tecla **DEL** o **F2** en ASUS).

En la pantalla principal (EZ Mode) verificar la sección **Storage**. Si aparece:

```
PCIE RST Controlled Disk
Device Type: NVMe
```

Esto confirma que el disco está bajo control de **Intel VMD/RST**, que el kernel actual no está manejando correctamente.

---

## Solución

### Opción A — Solo Ubuntu (sin dual boot con Windows)

Simplemente **deshabilitar VMD** en el BIOS. Linux detectará el NVMe directamente como dispositivo estándar.

1. Entrar al BIOS → **Advanced Mode (F7)**
2. Ir a **Advanced → VMD setup menu**
3. Cambiar **Enable VMD controller** a **Disabled**
4. Confirmar la advertencia y guardar con **F10**

Ubuntu arrancará normalmente. El WiFi Intel CNVi puede dejar de funcionar (ver sección siguiente).

---

### Opción B — Dual boot con Windows (VMD debe permanecer habilitado)

Si VMD se deshabilita, Windows puede dejar de arrancar. En este caso hay que hacer que Linux cargue el módulo `vmd` durante el arranque.

#### Paso 1: Arrancar con un kernel anterior

Desde el GRUB (mantener **Shift** al arrancar, o configurar `GRUB_TIMEOUT=10`), elegir un kernel anterior que funcione.

#### Paso 2: Agregar el módulo VMD al initramfs

```bash
sudo nano /etc/initramfs-tools/modules
# Agregar al final:
vmd

# Guardar y actualizar:
sudo update-initramfs -u -k all
```

#### Paso 3: Reinstalar módulos del kernel si hay errores

Si el WiFi u otros módulos fallan, usar un **Ubuntu Live USB** para reparar desde afuera (ver sección siguiente).

---

## Reparación desde Ubuntu Live USB

Cuando el sistema no tiene red o los módulos están rotos, usar un pendrive booteable con Ubuntu Live.

### 1. Arrancar desde el pendrive

- Conectar el pendrive
- En el BIOS (F8 Boot Menu) seleccionar el pendrive
- Elegir **"Try or Install Ubuntu"** → **"Try Ubuntu"**

### 2. Montar el sistema instalado

```bash
# Identificar particiones
lsblk
# Buscar la partición principal de Ubuntu (generalmente nvme0n1p2)

# Montar el sistema
sudo mount /dev/nvme0n1p2 /mnt
sudo mount /dev/nvme0n1p1 /mnt/boot/efi
sudo mount --bind /dev /mnt/dev
sudo mount --bind /proc /mnt/proc
sudo mount --bind /sys /mnt/sys

# Entrar al sistema instalado
sudo chroot /mnt
```

### 3. Configurar DNS dentro del chroot

```bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
```

### 4. Reinstalar módulos del kernel

```bash
apt update
apt install --reinstall linux-modules-extra-$(uname -r)
apt install linux-headers-$(uname -r)
```

> **Nota:** `uname -r` dentro del chroot puede no reflejar el kernel del sistema instalado. Reemplazar manualmente con la versión correcta, por ejemplo `6.17.0-19-generic`.

### 5. Salir y reiniciar

```bash
exit
sudo reboot
# Retirar el pendrive antes de que arranque
```

---

## Problema secundario: WiFi desaparece al deshabilitar VMD

La placa **Intel CNVi WiFi (Alder Lake)** está integrada en el chipset y en algunos equipos depende del VMD para ser detectada. Al deshabilitar VMD, el WiFi puede desaparecer.

### Diagnóstico

```bash
nmcli device status
# Solo aparece loopback, sin wlan0 ni interfaz WiFi
lspci | grep -i network
# Muestra: Intel Corporation Alder Lake-P PCH CNVi WiFi
```

### Solución

Reinstalar los módulos extra del kernel (que incluyen el driver `iwlwifi`) usando el método del Live USB descripto arriba. Una vez reinstalados y con VMD habilitado nuevamente, el WiFi vuelve a funcionar.

---

## Comandos útiles de diagnóstico

```bash
# Ver kernel activo
uname -r

# Ver kernels instalados
dpkg --list | grep linux-image

# Ver dispositivos de red
nmcli device status
ip link show

# Ver logs del kernel para WiFi
sudo dmesg | grep -i iwl
sudo dmesg | grep -i nvme

# Ver dispositivos de bloque
lsblk
blkid
```

---

## Prevención

### Deshabilitar reinicios automáticos tras actualizaciones

```bash
sudo nano /etc/apt/apt.conf.d/50unattended-upgrades
# Cambiar:
Unattended-Upgrade::Automatic-Reboot "false";
```

### Hacer visible el menú GRUB al arrancar

```bash
sudo nano /etc/default/grub
# Cambiar:
GRUB_TIMEOUT_STYLE=menu
GRUB_TIMEOUT=10

sudo update-grub
```

Esto permite elegir un kernel anterior si el nuevo falla.

---

## Referencias

- [Ubuntu: initramfs troubleshooting](https://ubuntu.com/server/docs)
- [Intel VMD y Linux](https://www.kernel.org/doc/html/latest/driver-api/vmd.html)
- [iwlwifi driver documentation](https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi)
