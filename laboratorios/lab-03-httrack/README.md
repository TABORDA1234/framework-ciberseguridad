# FC-LAB-003 — Clonación Controlada de Sitio Web con HTTrack y Auditoría White Hat de Exposición

- **Versión y Autor:** v1.0 — 25/08/2026 — Autor: Luis Carlos Taborda Flórez
- **Objetivo:** Evaluar la superficie pública de una aplicación web desplegada en entorno controlado mediante clonación completa del lado cliente con HTTrack y búsqueda estática de secretos o endpoints expuestos con expresiones regulares.
- **Dominio y Fase:** Dominio D03 (Seguridad web) | Fases 02 (Prevención), 03 (Identificación) y 04 (Análisis)
- **Roles:** Ejecutor: Analista Ofensivo / White Hat | Defensor: Analista Blue Team (revisión de fugas en front-end)
- **Entorno y Autorización:** Sitio propio desplegado en Netlify (`https://magnificent-froyo-6f6c55.netlify.app/`), máquina Kali Linux con `HTTrack version 3.49-14`, `python3 -m http.server 8080 --bind 127.0.0.1` y `grep`.
- **Entradas:** URL autorizada en Netlify; filtros de inclusión `+*.netlify.app/*`, `+*.css`, `+*.js`, `+*.png`, `+*.jpg`, `+*.jpeg`, `+*.gif`.

## Procedimiento Reproducible
1. Publicar el sitio de pruebas en Netlify y verificar su disponibilidad pública.
2. Actualizar repositorios e instalar HTTrack (`sudo apt update && sudo apt install httrack -y`).
3. Crear el directorio `/home/kali/lab3_httrack` y ejecutar el espejo controlado con `httrack`.
4. Inspeccionar el árbol de directorios clonado (`tree`: 5 directorios, 18 archivos; 13 enlaces escaneados y 12 archivos del sitio escritos).
5. Levantar el clon localmente en `http://127.0.0.1:8080` y verificar su fidelidad visual respecto al sitio original.
6. Ejecutar auditoría estática con `grep -Rni` para `api`, `fetch`, `token`, `key`, `http` y el patrón unificado `grep -RniE "api[_-]?key|secret|password|passwd|token|authorization" .`.

## Evidencias y Hashes
12 capturas en `Taller_3_HTTrack.docx`; árbol `tree` del clon; réplica funcional en `127.0.0.1:8080`; salidas de `grep` mostrando únicamente coincidencias informativas/educativas y la variable inocua `STORE_KEY = "nl-hud:" + variant + ":v1"`.

## Criterio de Aceptación
Sitio clonado operable localmente al 100% a nivel visual y clasificación verificada de todas las coincidencias de texto en el código cliente.

## Análisis Defensivo
Mantener cero credenciales o API keys en archivos JS/HTML del cliente (delegar al backend mediante variables de entorno), proteger o excluir directorios de caché (`hts-cache` / `hts-log.txt`), bloquear acceso a `.env`/`.git` e implementar cabeceras CSP y `X-Content-Type-Options: nosniff`.

## Resultado
Prueba P03 completada. Hallazgo H-02 (Severidad Baja / Informativa): la superficie visual y estática del front-end es 100% replicable por cualquier visitante, pero el sitio auditado no expone credenciales reales ni tokens en el código cliente.
