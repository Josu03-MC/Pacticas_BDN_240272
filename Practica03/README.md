# Práctica 03: Modelo relacional, auditoría y documentación de `db_test_7b`

## Enlace a la documentación interactiva

http://127.0.0.1:5500/Practica03/diagrama/index.html

## 1. Descripción General del Proyecto

Esta práctica documenta y amplía una base de datos relacional para un sistema de comercio electrónico. El respaldo `respaldo7.sql` corresponde a MySQL 8.0.42 y contiene el esquema, datos, vistas y lógica de auditoría de `db_test_7b`.

El modelo cubre el flujo desde usuarios, perfiles y direcciones hasta catálogo, proveedores, carrito, órdenes, pagos, envíos, devoluciones y reembolsos. Los entregables incluyen el respaldo SQL y un sitio estático con diagrama entidad-relación interactivo y diccionario de datos.

## 2. Arquitectura y Objetos Construidos

Las tablas siguen una convención por prefijo: `tb_` identifica entidades principales, `tbc_` catálogos y `tbd_` tablas de detalle o asociación. Las cantidades se contabilizan directamente en `backups/respaldo7.sql`; las relaciones FK son restricciones declaradas y los volúmenes corresponden a filas insertadas en el respaldo.

| Tipo de Objeto | Cantidad | Detalle Técnico |
|---|---:|---|
| Tablas | 25 | Entidades principales, catálogos y tablas de detalle/asociación. |
| Llaves foráneas | 32 | Restricciones `FOREIGN KEY` que mantienen la integridad referencial. |
| Vistas | 31 | Vistas de trazabilidad y consulta, con prefijo `vw_`. |
| Triggers | 69 | Triggers de auditoría asociados principalmente a operaciones `INSERT`, `UPDATE` y `DELETE`. |
| Restricciones `CHECK` | 8 | Validaciones declarativas para valores de columnas. |
| Procedimientos almacenados | 0 | No se declaran procedimientos en el respaldo. |
| Funciones almacenadas | 0 | No se declaran funciones en el respaldo. |
| Eventos programados | 0 | No se declaran eventos en el respaldo. |

## 3. Actividades Realizadas y Reglas de Negocio

### A. Población de datos y cardinalidades

* El respaldo contiene **50,253 filas insertadas**: `tb_logs` (25,123), `tb_products` (10,010), `tb_users` (7,520), `tb_people` (7,500) y `tbc_categories` (100). Las demás tablas no incluyen filas en las sentencias de carga del respaldo.
* La relación entre `tb_users` y `tb_people` es **1:1**, mediante la referencia única de `tb_people.user_ID` hacia `tb_users.ID`.
* Un usuario puede registrar múltiples direcciones en `tb_user_addresses` (**1:N**); cada dirección puede desglosarse en componentes en `tbd_address_components`, que también permite jerarquía recursiva mediante `address_sup_ID`.
* `tb_products` y `tbc_categories` se relacionan **N:M** mediante `tb_product_categories`.
* `tbc_categories.sup_id_category` modela una jerarquía recursiva de categorías (**1:N**).
* Los usuarios y productos se asocian como proveedores mediante `tbd_products_users_providers`; las líneas de carrito y orden conservan la referencia al proveedor y producto.
* Las órdenes se conectan con artículos, cancelaciones, devoluciones, reembolsos, pagos y envíos mediante las tablas de detalle y transaccionales correspondientes.

### B. Seguridad, auditoría y trazabilidad

* `tb_logs` conserva el historial de operaciones con usuario de base de datos, fecha, operación, descripción y estado.
* Los 69 triggers registran operaciones de escritura en las entidades cubiertas por la auditoría; el respaldo no define un modelo de roles o permisos de aplicación.
* Las 31 vistas `vw_...` exponen consultas de trazabilidad y reportes, incluidas vistas para usuarios, catálogo, carritos, órdenes, pagos y direcciones.

### C. Validaciones e integridad

* Las 32 restricciones `FOREIGN KEY` protegen las referencias entre entidades y asociaciones.
* Las claves primarias y únicas evitan duplicidad de identificadores y de combinaciones de asociación definidas en el esquema.
* Las 8 restricciones `CHECK` expresan validaciones de dominio declaradas por la base de datos.
* Los campos de estado y los `ENUM` del esquema limitan los valores admitidos en operaciones como el ciclo de cumplimiento de órdenes y los tipos de propiedad de productos.

### D. Documentación entregada

* `diagrama/erd/` contiene el diagrama ER interactivo con selección de entidades, relaciones y controles de zoom.
* `diagrama/diccionario/` presenta campos, tipos SQL, claves y referencias por tabla.
* `diagrama/assets/js/esquema.js` contiene los metadatos de entidades y relaciones que consume el diagrama.
* La documentación estática fue actualizada usando `backups/respaldo7.sql`; no consulta una base de datos en vivo.

## 4. Estructura de Archivos de la Práctica

```text
Practica03/
├── README.md                                      # Documentación técnica de la práctica
├── backups/
│   ├── respaldo6.sql                              # Respaldo SQL anterior
│   └── respaldo7.sql                              # Esquema y datos documentados
├── diagrama/
│   ├── index.html                                 # Portada de la documentación
│   ├── README.md                                  # Instrucciones para publicar el sitio
│   ├── assets/
│   │   ├── css/main.css                           # Estilos compartidos
│   │   └── js/
│   │       ├── erd.js                             # Renderizado e interacción del diagrama
│   │       └── esquema.js                         # Entidades, atributos y relaciones
│   ├── diccionario/
│   │   └── index.html                             # Diccionario de datos estático
│   └── erd/
│       └── index.html                             # Diagrama entidad-relación interactivo
└── scripts/                                       # Directorio reservado para scripts de práctica
```
