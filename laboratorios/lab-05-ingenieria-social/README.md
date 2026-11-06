# FC-LAB-005 — Ingeniería Social: Construcción y Análisis Cruzado de Escenarios (Vishing y Phishing)

- **Versión y Autor:** v1.0 — Septiembre/Octubre 2026 — Autor: Luis Carlos Taborda Flórez
- **Objetivo:** Diseñar y evaluar escenarios de ingeniería social para descomponer los vectores de ataque al factor humano (canal, pretexto, suplantación, disparadores psicológicos e indicadores de alerta) y definir controles preventivos.
- **Dominio y Fase:** Dominio D05 (Factor humano) | Fases 02 (Prevención), 03 (Identificación) y 05 (Mitigación)
- **Roles:** Autor de escenario: Analista Red Team | Analista revisor: Analista Blue Team / Concienciación
- **Entorno y Autorización:** Ejercicio académico controlado de simulación conceptual y análisis cruzado entre pares (sin envío real de correos maliciosos ni llamadas a terceros).
- **Entradas:** Escenario 1 (propio): Vishing universitario suplantando a 'Oficina de Registro y Control' para robar código SMS de 6 dígitos. Escenario 2 (recibido): Phishing corporativo a practicante en 'Grupo Core S.A.S.' suplantando a 'Soporte de Jira Cloud' por supuesto bloqueo de facturación en 12 horas.

## Procedimiento Reproducible
1. Construir el escenario propio de Vishing definiendo contexto académico, pretexto de cancelación de matrícula y solicitud de código OTP por SMS.
2. Analizar el escenario recibido del compañero mediante una matriz estructurada de 11 elementos (contexto, objetivo, canal, pretexto, identidad/rol, persuasión, acción solicitada, clasificación principal, técnicas complementarias, indicadores de alerta y medidas preventivas).
3. Contrastar la intención original del autor contra la matriz de análisis del receptor (8 de 8 vectores identificados con exactitud).
4. Formular las medidas de mitigación organizacionales y humanas.

## Evidencias y Hashes
Documento `Laboratorio_5_Ingenieria_Social_Completo.docx` con las matrices de análisis y comparación (100% de coincidencia en la identificación de Phishing + Pretexting + Impersonation).

## Criterio de Aceptación
Identificación precisa de los disparadores psicológicos (Autoridad + Temor + Urgencia), de los indicadores de alerta (enlace inesperado, plazo de 12 h, solicitud de credenciales/OTP) y de los controles de verificación fuera de banda.

## Análisis Defensivo
Capacitación periódica contra Phishing/Vishing, protocolo estricto de verificación por canal oficial independiente (nunca usar enlaces de correos urgentes ni dictar códigos OTP por teléfono) y adopción de MFA resistente a phishing (FIDO2/WebAuthn en lugar de SMS).

## Resultado
Prueba P04 completada. Hallazgo H-04 (Severidad Alta): la combinación de autoridad, temor y urgencia sobre canales no verificados permite comprometer credenciales y códigos 2FA por SMS si no existen protocolos de verificación fuera de banda.
