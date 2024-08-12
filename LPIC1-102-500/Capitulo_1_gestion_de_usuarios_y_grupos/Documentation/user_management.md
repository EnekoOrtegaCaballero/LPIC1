# User Management Tool Documentation

## Descripción

Este script permite gestionar usuarios en un sistema Linux de manera interactiva. Las funcionalidades incluyen:

- Crear un usuario con opciones personalizadas (nombre completo, shell de inicio, grupo, directorio home, etc.)
- Eliminar un usuario y su directorio home.
- Listar todos los usuarios en el sistema.
- Listar solo los usuarios "reales" (usuarios con UID >= 1000).
- Modificar las propiedades de un usuario, como el shell de inicio, el directorio home, el grupo principal y el nombre completo.

## Uso

### Ejecución del script

Para ejecutar el script:

```bash
./user_management.sh
