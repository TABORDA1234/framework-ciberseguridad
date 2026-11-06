# FC-LAB-004 — Esteganografía con Steghide y Verificación Forense de Integridad (Partes 1–3)

- **Versión y Autor:** v1.0 — 02–04/09/2026 — Autor: Luis Carlos Taborda Flórez
- **Objetivo:** Aplicar procedimientos de ocultamiento cifrado y extracción forense de archivos dentro de portadores JPEG mediante Steghide, comprobando la preservación exacta de la evidencia digital con funciones hash SHA-256.
- **Dominio y Fase:** Dominio D06 (Forense digital) | Fases 03 (Identificación), 04 (Análisis) y 06 (Verificación de integridad)
- **Roles:** Ejecutor: Analista Forense (DFIR) | Custodio de Evidencias: Responsable de validación de hashes SHA-256
- **Entorno y Autorización:** Kali Linux con `steghide version 0.6.0` (cifrado `rijndael-128, cbc`, compresión activa) y `sha256sum` en `~/laboratorio_esteganografia/{originales,resultado,extraido,evidencias}`.
- **Entradas:** Parte 1: portador `portada.jpg` (2.3 MB, 2400x4282) y `mensaje_secreto.txt` (200 bytes). Parte 2: tres portadores (`proton.jpg` 21K, `neutron.jpg` 32K, `electron.jpg` 403K), tres archivos (`inicio.txt`, `nudo.txt`, `desenlace.txt`) y contraseñas (`desayuno`, `almuerzo`, `cena`).

## Procedimiento Reproducible
1. Crear la estructura de carpetas forenses (`originales`, `resultado`, `extraido`, `evidencias`) e instalar Steghide.
2. Incrustar (`steghide embed -ef ... -cf ... -sf ...`) `mensaje_secreto.txt` dentro de `portada.jpg` generando `imagen_secreta.jpg`.
3. Inspeccionar metadatos del archivo esteganográfico (`steghide info resultado/imagen_secreta.jpg`, capacidad 126.3 KB, cifrado AES/Rijndael-128 CBC).
4. Extraer el archivo oculto en `extraido/` (`steghide extract -sf ...`) y verificar su hash SHA-256 contra el original.
5. Ejecutar el escenario colaborativo de 3 partes incrustando y extrayendo `inicio.txt` (`secreta_proton.jpg`), `nudo.txt` (`secreta_neutron.jpg`) y `desenlace.txt` (`secreta_electron.jpg`), validando los 3 hashes SHA-256.

## Evidencias y Hashes
15 capturas en `taller 4 esteganografia.docx` y coincidencia bit a bit de los 4 pares de hashes SHA-256:
- `mensaje_secreto.txt`: `69f48e58f87ca075d498e129c819def80b24ef9d6371448900b5168df7602d8d`
- `inicio.txt`: `29c603cd87b7ca63dea1f7476dd872cb85ebf0733e0c3c75268be40d908714ed`
- `nudo.txt`: `288f2bb70799a931bfa8c0342f40a1d6048b1cef06d5bd9f28a0afc5902253f3`
- `desenlace.txt`: `58e7cb52b5bfba070c9c40af8579a6428a3deaeb176cb3358411dda1251acc23`

## Criterio de Aceptación
100% de coincidencia entre los hashes SHA-256 de los archivos originales y los archivos extraídos, garantizando cadena de custodia e integridad forense sin alteración visual aparente del portador.

## Análisis Defensivo
Implementar inspección de entropía, recodificación/sanitización automática de imágenes subidas por usuarios en portales corporativos (re-encoding elimina payloads de Steghide) y políticas DLP frente a exfiltración esteganográfica.

## Resultado
Prueba P03 completada con 100% de integridad forense verificada. Se documenta además el riesgo de canales encubiertos de exfiltración en imágenes (Hallazgo H-03, Severidad Media).
