
---

### 2. **Scripts y Documentación para el Módulo 2: Scheduling Jobs**

### **Script `cron_management.sh`**

El script `cron_management.sh` permite gestionar tareas programadas en Linux utilizando `cron`.

#### **Contenido de `cron_management.sh`**

```bash
#!/bin/bash

# Título del script
echo "==============================="
echo "       Cron Management Tool     "
echo "==============================="

# Función para listar cron jobs de un usuario
list_cron_jobs() {
    read -p "Ingrese el nombre del usuario (dejar vacío para root): " username
    if [ -z "$username" ]; then
        crontab -l
    else
        crontab -l -u "$username"
    fi
}

# Función para agregar un cron job
add_cron_job() {
    read -p "Ingrese la tarea a programar (ejemplo: /path/to/script.sh): " task
    read -p "Ingrese la programación del cron job (ejemplo: '0 5 * * *' para cada día a las 5 AM): " schedule
    (crontab -l 2>/dev/null; echo "$schedule $task") | crontab -
    echo "Cron job agregado exitosamente."
}

# Función para eliminar un cron job
delete_cron_job() {
    read -p "Ingrese el número de línea del cron job a eliminar: " job_number
    crontab -l | sed "${job_number}d" | crontab -
    echo "Cron job eliminado exitosamente."
}

# Función para modificar un cron job
modify_cron_job() {
    read -p "Ingrese el número de línea del cron job a modificar: " job_number
    read -p "Ingrese la nueva programación del cron job: " new_schedule
    read -p "Ingrese la nueva tarea del cron job: " new_task
    crontab -l | sed "${job_number}s/.*/$new_schedule $new_task/" | crontab -
    echo "Cron job modificado exitosamente."
}

# Menú principal
while true; do
    echo "Seleccione una opción:"
    options=("Listar cron jobs" "Agregar cron job" "Eliminar cron job" "Modificar cron job" "Salir")
    select opt in "${options[@]}"
    do
        case $opt in
            "Listar cron jobs")
                list_cron_jobs
                break
                ;;
            "Agregar cron job")
                add_cron_job
                break
                ;;
            "Eliminar cron job")
                delete_cron_job
                break
                ;;
            "Modificar cron job")
                modify_cron_job
                break
                ;;
            "Salir")
                echo "Saliendo del script."
                exit 0  # Asegura que solo se termina el script y no la terminal.
                ;;
            *) echo "Opción inválida $REPLY";;
        esac
    done
done
