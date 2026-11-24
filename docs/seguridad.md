# Seguridad del gestor  Joan Fandos

| Comprobación | Antes | Después |
|---|---|---|
| Cabecera `Server` | `nginx/1.2x.x` (mostraba versión) | `nginx` (sin versión) |
| `/xmlrpc.php` | `405 Method Not Allowed` (accesible) | `403 Forbidden` |
| `/wp-config.php` | `200 OK` (accesible) | `403 Forbidden` |
| PHP en `uploads/` | Devolvía `2` (ejecutaba código PHP) | `403 Forbidden` |
| Edición de ficheros desde el panel | Habilitada | Desactivada (`DISALLOW_FILE_EDIT`) |
| Límite de intentos de login | Sin límite | Bloqueo temporal activo tras intentos fallidos |

## Medidas aplicadas y por qué
* **Ocultación de versión (`server_tokens off`) y cabeceras (`X-Content-Type-Options`, `X-Frame-Options`):** Reduce la información expuesta a atacantes y mitiga ataques de *MIME sniffing* y *clickjacking*.
* **Bloqueo de `/xmlrpc.php`, `/wp-config.php` y PHP en `uploads/`:** Previene ataques de fuerza bruta vía XML-RPC, exposición accidental de configuración y ejecución remota de código (RCE) si un atacante lograra subir un `.php`.
* **`DISALLOW_FILE_EDIT`:** Impide que alguien con acceso al panel inyecte código PHP malicioso editando temas o plugins.
* **Separación de roles y límite de intentos:** Usar un perfil Editor en el día a día aplica el principio de mínimo privilegio, y el bloqueo de intentos frena la fuerza bruta (ya que la API `/wp-json/wp/v2/users` puede seguir exponiendo nombres de usuario).
