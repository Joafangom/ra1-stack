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
  2. Borrado de la entrada `[PONER TÍTULO E ID]` con `--force` y del plugin `flamingo`.
  3. Restauración con `./scripts/restore.sh [FECHA]` confirmando con `SI`.
  4. Resultado: tanto la entrada como `flamingo` (y sus mensajes) se recuperaron intactos.
* **Automatización:** Tarea `cron` martes y miércoles a las 13:30 (`30 13 * * 2,3 cd $HOME/ra1-stack && ./scripts/backup.sh >> backups/backup.log 2>&1`).
