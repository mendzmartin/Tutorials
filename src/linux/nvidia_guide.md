```markdown
# Guía Completa: Controladores NVIDIA en Ubuntu

## 🔍 Requisitos previos
- Ubuntu 20.04/22.04/24.04 (LTS recomendado)
- Acceso sudo
- Conexión a internet

## 🛠️ Paso 1: Preparación del sistema

### Eliminar controladores previos (limpieza profunda):
```bash
sudo apt purge *nvidia* *cuda* *cudnn* *tensorrt* *libnvidia*
sudo apt autoremove --purge
sudo rm /etc/modprobe.d/nvidia*
sudo rm /etc/modprobe.d/blacklist-nvidia-nouveau.conf
sudo update-initramfs -u
```

### Eliminar PPAs conflictivos:
```bash
sudo rm /etc/apt/sources.list.d/*keepass* /etc/apt/sources.list.d/*mpv-tests*
```

## 📥 Paso 2: Instalación de controladores

### Opción A: Instalación automática (recomendada)
```bash
sudo ubuntu-drivers autoinstall
```

### Opción B: Instalación manual
```bash
ubuntu-drivers devices  # Ver modelos disponibles
sudo apt install nvidia-driver-535  # Ejemplo con versión 535
```

### Para portátiles con gráficos híbridos:
```bash
sudo apt install nvidia-prime
```

## ⚙️ Paso 3: Configuración post-instalación

### Bloquear controlador nouveau:
```bash
echo -e "blacklist nouveau\noptions nouveau modeset=0" | sudo tee /etc/modprobe.d/blacklist-nvidia-nouveau.conf
sudo update-initramfs -u
```

### Gestionar Secure Boot:
```bash
mokutil --sb-state  # Verificar estado
# Si está habilitado:
sudo apt install shim-signed
```

## 🔄 Paso 4: Reinicio y verificación
```bash
sudo reboot
```

### Comandos de verificación:
```bash
nvidia-smi
glxinfo | grep "OpenGL renderer"
prime-select query  # Para portátiles
```

## 🚀 Optimizaciones

### Ajustar potencia máxima (ejemplo para RTX 3050):
```bash
sudo nvidia-smi -pm 1  # Modo persistente
sudo nvidia-smi -pl 80  # Límite de potencia en Watts
```

### Variables de entorno útiles:
```bash
# Añadir al final de ~/.bashrc:
export __NV_PRIME_RENDER_OFFLOAD=1
export __GLX_VENDOR_LIBRARY_NAME=nvidia
```

## 🐛 Solución de problemas comunes

### 1. "NVIDIA-SMI has failed"
```bash
sudo dkms install -m nvidia -v $(dpkg -l | grep nvidia-driver | awk '{print $3}')
```

### 2. Pantalla negra al iniciar
```bash
sudo apt install --reinstall gdm3 ubuntu-desktop
```

### 3. Bajo rendimiento en portátiles
```bash
sudo cp /usr/share/X11/xorg.conf.d/11-nvidia-prime.conf /etc/X11/xorg.conf.d/
sudo nano /etc/X11/xorg.conf.d/11-nvidia-prime.conf  # Añadir:
Option "AllowExternalGpus" "true"
```

## 📊 Monitoreo avanzado

### Instalar herramientas:
```bash
sudo apt install nvtop nvidia-smi
```

### Comando para monitoreo en tiempo real:
```bash
watch -n 1 "nvidia-smi && echo && sensors"
```

## 🔗 Recursos útiles
- [Documentación oficial NVIDIA](https://docs.nvidia.com/datacenter/tesla/installation-guide/index.html)
- [Wiki de Ubuntu sobre NVIDIA](https://wiki.ubuntu.com/NVIDIA)
```

## 📌 Notas finales:
- Actualiza regularmente con `sudo apt update && sudo apt upgrade`
- Para laptops, considera usar `tlp` para gestión de energía
- Versiones específicas de CUDA requieren pasos adicionales