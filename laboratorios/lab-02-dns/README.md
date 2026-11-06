# FC-LAB-002 — DNS Footprinting y Enumeración Jerárquica con nslookup, dig y whois

- **Versión y Autor:** v1.0 — 21/08/2026 — Autor: Luis Carlos Taborda Flórez
- **Objetivo:** Ejecutar reconocimiento técnico controlado sobre la infraestructura DNS de `nmap.org` y `scanme.nmap.org` para identificar direccionamiento IPv4/IPv6, servidores autoritativos, pasarelas de correo, cadena de delegación y estado de DNSSEC.
- **Dominio y Fase:** Dominio D02 (Reconocimiento y OSINT) | Fase 03 (Identificación) y Fase 04 (Análisis)
- **Roles:** Ejecutor: Analista Ofensivo Controlado | Defensor: Analista Blue Team (evaluación de DNSSEC) | Revisor: Coordinador Purple Team
- **Entorno y Autorización:** Kali Linux conectado a Internet a través de resolutor DNS local `192.168.40.1#53` y resolutor público `8.8.8.8#53`. Objetivo autorizado de pruebas: `scanme.nmap.org` / `nmap.org`.
- **Entradas:** Nombres de dominio `scanme.nmap.org` y `nmap.org`; dirección IPv4 `45.33.32.156`; herramientas `nslookup`, `dig` (DiG 9.20.23-1-Debian) y `whois`.

## Procedimiento Reproducible
1. Resolución básica (`nslookup scanme.nmap.org`): obtención de registros A (`45.33.32.156`) y AAAA (`2600:3c01::f03c:91ff:fe18:bb2f`).
2. Servidores autoritativos (`nslookup -type=ns nmap.org`): identificación de `ns1` a `ns5.linode.com`.
3. Servidores de correo (`nslookup -type=mx nmap.org`): identificación de 5 registros MX de Google Workspace (`ASPMX.L.GOOGLE.COM` prioridad 1, `ALT1/ALT2` prioridad 5, `ASPMX2/ASPMX3` prioridad 10).
4. Resolución inversa (`nslookup 45.33.32.156`): comprobación del registro PTR `156.32.33.45.in-addr.arpa -> scanme.nmap.org`.
5. Consulta avanzada (`dig scanme.nmap.org`) y trazado jerárquico (`dig -4 +trace scanme.nmap.org`) desde `root-servers.net` -> TLD `.org` (`afilias-nst.info`) -> `ns1.linode.com`.
6. Verificación de firmas criptográficas (`dig DNSKEY nmap.org` y `dig DS nmap.org`) y contraste registral (`whois nmap.org`).

## Evidencias y Hashes
10 capturas de terminal en `Taller 2 Completo.docx`; respuestas `ANSWER: 0` en consultas `DNSKEY` y `DS`; registro WHOIS con `Registrar: Dynadot Inc.` y `DNSSEC: unsigned`.

## Criterio de Aceptación
Identificación completa de la arquitectura dual-stack, terceros proveedores (Linode y Google) y confirmación cruzada por dos vías independientes (`dig` y `whois`) del estado de DNSSEC.

## Análisis Defensivo
Implementar firmado de zona DNSSEC (generación de claves ZSK/KSK en Linode y publicación de registro DS en el TLD `.org`) para mitigar ataques de DNS Spoofing / Cache Poisoning; monitorear cambios en registros NS/MX.

## Resultado
Prueba P01 completada. Se documentó el hallazgo H-01 (Severidad Media): la zona `nmap.org` carece de cadena de confianza DNSSEC (`DNSKEY=0`, `DS=0`, `DNSSEC: unsigned`), aunque el nivel raíz y el TLD `.org` sí están firmados.
