# Comparativa de gestores de contenidos

| Criterio | Joomla | Drupal |
|---|---|---|
| Tipo de sitio para el que sirve | Portales corporativos, revistas y webs medianas/multilingües | Portales grandes, institucionales y con tipos de contenido complejos |
| Licencia | GPL v2 o posterior | GPL v2 o posterior |
| Tiempo hasta ver la portada | ~5 minutos | ~3 minutos |
| Dificultad del instalador (1-5) | 3/5 (requiere configurar BD externa) | 2/5 (con SQLite es muy directo) |
| Base de datos que usa | MariaDB / MySQL (o PostgreSQL) | SQLite (en pruebas), MariaDB/MySQL o PostgreSQL |
| Imagen de Docker Hub | `joomla` | `drupal` |

## ¿Qué gestor elegirías para cada caso y por qué?
1. **El blog de un club deportivo:** WordPress (o Joomla si crece a portal), porque su curva de aprendizaje es muy baja y permite publicar entradas rápidas sin conocimientos técnicos.
2. **La web de una universidad, con muchos tipos de contenido:** Drupal, porque destaca en el modelado de contenidos estructurados (facultades, grados, profesorado), taxonomías avanzadas y permisos granulares.
3. **Una revista con secciones en varios idiomas:** Joomla, porque incluye soporte multilingüe nativo en el núcleo sin plugins externos y organiza muy bien artículos por categorías y secciones.
