#!/bin/bash

# Título del script
echo "==============================="
echo "      User Management Tool      "
echo "==============================="

# Función para crear un usuario
create_user() {
    read -p "Ingrese el nombre de usuario: " username
    read -p "Ingrese el nombre completo del usuario (GECOS): " fullname
    read -p "Ingrese la ruta del directorio home [/home/$username]: " home_dir
    read -p "Ingrese el shell de inicio [/bin/bash]: " user_shell
    read -p "Ingrese el nombre del grupo principal [por defecto es el mismo que el nombre de usuario]: " group
    read -p "¿Desea crear un grupo privado para el usuario? (s/n): " private_group
    read -p "¿Desea especificar una fecha de expiración para la cuenta? (s/n): " set_expiration

    # Usando valores por defecto si no se proveen
    home_dir=${home_dir:-/home/$username}
    user_shell=${user_shell:-/bin/bash}
    group=${group:-$username}

    if [ "$private_group" = "s" ]; then
        group=""
    fi

    # Crear el grupo si no existe
    if [ -n "$group" ]; then
        if ! getent group "$group" > /dev/null 2>&1; then
            groupadd "$group"
        fi
    fi

    # Crear el usuario con las opciones especificadas
    useradd -m -d "$home_dir" -s "$user_shell" -c "$fullname" -g "$group" "$username"

    # Asignar contraseña
    passwd "$username"

    # Establecer fecha de expiración si es necesario
    if [ "$set_expiration" = "s" ]; then
        read -p "Ingrese la fecha de expiración (YYYY-MM-DD): " expiration_date
        chage -E "$expiration_date" "$username"
    fi

    echo "Usuario $username creado exitosamente."
}

# Función para eliminar un usuario
delete_user() {
    read -p "Ingrese el nombre de usuario a eliminar: " username
    read -p "¿Eliminar el directorio home y el correo del usuario? (s/n): " delete_home

    if [ "$delete_home" = "s" ]; then
        userdel -r "$username"
    else
        userdel "$username"
    fi

    echo "Usuario $username eliminado exitosamente."
}

# Función para listar todos los usuarios
list_all_users() {
    echo "Lista de todos los usuarios en el sistema:"
    cut -d: -f1 /etc/passwd
}

# Función para listar solo usuarios "reales"
list_real_users() {
    echo "Lista de usuarios reales en el sistema:"
    awk -F: '$3 >= 1000 && $3 < 60000 {print $1}' /etc/passwd
}

# Función para modificar un usuario
modify_user() {
    read -p "Ingrese el nombre de usuario a modificar: " username
    echo "Seleccione la opción que desea modificar:"
    options=("Cambiar shell de inicio" "Cambiar directorio home" "Cambiar grupo principal" "Cambiar nombre completo" "Salir")
    select opt in "${options[@]}"
    do
        case $opt in
            "Cambiar shell de inicio")
                read -p "Ingrese el nuevo shell de inicio: " new_shell
                usermod -s "$new_shell" "$username"
                echo "Shell de inicio actualizado."
                ;;
            "Cambiar directorio home")
                read -p "Ingrese la nueva ruta del directorio home: " new_home
                usermod -d "$new_home" "$username"
                echo "Directorio home actualizado."
                ;;
            "Cambiar grupo principal")
                read -p "Ingrese el nuevo grupo principal: " new_group
                usermod -g "$new_group" "$username"
                echo "Grupo principal actualizado."
                ;;
            "Cambiar nombre completo")
                read -p "Ingrese el nuevo nombre completo (GECOS): " new_fullname
                usermod -c "$new_fullname" "$username"
                echo "Nombre completo actualizado."
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
    options=("Crear usuario" "Eliminar usuario" "Listar todos los usuarios" "Listar usuarios reales" "Modificar usuario" "Salir")
    select opt in "${options[@]}"
    do
        case $opt in
            "Crear usuario")
                create_user
                break
                ;;
            "Eliminar usuario")
                delete_user
                break
                ;;
            "Listar todos los usuarios")
                list_all_users
                break
                ;;
            "Listar usuarios reales")
                list_real_users
                break
                ;;
            "Modificar usuario")
                modify_user
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
