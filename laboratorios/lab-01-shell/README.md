# FC-LAB-001 — Comandos Shell y Preparación de Entorno en Kali Linux

- **Versión y Autor:** v1.0 — 18/08/2026 — Autor: Luis Carlos Taborda Flórez
- **Objetivo:** Preparar y auditar el entorno base de pruebas en Kali Linux mediante comandos de terminal, estructuración de directorios de trabajo, reconocimiento de red local y verificación de servicios activos.
- **Dominio y Fase:** Dominio D01 (Entornos y sistemas) | Fases 01 (Preparación) y 02 (Prevención / Línea Base)
- **Roles:** Ejecutor: Analista Ofensivo / Defensivo (Luis Carlos Taborda Flórez) | Revisor: Docente / Evaluador del curso
- **Entorno y Autorización:** Máquina virtual Kali Linux 2026.2 (Kernel 6.19.14+kali-amd64) sobre Oracle VirtualBox. Alcance estrictamente local (loopback 127.0.0.1 e interfaz NAT eth0 10.0.2.15/24).
- **Entradas:** Usuario estándar `kali`, terminal Bash, utilidades nativas (`iproute2`, `ss`, `nmap 7.99`).

## Procedimiento Reproducible
1. Navegar al directorio personal (`cd ~`) y crear la estructura del proyecto `mkdir -p laboratorio_kali/{reconocimiento,evidencias,reportes}`.
2. Documentar el propósito de autorización en `README.txt` (`echo "Laboratorio autorizado de ciberseguridad" > README.txt`).
3. Identificar el contexto de ejecución y sistema operativo con `whoami` (`kali`), `hostname` (`kali`) y `uname -a`.
4. Levantar la configuración de red con `ip a` (IP `10.0.2.15/24`, MAC `08:00:27:5a:87:bc`) e `ip route` (puerta de enlace `10.0.2.2`).
5. Auditar puertos TCP/UDP en escucha local mediante `ss -tuln` y contrastar desde perspectiva externa con `nmap 127.0.0.1`.
6. Exportar la trazabilidad de comandos ejecutados con `history`.

## Evidencias y Hashes
Capturas de terminal 1 a 14 en `Taller 1.docx`; salida de `nmap 127.0.0.1` (1000 puertos TCP cerrados/reset en 0.06 s); registro de `history` (comandos 1 al 74).

## Criterio de Aceptación
Estructura de directorios creada sin errores, interfaz de red documentada y coincidencia 100% entre la ausencia de sockets en escucha (`ss -tuln`) y los 1000 puertos cerrados en `nmap 127.0.0.1`.

## Análisis Defensivo
Mantener deshabilitados los servicios de red innecesarios por defecto (hardening de superficie local), operar con cuenta sin privilegios root salvo requerimiento explícito (`sudo`) y preservar el historial de consola como bitácora de auditoría.

## Resultado
Prueba P01-Base exitosa. Superficie de exposición local nula (0 puertos abiertos en loopback), entorno estandarizado y listo para los laboratorios subsecuentes.
