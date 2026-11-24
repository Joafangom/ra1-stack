# Stack Web con Docker + WordPress (RA1 y RA2)  Joan Fandos

Proyecto de despliegue de una infraestructura web en contenedores con **Nginx**, **WordPress (PHP 8.3-FPM)** y **MariaDB 11**, gestionada con Docker Compose y versionada en GitHub.

## Arquitectura del stack
* **`nginx` (`nginx:stable`):** Servidor web y proxy inverso en el puerto `8080:80`, con cabeceras de seguridad, versión oculta y bloqueo de rutas sensibles.
* **`wordpress` (`wordpress:7.1-php8.3-fpm`):** Gestor de contenidos con límites personalizados (`64M`), edición de ficheros desactivada (`DISALLOW_FILE_EDIT`) y soporte de URL dinámica.
* **`db` (`mariadb:11`):** Base de datos aislada en la red interna de Docker sin puertos expuestos al host y con volumen persistente `db_data`.

## Despliegue desde cero
1. Clonar el repositorio y entrar en la carpeta:
   ```bash
   git clone [https://github.com/Joafangom/ra1-stack.git](https://github.com/Joafangom/ra1-stack.git)
   cd ra1-stack
   ```
2. Copiar la plantilla de variables de entorno y rellenar las contraseñas:
   ```bash
   cp .env.example .env
   ```
3. Levantar MariaDB y crear la base de datos y el usuario de WordPress (`wp_db` / `wp_user`):
   ```bash
   docker compose up -d db
   ```
4. Levantar el stack completo:
   ```bash
   docker compose up -d
   ```
5. Acceder a `http://localhost:8080`.

## Documentación del proyecto
* [Comparativa de gestores de contenidos (Drupal vs Joomla)](docs/comparativa-cms.md)
* [Decisión de CMS e imagen Docker](docs/decision-cms.md)
* [Personalización del sitio y límites de PHP](docs/personalizacion.md)
* [Seguridad del gestor (Antes y Después)](docs/seguridad.md)
* [Pruebas, rendimiento y publicación](docs/pruebas.md)
