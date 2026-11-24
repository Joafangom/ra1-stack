# Decisión de CMS e imagen Docker (RA2)  Joan Fandos

## 1. Requisitos oficiales de WordPress
* **Licencia:** GPLv2 o posterior (Software Libre).
* **PHP:** 8.3 o superior recomendado.
* **Base de datos:** MySQL 8.0+ o MariaDB 10.6+ (en el stack usamos MariaDB 11).
* **HTTPS:** Altamente recomendado para producción (en local trabajamos en HTTP y en Codespaces sobre HTTPS).

## 2. Elección de imagen: `wordpress:7.1-php8.3-fpm`
* **Diferencia entre `-apache` y `-fpm`:** La variante `-apache` incluye el servidor web Apache y `mod_php` todo en un mismo contenedor. La variante `-fpm` solo incluye el intérprete PHP-FPM escuchando en el puerto 9000, pensado para trabajar detrás de un servidor web separado como **Nginx** (arquitectura más modular y eficiente).
* **Qué significa `php8.3`:** Fija la versión del intérprete PHP a la rama 8.3.
* **Por qué NO usar `latest`:** Porque la etiqueta `latest` cambia con el tiempo sin previo aviso; fijar la versión exacta garantiza despliegues reproducibles y evita roturas inesperadas al reconstruir el stack.

## 3. Verificación de módulos
Comprobado con `php -m` que la imagen incluye de serie `mysqli`, `gd`, `zip`, `intl` e `imagick`, necesarios para conectar con MariaDB y procesar imágenes y paquetes.
