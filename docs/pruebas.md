# Pruebas, rendimiento y publicación  Joan Fandos

## 1. Pruebas funcionales y de persistencia
| Prueba | Resultado |
|---|---|
| `docker compose down` (sin `-v`) y `docker compose up -d` | OK  Contenidos, usuarios y configuración conservados en `wp_data` y `db_data` |
| Navegación por páginas, menú desplegable y entradas | OK  Enlaces permanentes y subpágina `Tecnologías` operativos |
| Acceso desde red local (`[http://192.168.1.33:8080](http://192.168.1.33:8080)`) | OK  Configurado con URL dinámica en `WORDPRESS_CONFIG_EXTRA` |

## 2. Rendimiento (5 peticiones a `http://localhost:8080/`)
| Petición | Tiempo total |
|---|---|
| Petición 1 | 0.121065s |
| Petición 2 | 0.103946s |
| Petición 3 | 0.088699s |
| Petición 4 | 0.084899s |
| Petición 5 | 0.085830s |

## 3. Consumo de recursos (`docker stats --no-stream`)
```text
CONTAINER ID   NAME                    CPU %     MEM USAGE / LIMIT     MEM %     NET I/O           BLOCK I/O         PIDS
8ef45e4946d1   ra1-stack-nginx-1       0.00%     8.832MiB / 7.699GiB   0.11%     877kB / 908kB     0B / 4.1kB        9
4dde97328732   ra1-stack-wordpress-1   0.00%     65.61MiB / 7.699GiB   0.83%     1.03MB / 903kB    20.5kB / 0B       3
ab7b7613daff   ra1-stack-db-1          0.02%     97.42MiB / 7.699GiB   1.24%     51.4kB / 1.02MB   7.87MB / 53.2kB   11
```
