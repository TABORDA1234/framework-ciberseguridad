# FC-LAB-007 — Análisis de Autenticación Web e Interceptación HTTP con Burp Suite

- **Versión y Autor:** v1.0 — 27/10/2026 — Autor: Luis Carlos Taborda Flórez
- **Objetivo:** Interceptar, repetir y comparar el diseño de los flujos de autenticación HTTP/2 en cuatro aplicaciones web (`OWASP Juice Shop`, `Q10`, `PortSwigger Auth0` y `SAC USTA`), evaluando endpoints, formatos de serialización de credenciales y códigos/mensajes de respuesta ante fallos.
- **Dominio y Fase:** Dominios D03 (Seguridad web) y D04 (Comunicaciones y APIs) | Fases 03 (Identificación) y 04 (Análisis)
- **Roles:** Ejecutor: Pentester Web / Analista Ofensivo Controlado | Defensor: Arquitecto de Seguridad de Aplicaciones
- **Entorno y Autorización:** Kali Linux con `Burp Suite Community Edition v2026.9` (módulos `Proxy Intercept`, `HTTP history`, `Repeater` e `Inspector`) y navegador Chromium integrado escuchando en `127.0.0.1:8080`.
- **Entradas:** Cuatro endpoints de login evaluados con una única tentativa controlada de credencial inválida:
1. Juice Shop: `POST /rest/user/login` (`demo.owasp-juice.shop`)
2. Q10: `POST /Login?ReturnUrl=%2F&aplentId=611700f3-1a59-4c15-b087-ad613f7f0294` (`site6.q10.com`)
3. PortSwigger: `POST /u/login?state=...` (`login.portswigger.net`)
4. SAC USTA: `POST /sgacampus/services/basf00/login/fetch/3b19040dc77f6598f7b5455a89786639` (`sac.usantotomas.edu.co`)

## Procedimiento Reproducible
1. Activar `Intercept on` en Burp Proxy y capturar la petición `POST` de inicio de sesión en cada plataforma.
2. Inspeccionar cabeceras, cookies, tipo de contenido (`Content-Type`) y estructura del cuerpo en `Pretty`/`Raw`/`Inspector`.
3. Enviar cada solicitud a `Burp Repeater` (`Ctrl+R`), reenviarla (`Send`) y analizar el código de estado HTTP y el cuerpo de respuesta.
4. Comparar mecanismos de transporte, codificación (JSON, `x-www-form-urlencoded` y JSON en Base64) y semántica de errores.

## Evidencias y Hashes
8 capturas de Proxy y Repeater en `Lab7_BurpSuite_Entrega.docx`:
- Juice Shop: Body JSON texto plano -> Respuesta `HTTP/2 401 Unauthorized` (`Invalid email or password.`).
- Q10: Body `x-www-form-urlencoded` (con `cf-turnstile-response` vacío) -> Respuesta `HTTP/2 200 OK` con JSON `{"status":"error","message":"El usuario o contraseña son inválidos"}` y cabecera `invalidattempts: 1`.
- PortSwigger: Body `x-www-form-urlencoded` -> Respuesta `HTTP/2 400 Bad Request` (HTML Auth0 con `X-Ratelimit-Limit: 300`).
- SAC USTA: Body JSON codificado en Base64 (`ew0gICAgInF1...`) -> Respuesta `HTTP/2 200 OK` con JSON `{"status":-5, "errors":{"userName":"Usuario o clave incorrectos."}}` y cabecera `X-Frame-Options: ALLOWALL`.

## Criterio de Aceptación
Documentación comparativa completa de los 4 flujos de login (endpoint, método, formato del payload y comportamiento ante credenciales inválidas).

## Análisis Defensivo
1. No depender de Base64 como mecanismo de protección (es codificación reversible, no cifrado).
2. Estandarizar respuestas de error HTTP (`401 Unauthorized`) para que WAF/SIEM detecten intentos fallidos sin necesidad de parsear cuerpos JSON con `HTTP 200 OK`.
3. Corregir en SAC USTA la cabecera `X-Frame-Options: ALLOWALL` por `DENY` o `SAMEORIGIN` (junto con `frame-ancestors 'self'`) para prevenir ataques de Clickjacking, y asegurar la validación estricta en servidor del token anti-automatización (`cf-turnstile-response`) en Q10.

## Resultado
Prueba P07 completada. Se documentaron los hallazgos H-06 (Severidad Media: uso de `HTTP 200 OK` en fallos de autenticación y ofuscación débil Base64 en SAC/Q10 que dificulta el monitoreo en SIEM/WAF) y H-07 (Severidad Media: cabecera `X-Frame-Options: ALLOWALL` observada en la respuesta de SAC USTA).
