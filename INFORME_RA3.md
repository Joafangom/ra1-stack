# Informe RA3 · Administración de Gestores de Contenidos  Joan Fandos

## 1. Usuarios, roles y capacidades
* **Capacidad para publicar entradas:** `publish_posts`.
* **Capacidad para subir ficheros:** `upload_files`.
* **Registro abierto:** Desactivado (`users_can_register = 0`) y rol predeterminado `subscriber`.

| Usuario | Rol | Qué puede hacer | Qué NO puede hacer |
|---|---|---|---|
| Administrador | Administrador | Control total (ajustes, plugins, temas, usuarios) |  |
| `coord.web` | Editor | Publicar y editar entradas/páginas propias y ajenas, moderar comentarios | Acceder a Plugins, Temas, Usuarios ni Ajustes |
| `profe.redes` | Autor | Escribir, publicar y borrar sus propias entradas; subir imágenes | Editar entradas de otros usuarios ni crear páginas |
| `alumna.fct` | Colaborador | Escribir borradores y enviarlos a revisión | Publicar directamente ni subir imágenes |
| `familia.garcia` | Suscriptor | Leer el sitio y editar su propio perfil | Crear ni editar contenidos |
| `revisor.fp` | Revisor (a medida) | Revisar, editar y publicar entradas/páginas de otros | Borrar entradas o páginas (sin Papelera) ni gestionar categorías |

## 2. Selección de módulos (plugins)
* **R1 (Formulario + guardado en BD):** **Contact Form 7 + Flamingo** frente a *WPForms Lite* (que no guarda envíos en BD en su versión gratuita). Configurado con desplegable `ciclo` (`ASIR | DAW | SMR`) y `skip_mail: on`.
* **R2 (Aviso de cookies):** **CookieYes (`cookie-law-info`)** por instalaciones activas, actualización reciente, compatibilidad con PHP 8.3 y botones Aceptar/Rechazar equivalentes.
* **R3 (Registro de actividad):** **Simple History** frente a *WP Activity Log* por ligereza y claridad. Comprobado el registro de intentos fallidos de acceso.
* **Limpieza:** Eliminados `akismet` y `hello` para reducir superficie de ataque.

## 3. Copias de seguridad y prueba de restauración
* **Respaldo:** Volcado SQL de `wp_db` (`mariadb-dump --single-transaction --no-tablespaces`) y `wp-content/` comprimido en `.tar.gz`, conservando las últimas 7 copias.
* **Exclusión en Git:** `backups/` añadido a `.gitignore`.
* **Prueba de restauración:**
  1. Copia previa con `./scripts/backup.sh`.
  2. Borrado de la entrada `Novedades de redes en el ciclo (ID 45)` con `--force` y del plugin `flamingo`.
  3. Restauración con `./scripts/restore.sh 20261124-134903` confirmando con `SI`.
  4. Resultado: tanto la entrada como `flamingo` (y sus mensajes) se recuperaron intactos.
* **Automatización:** Tarea `cron` martes y miércoles a las 13:30 (`30 13 * * 2,3 cd $HOME/ra1-stack && ./scripts/backup.sh >> backups/backup.log 2>&1`).


## 4. Importación y exportación en distintos formatos (Práctica 3)
* **Formatos utilizados:**
  * **WXR (XML de WordPress):** Exportación completa del sitio (`wp export --stdout > exportaciones/sitio_YYYYMMDD.xml`) e importación de `contenidos_asir.xml` mediante el plugin `wordpress-importer` (`--authors=create`), añadiendo 6 entradas (Noticias, Eventos y Prácticas) y 2 páginas (*Horario del ciclo* y *Normas del aula técnica*).
  * **CSV:** Importación masiva de usuarios desde `datos/usuarios.csv` (`wp user import-csv`), creando los nuevos con contraseña aleatoria y actualizando los existentes sin duplicarlos, además de exportar listados de entradas (`entradas.csv`).
  * **JSON (WP-CLI y API REST):** Exportación de usuarios en JSON (`usuarios.json`) y consulta pública mediante la API REST (`/wp-json/wp/v2/posts` y `/wp-json/wp/v2/users`).
  * **SQL:** Volcado selectivo de la tabla `wp_users` (`exportaciones/wp_users.sql`), comprobando que almacena hashes bcrypt (`$wp$2y$...`). Por seguridad, tanto `exportaciones/` como `backups/` permanecen excluidos en `.gitignore`.
* **Intercambio cooperativo:** Se creó y exportó una entrada en la categoría *Prácticas* explicando los cuatro formatos y se importó el archivo WXR (`.xml`) de la compañera en el sitio manteniendo su autoría.
