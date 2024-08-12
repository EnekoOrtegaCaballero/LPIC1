#!/bin/bash

# Título del script
echo "==============================="
echo "      Group Management Tool     "
echo "==============================="

# Función para crear un grupo
create_group() {
    read -p "Ingrese el nombre del grupo: " groupname

    # Verificar si el grupo ya existe
    if getent group "$groupname" > /dev/null 2>&1; then
        echo "El grupo $groupname ya existe."
    else
        groupadd "$groupname"
        echo "Grupo $groupname creado exitosamente."
    fi
}

# Función para eliminar un grupo
delete_group() {
    read -p "Ingrese el nombre del grupo a eliminar: " groupname

    # Verificar si el grupo existe
    if getent group "$groupname" > /dev/null 2>&1; then
        groupdel "$groupname"
        echo "Grupo $groupname eliminado exitosamente."
    else
        echo "El grupo $groupname no existe."
    fi
}

# Función para agregar un usuario a un grupo
add_user_to_group() {
    read -p "Ingrese el nombre del usuario: " username
    read -p "Ingrese el nombre del grupo: " groupname

    # Verificar si el usuario existe
    if id "$username" &>/dev/null; then
        # Verificar si el grupo existe
        if getent group "$groupname" > /dev/null 2>&1; then
            usermod -aG "$groupname" "$username"
            echo "Usuario $username agregado al grupo $groupname."
        else
            echo "El grupo $groupname no existe."
        fi
    else
        echo "El usuario $username no existe."
    fi
}

# Función para eliminar un usuario de un grupo
remove_user_from_group() {
    read -p "Ingrese el nombre del usuario: " username
    read -p "Ingrese el nombre del grupo: " groupname

    # Verificar si el usuario existe
    if id "$username" &>/dev/null; then
        # Verificar si el grupo existe
        if getent group "$groupname" > /dev/null 2>&1; then
            gpasswd -d "$username" "$groupname"
            echo "Usuario $username eliminado del grupo $groupname."
        else
            echo "El grupo $groupname no existe."
        fi
    else
        echo "El usuario $username no existe."
    fi
}

# Función para listar todos los grupos
list_all_groups() {
    echo "Lista de todos los grupos en el sistema:"
    cut -d: -f1 /etc/group
}

# Función para modificar un grupo
modify_group() {
    read -p "Ingrese el nombre del grupo a modificar: " groupname
    echo "Seleccione la opción que desea modificar:"
    options=("Cambiar el nombre del grupo" "Cambiar GID" "Salir")
    select opt in "${options[@]}"
    do
        case $opt in
            "Cambiar el nombre del grupo")
                read -p "Ingrese el nuevo nombre del grupo: " new_groupname
                groupmod -n "$new_groupname" "$groupname"
                echo "Nombre del grupo actualizado a $new_groupname."
                break
                ;;
            "Cambiar GID")
                read -p "Ingrese el nuevo GID: " new_gid
                groupmod -g "$new_gid" "$groupname"
                echo "GID del grupo actualizado a $new_gid."
                break
                ;;
            "Salir")
                break
                ;;
            *) echo "Opción inválida $REPLY";;
        esac
    done
}

# Menú principal
while true; do
    echo "Seleccione una opción:"
    options=("Crear grupo" "Eliminar grupo" "Agregar usuario a grupo" "Eliminar usuario de grupo" "Listar todos los grupos" "Modificar grupo" "Salir")
    select opt in "${options[@]}"
    do
        case $opt in
            "Crear grupo")
                create_group
                break
                ;;
            "Eliminar grupo")
                delete_group
                break
                ;;
            "Agregar usuario a grupo")
                add_user_to_group
                break
                ;;
            "Eliminar usuario de grupo")
                remove_user_from_group
                break
                ;;
            "Listar todos los grupos")
                list_all_groups
                break
                ;;
            "Modificar grupo")
                modify_group
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
