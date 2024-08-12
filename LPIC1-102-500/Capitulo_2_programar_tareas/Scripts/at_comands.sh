
---

### **Script `at_commands.sh`**

El script `at_commands.sh` permite gestionar tareas programadas en Linux utilizando `at`.

#### **Contenido de `at_commands.sh`**

```bash
#!/bin/bash

# Título del script
echo "==============================="
echo "        At Commands Tool        "
echo "==============================="

# Función para listar tareas programadas con at
list_at_jobs() {
    atq
}

# Función para agregar una tarea con at
add_at_job() {
    read -p "Ingrese la hora para programar la tarea (ejemplo: now + 1 minute, 12:00 PM): " time
    read -p "Ingrese la tarea a programar (ejemplo: /path/to/script.sh): " task
    echo "$task" | at "$time"
    echo "Tarea programada con at para $time."
}

# Función para eliminar una tarea con at
delete_at_job() {
    read -p "Ingrese el número de tarea (job ID) a eliminar: " job_id
    atrm "$job_id"
    echo "Tarea $job_id eliminada."
}

# Menú principal
while true; do
    echo "Seleccione una opción:"
    options=("Listar tareas programadas" "Agregar tarea con at" "Eliminar tarea con at" "Salir")
    select opt in "${options[@]}"
    do
        case $opt in
            "Listar tareas programadas")
                list_at_jobs
                break
                ;;
            "Agregar tarea con at")
                add_at_job
                break
                ;;
            "Eliminar tarea con at")
                delete_at_job
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
