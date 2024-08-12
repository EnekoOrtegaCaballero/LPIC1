
---

### **README del Módulo 2: Scheduling Jobs**

#### **Contenido de `README.md`**

```markdown
# Módulo 2: Scheduling Jobs

## Descripción

Este módulo contiene scripts para gestionar la programación de tareas en sistemas Linux utilizando herramientas como `cron` y `at`. Estos scripts permiten a los usuarios programar, listar, modificar y eliminar tareas de manera sencilla.

## Scripts incluidos

### 1. `cron_management.sh`
Este script facilita la gestión de tareas programadas utilizando `cron`. Permite agregar, modificar, eliminar y listar cron jobs.

- **Documentación**: [Cron Management Tool Documentation](cron.md)

### 2. `at_commands.sh`
Este script permite gestionar tareas programadas utilizando `at`. Los usuarios pueden listar, agregar y eliminar tareas programadas con `at`.

- **Documentación**: [At Commands Tool Documentation](at.md)

## Requisitos

- Sistemas basados en Linux.
- Permisos de superusuario (root) para ejecutar algunos comandos que requieren privilegios elevados.

## Uso

Cada script es interactivo y se ejecuta desde la terminal. Al iniciar, se presenta un menú con opciones que guían al usuario a través de las diferentes funcionalidades.

### Ejecución

Para ejecutar cualquier script, usa el siguiente comando:

```bash
./nombre_del_script.sh
