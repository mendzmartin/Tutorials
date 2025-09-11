# Guía: Compilar Proyectos LaTeX de Overleaf Localmente con VS Code

## 📋 Prerrequisitos

### 1. Instalar Distribución LaTeX

#### Windows
- **MikTeX**: [Descargar aquí](https://miktex.org/download)
- **O TeX Live**: [Instalar desde aquí](https://www.tug.org/texlive/)

#### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install texlive-full texlive-science texlive-publishers
```

#### macOS
```bash
brew install --cask mactex
```

### 2. Instalar Visual Studio Code
- [Descargar VS Code](https://code.visualstudio.com/download)

## 🔧 Configuración de VS Code

### 1. Instalar Extensiones Necesarias

Abre VS Code y instala estas extensiones:
- **LaTeX Workshop** (por James Yu)
- **LaTeX Utilities** (por tecosaur)

### 2. Configurar Settings.json

Presiona `Ctrl + ,` (Windows/Linux) o `Cmd + ,` (macOS) y haz clic en el ícono "{}" para abrir el archivo de configuración JSON.

Agrega esta configuración:

```json
{
    "latex-workshop.latex.tools": [
        {
            "name": "latexmk",
            "command": "latexmk",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "-pdf",
                "%DOC%"
            ]
        }
    ],
    "latex-workshop.latex.recipes": [
        {
            "name": "latexmk",
            "tools": ["latexmk"]
        }
    ],
    "latex-workshop.view.pdf.viewer": "tab",
    "latex-workshop.latex.autoBuild.run": "onSave"
}
```

## 🚀 Uso del Proyecto

### 1. Abrir el Proyecto
- Abre VS Code
- `File > Open Folder` y selecciona la carpeta de tu proyecto LaTeX

### 2. Compilar el Documento
- Abre el archivo `.tex` principal
- Presiona `Ctrl + Alt + B` (Windows/Linux) o `Cmd + Option + B` (macOS)
- O haz clic en el botón "Build" en la esquina superior derecha

### 3. Ver el PDF
- El PDF se abrirá automáticamente en una pestaña de VS Code
- Para actualizar: guarda los cambios y se recompilará automáticamente

## 🔍 Troubleshooting

### Problemas con revtex4-2
Si encuentras errores con `revtex4-2`, ejecuta:

```bash
# Verificar si está instalado
kpsewhich revtex4-2.cls

# Actualizar paquetes (MikTeX)
- Abrir MikTeX Console → Updates
```

### Archivo de Configuración Alternativo
Crea un archivo `latexmkrc` en la raíz del proyecto:

```perl
$pdf_mode = 1;
$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 %O %S';
```

## 💡 Características Útiles

### Atajos de Teclado
- `Ctrl + Alt + B`: Compilar
- `Ctrl + Alt + V`: Ver PDF
- `Ctrl + Click` en PDF: Ir al código correspondiente

### Funcionalidades
- **SyncTeX**: Navegación bidireccional entre código y PDF
- **Compilación automática**: Se recompila al guardar
- **Sintaxis resaltada**: Mejor legibilidad del código
- **Sugerencias de completado**: Ayuda con comandos LaTeX

## 📦 Estructura Recomendada del Proyecto

```
mi-proyecto/
├── main.tex
├── latexmkrc (opcional)
├── sections/
│   ├── introduccion.tex
│   ├── metodologia.tex
│   └── conclusiones.tex
├── figures/
│   ├── diagrama.pdf
│   └── grafico.png
└── references.bib
```

## 🆘 Soporte

### Errores Comunes
1. **Paquetes faltantes**: Instalar con el gestor de paquetes de tu distribución LaTeX
2. **Permisos**: Ejecutar VS Code como administrador si es necesario
3. **Rutas**: Usar rutas relativas para imágenes y archivos incluidos

### Recursos Adicionales
- [Documentación LaTeX Workshop](https://github.com/James-Yu/LaTeX-Workshop/wiki)
- [Foro TeX StackExchange](https://tex.stackexchange.com/)

---