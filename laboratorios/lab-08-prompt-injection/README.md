# FC-LAB-008 — Seguridad en IA y LLMs: Informe Contextual de Prompt Injection

- **Versión y Autor:** v1.0 — Noviembre de 2026 — Autor: Luis Carlos Taborda Flórez
- **Objetivo:** Evaluar los vectores ofensivos de Prompt Injection directo e indirecto (RAG) en aplicaciones que integran Modelos de Lenguaje (LLMs), su relación con vulnerabilidades web tradicionales y el diseño de defensas en profundidad basadas en OWASP Top 10 for LLMs (2025) y MITRE ATLAS.
- **Dominio y Fase:** Dominio D08 (Seguridad de IA) | Fases 02 (Prevención), 04 (Análisis) y 05 (Mitigación)
- **Roles:** Ejecutor: Analista de Seguridad en IA (Red/Blue Team) | Revisor: Arquitecto de Aplicaciones con LLM / Purple Team
- **Entorno y Autorización:** Análisis técnico-metodológico estructurado bajo estándares `OWASP Top 10 for LLMs (2025)` (`LLM01`, `LLM02`, `LLM06`, `LLM07`), `OWASP Top 10 Web (2021)` (`A01`, `A04`, `A05`), `MITRE ATLAS` (`AML.T0051`) y `MITRE D3FEND` (`AML.T0051.001`).
- **Entradas:** Cinco buenas prácticas de seguridad en LLMs (testing seguro neutro, vectores indirectos RAG, separación `system`/`user`, mínimo privilegio en APIs y filtrado DLP de salidas) y cinco ejes de evaluación arquitectónica.

## Procedimiento Reproducible
1. Caracterizar la vulnerabilidad de Prompt Injection (`OWASP LLM01:2025`) y contrastarla con inyecciones sintácticas clásicas (SQLi/XSS), vinculándola con `OWASP A01:2021` (Broken Access Control) y `A04/A05`.
2. Analizar la causa raíz arquitectónica: la concatenación del `System Prompt` y la entrada del usuario en una misma ventana de tokens sin separación física entre el plano de control y el plano de datos (riesgos de Override, Confusión de Roles y `System Prompt Leakage` `LLM07:2025`).
3. Evaluar el impacto en agentes conectados a bases de datos, sistemas RAG y herramientas (`Function Calling`): exfiltración de datos confidenciales (`LLM02:2025`), exceso de agencia (`LLM06:2025`) y manipulación de decisiones del negocio.
4. Modelar el Prompt Injection como ingeniería social moderna aplicada a sistemas probabilísticos (falsa autoridad de desarrollador, urgencia/emergencia simulada y juegos de rol / Role-Play).
5. Diseñar la estrategia de mitigación en tres capas: aislamiento de contexto con delimitadores (`<user_input>`), guardrails duales de entrada/salida (DLP) y mínimo privilegio con supervisión humana (`Human-in-the-Loop`).

## Evidencias y Hashes
Documento completo `Laboratorio No. 8.docx` (Sección 1: 5 buenas prácticas operativas; Sección 2: Cuestionario analítico de 5 preguntas resueltas con mapeo normativo `OWASP LLM 2025` y `MITRE ATLAS`).

## Criterio de Aceptación
Alineación explícita de los vectores de ataque directo/indirecto y de los controles propuestos con las categorías `OWASP LLM01`, `LLM02`, `LLM06`, `LLM07` y `MITRE ATLAS AML.T0051`.

## Análisis Defensivo
1. Separar estrictamente los roles `system` y `user` en la API y encapsular las entradas externas con delimitadores explícitos (`<user_input>`) tratados como datos no ejecutables.
2. Aplicar el principio de mínimo privilegio en conectores/APIs (`OWASP LLM06:2025`), otorgando permisos de solo lectura por defecto y exigiendo aprobación humana (`Human-in-the-Loop`) para acciones sensibles.
3. Tratar el `System Prompt` como público/no secreto (nunca almacenar API keys ni credenciales en él, `LLM07:2025`) e implementar clasificadores de entrada y filtros DLP de salida (`LLM02:2025`).

## Resultado
Prueba P08 completada. Se documenta el Hallazgo H-08 (Severidad Alta): las aplicaciones con LLMs que concatenan instrucciones y datos no confiables (del usuario o fuentes RAG) y delegan autorizaciones o llamados a APIs al modelo sin validación en backend ni `Human-in-the-Loop` son vulnerables a compromiso de control de acceso, exfiltración y ejecución no autorizada.
