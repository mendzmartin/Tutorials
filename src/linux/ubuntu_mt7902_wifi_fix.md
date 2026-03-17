# Fix: WiFi no funciona en Ubuntu — MediaTek MT7902 (ASUS VivoBook)

## Descripción del problema

Luego de instalar Ubuntu en un ASUS VivoBook con dual boot (Ubuntu + Windows), el WiFi no funciona. La tarjeta es detectada por el sistema pero no tiene driver disponible en el kernel estándar.

```bash
nmcli device status
# Solo muestra loopback, sin interfaz WiFi

ip link show
# Solo muestra lo
```

## Entorno

- **Hardware:** ASUS VivoBook (dual boot Ubuntu + Windows)
- **Tarjeta WiFi:** MediaTek MT7902
- **OS:** Ubuntu 24.04 LTS
- **Kernel:** 6.17.0-14-generic (o superior)
- **Causa raíz:** El kernel de Ubuntu no incluye driver para MT7902. Requiere instalación manual via DKMS.

## Diagnóstico

```bash
# Verificar que la tarjeta es detectada pero sin driver
lspci | grep -i network
# Salida: MediaTek MT7902 Wireless LAN Card

# Verificar ausencia de interfaz WiFi
nmcli device status
ip link show

# Verificar que no hay bloqueos de software
rfkill list
# No debe mostrar bloqueos

# Verificar que WiFi está habilitada en BIOS
# Entrar al BIOS y confirmar que WiFi no está deshabilitada
```

---

## Solución: Instalar driver via DKMS

El driver para MT7902 no está incluido en el kernel oficial. Se instala usando el repositorio DKMS:
[https://github.com/DarkMatter-999/mt7902-dkms](https://github.com/DarkMatter-999/mt7902-dkms)

### ⚠️ Prerequisito: Secure Boot

Si Secure Boot está activo en el BIOS, **desactivarlo antes de instalar el módulo**:

1. Entrar al BIOS (F2 o DEL al encender)
2. Buscar **Secure Boot** en la sección Security o Boot
3. Deshabilitarlo
4. Guardar con F10

---

## Método A — Con conexión a internet (cable ethernet o tethering USB)

Si se puede conseguir conexión temporaria por cable o desde un celular Android:

```bash
sudo apt update && sudo apt install dkms git
sudo git clone https://github.com/DarkMatter-999/mt7902-dkms /usr/src/mt7902
sudo ln -s /usr/src/mt7902 /usr/src/mt7902-0.0.1
sudo dkms add --verbose -m mt7902 -v 0.0.1
sudo dkms build --verbose -m mt7902 -v 0.0.1
sudo dkms install --verbose -m mt7902 -v 0.0.1
cd /usr/src/mt7902/firmware && sudo bash -x get-firmware.sh
sudo reboot
```

---

## Método B — Desde Ubuntu Live USB (sin cable ethernet)

Este es el método recomendado si no se tiene acceso a internet desde el sistema instalado. El Ubuntu Live USB tiene WiFi funcional y permite instalar el driver en el sistema montado via chroot.

### 1. Arrancar desde el pendrive Ubuntu Live

- Conectar el pendrive booteable con Ubuntu
- Entrar al Boot Menu del BIOS (**F8** en ASUS)
- Seleccionar el pendrive
- Elegir **"Try or Install Ubuntu"** → **"Try Ubuntu"**
- Conectarse al WiFi desde el entorno Live

### 2. Montar el sistema instalado

```bash
# Ver particiones disponibles
lsblk
# Identificar la partición principal de Ubuntu (ej: nvme0n1p2 o sda2)
# En dual boot con Windows, Ubuntu generalmente está en la partición más grande

# Montar el sistema
sudo mount /dev/nvme0n1p2 /mnt        # ajustar según lsblk
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

### 4. Instalar el driver MT7902

```bash
apt update && apt install dkms git
git clone https://github.com/DarkMatter-999/mt7902-dkms /usr/src/mt7902
ln -s /usr/src/mt7902 /usr/src/mt7902-0.0.1
dkms add --verbose -m mt7902 -v 0.0.1
dkms build --verbose -m mt7902 -v 0.0.1
dkms install --verbose -m mt7902 -v 0.0.1
cd /usr/src/mt7902/firmware && bash -x get-firmware.sh
```

> **Nota:** No se requiere `sudo` dentro del chroot ya que se está como root.

### 5. Salir y reiniciar

```bash
exit
sudo reboot
# Retirar el pendrive antes de que arranque
```

### 6. Verificar que el WiFi funciona

```bash
nmcli device status
# Debe aparecer una interfaz wlan0 o wlp* con estado "disconnected" o "connected"

ip link show
# Debe aparecer la interfaz WiFi

# Conectarse a una red
nmcli device wifi connect "NombreDeRed" password "contraseña"
```

---

## Comandos útiles de diagnóstico

```bash
# Ver tarjetas de red detectadas
lspci | grep -i network
lsusb | grep -i wireless

# Ver interfaces de red
nmcli device status
ip link show

# Ver si el módulo está cargado
lsmod | grep mt7902
modinfo mt7902

# Ver logs del kernel para la tarjeta
sudo dmesg | grep -i mt7902
sudo dmesg | grep -i mediatek

# Ver bloqueos de software/hardware
rfkill list
```

---

## Notas para dual boot (Ubuntu + Windows)

- **No modificar la configuración VMD del BIOS** si Windows está instalado en modo RST/RAID.
- El driver DKMS se recompila automáticamente con cada actualización del kernel gracias al sistema DKMS.
- Si después de una actualización el WiFi deja de funcionar, ejecutar: `sudo dkms autoinstall`

---

## Referencias

- [mt7902-dkms en GitHub](https://github.com/DarkMatter-999/mt7902-dkms)
- [MediaTek MT7902 en Linux Wireless](https://wireless.wiki.kernel.org/)
- [Ubuntu DKMS documentation](https://help.ubuntu.com/community/Kernel/DKMSDriverPackage)
