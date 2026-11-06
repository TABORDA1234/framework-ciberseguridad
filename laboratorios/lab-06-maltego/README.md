# FC-LAB-006 — Reconocimiento Pasivo OSINT y Mapeo de Infraestructura con Maltego

- **Versión y Autor:** v1.0 — 19/10/2026 — Autor: Luis Carlos Taborda Flórez
- **Objetivo:** Mapear de forma pasiva la infraestructura pública de correo, servidores DNS, contactos SOA, políticas SPF, bloques de red (Netblocks) y Sistemas Autónomos (ASN) de tres organizaciones con perfiles distintos (`tesla.com`, `microsoft.com` y `santototunja.edu.co`).
- **Dominio y Fase:** Dominio D02 (Reconocimiento y OSINT) | Fases 03 (Identificación) y 04 (Análisis de exposición y dependencias)
- **Roles:** Ejecutor: Analista OSINT / Red Team Pasivo | Defensor: Analista de Arquitectura y Riesgo de Proveedores
- **Entorno y Autorización:** Kali Linux con `Maltego Graph (Desktop) 4.12.1` utilizando Transforms públicas (`To DNS Name - MX`, `NS`, `SOA`, `SPF`, `To Netblock`, `To AS Number`). Cero interacción activa/intrusiva con los servidores objetivo.
- **Entradas:** Entidades `maltego.Domain`: `tesla.com`, `microsoft.com` y `santototunja.edu.co`.

## Procedimiento Reproducible
1. Crear grafos independientes para cada dominio y ejecutar transformadas `MX` y `NS`.
2. Extraer el contacto técnico de zona mediante `SOA` (`domain@teslamotors.com`, `azuredns-hostmaster@microsoft.com`, `itl@tic.ustatunja.edu.co`).
3. Desplegar la cadena `SPF` para identificar servicios autorizados de envío de correo y extraer direcciones IP y Netblocks.
4. Agrupar IPs en rangos (`To Netblock`) e identificar el proveedor de red mediante `To AS Number`.
5. Comparar el nivel de distribución, redundancia y dependencia de terceros entre las tres organizaciones.

## Evidencias y Hashes
19 capturas de grafos y vistas de detalle (con timestamp `2026-10-19`) en `Taller_maltego_completo.docx` y cuestionario analítico de 10 puntos en `Lab6_Parte2_Cuestionario_Maltego.docx`:
- `tesla.com` (39 entidades): MX en Microsoft 365, 10 NS (4 UltraDNS + 6 Akamai), SPF con 17 IPs y 8 rangos (SendGrid, Zendesk, Qualtrics), ASN 16509 (Amazon AWS).
- `microsoft.com` (69 entidades): MX propio, 4 NS en Azure DNS (`ns1`–`ns4-39.azure-dns`), SPF segmentado (`_spf-a`, `_spf-b`, `_spf-c`, `_spf-ssg-a`), ASN 3598 (Microsoft).
- `santototunja.edu.co` (15 entidades): MX en Microsoft 365, solo 2 NS propios (`dns2.ustatunja.edu.co`, `dns3.ustatunja.edu.co`), SPF delegado a `spf.protection.outlook.com` (6 rangos), ASN 8075 (Microsoft).

## Criterio de Aceptación
Grafo completo por organización con trazabilidad de fecha/hora en `Detail View` y tabla comparativa de redundancia DNS/correo/ASN.

## Análisis Defensivo
Incrementar la redundancia de servidores DNS autoritativos en `santototunja.edu.co` (actualmente depende de solo 2 servidores propios `dns2` y `dns3`, lo que representa un riesgo de disponibilidad ante fallos o DDoS), auditar periódicamente los `include:` del registro SPF para evitar autorizaciones huérfanas y usar buzones de rol en SOA.

## Resultado
Prueba P05 completada. Hallazgo H-05 (Severidad Media): baja redundancia DNS en `santototunja.edu.co` (solo 2 servidores NS propios frente a 10 distribuidos en UltraDNS/Akamai en Tesla) y exposición de relaciones con terceros en registros SPF públicos.
