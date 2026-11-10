# FC-USTA: Framework Metodológico para la Evaluación, Análisis y Fortalecimiento de la Ciberseguridad

**Versión:** 1.0.0 | **Fecha:** Noviembre de 2026 | **Autor:** Luis Carlos Taborda Flórez

## Descripción
`FC-USTA` es un marco metodológico que organiza evaluaciones de ciberseguridad mediante seis fases iterativas (**01 Preparación, 02 Prevención, 03 Identificación, 04 Análisis, 05 Mitigación y 06 Verificación**) bajo un enfoque transversal **Purple Team**. Integra los 8 laboratorios desarrollados como instrumentos técnicos versionados (`FC-LAB-001` a `FC-LAB-008`).

## Estructura del Repositorio
- `docs/`: Documentación conceptual del framework, arquitectura, metodología, glosario y documento maestro `.docx`.
- `framework/`: Especificación de fases, protocolos y matrices (Casos de Prueba `CP-01` a `CP-08`, Riesgos `H-01` a `H-08` y Mitigación).
- `laboratorios/`: Fichas estandarizadas (`README.md`) y documentos de evidencia de los 8 laboratorios (`lab-01-shell` a `lab-08-prompt-injection`).
- `scripts/`: Scripts de verificación y automatización (auditoría de entorno y comprobación SHA-256).
- `plantillas/`: Plantilla estandarizada de laboratorio (`FC-LAB-XXX`).
- `casos-estudio/`: Casos analizados durante la validación empírica.
- `resultados/`: Indicadores, métricas y resumen ejecutivo de la evaluación.
