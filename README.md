# Proyecto RA1  Joan Fandos

## Medidas de seguridad aplicadas
- Sin credenciales en `docker-compose.yml` (solo en `.env`, excluido en `.gitignore`).
- Base de datos sin puertos publicados al host (solo red interna).
- Versión de Apache oculta (`ServerTokens Prod` y `ServerSignature Off`).
