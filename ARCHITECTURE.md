# Arquitectura del Frontend

## Estructura de Agentes (Roles Virtuales)
1. **@UI_UX_DEV:**
   - **Responsabilidad:** Guardián del Design System. Verifica `core/components` antes de crear nada nuevo.
   - **Tarea:** Implementa pantallas usando SOLO componentes existentes o creando nuevos genéricos.

2. **@LOGIC_DEV:**
   - **Responsabilidad:** Lógica de negocio y Estado.
   - **Tarea:** Implementa Riverpod Providers, Casos de Uso y Entidades.

3. **@INFRA_DEV:**
   - **Responsabilidad:** "The Plumber".
   - **Tarea:** Configura Dio, Isar, Repositorios y Parseo de JSON.
