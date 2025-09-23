# 📝 Avances del Proyecto - 22/09/2025

## Resumen General
Hoy se avanzó en la definición inicial y configuración del proyecto **SparkSeed**, la plataforma educativa gamificada que recompensa con satoshis por aprendizaje en Lightning Network. Se sentaron las bases para el desarrollo en **Flutter**, con estructura de carpetas, archivos iniciales y esqueleto de vistas.

---

## ✅ Avances Técnicos

### 1. Configuración Inicial
- Creación del proyecto Flutter: `sparkseed_temp`.
- Versión de Flutter usada: `3.35.3`.
- SDK Dart: `3.9.2`.
- IDEs utilizados: **Visual Studio Code**, soporte para Flutter y Dart.
- Control de versiones: **Git** con repositorio inicializado.

### 2. Estructura de Carpetas
Se definió una estructura clara y modular:


### 3. Archivos Iniciales
- Archivos `placeholder.dart` creados en las carpetas `models`, `providers`, `services`, `widgets` y `utils` para empezar a organizar la lógica.
- `views` iniciales: landing, login, dashboard y quiz.
- Widget reutilizable: `CustomButton` en `lib/widgets/custom_button.dart`.
- Archivo de documentación: `docs/README_PROYECTO.md`.

### 4. Implementación de Funcionalidades Básicas
- **Landing Page:** estructura básica con fondo blanco.
- **Login Page:** formulario de inicio de sesión básico, fondo blanco, sin conexión a backend todavía.
- **Dashboard Page:** placeholder para progreso del usuario.
- **Quiz Page:**
  - Avanza pregunta por pregunta.
  - Botón para terminar quiz y regresar al dashboard.
  - Preguntas de ejemplo implementadas.
  - Navegación funcional sin errores.
- **CustomButton:** botón reutilizable estilizado para toda la app.

### 5. Dependencias Iniciales
- `flutter`
- `cupertino_icons`
- Configuración de assets y fuentes en `pubspec.yaml` lista para futuros añadidos.
- Preparado para integración futura de JS, APIs y LNBits.

---

## 📌 Próximos pasos
1. Integrar navegación completa entre todas las vistas.
2. Preparar **esqueleto de gamificación** y economía interna de sats.
3. Diseñar paleta de colores inicial (por ahora fondo blanco + azul).
4. Preparar backend con LNBits y prueba de APIs (sin usar Postman, explorar alternativas).
5. Continuar con el desarrollo de **Login**, **Dashboard** y **Quiz avanzado**.
6. Documentar cada avance en `docs/README_PROYECTO.md`.

---

**Observaciones:**  
- Hoy se estableció la base de todo el proyecto, asegurando que no haya errores de compilación.  
- Todo listo para comenzar con integración de funcionalidades y estética de la app.  


# Resumen del Proyecto  -  23/09/2025

## 1. Flujo de navegación
- La aplicación tiene un flujo base definido:
  - **Login** → HomePage
  - **Registro** → HomePage
  - No se agregaron nuevas páginas por ahora.
- Las pantallas de Login y Registro están funcionales, con validación básica de datos.

## 2. Perfil del usuario
- Se creó la **ProfilePage** como pantalla principal del usuario.
- Funcionalidades implementadas:
  - **Editar nombre del usuario** mediante un diálogo.
  - **Editar correo electrónico** mediante un diálogo.
  - **Cambiar foto de perfil**:
    - Funciona en **web** y **móvil**.
    - Soporta selección desde galería.
  - **Cerrar sesión** desde la pantalla de perfil.
- Estadísticas del usuario:
  - SATS totales, quizzes completados y nivel.
  - Visualización de información de cuenta (fecha de registro, email verificado, ID de usuario).

## 3. Diseño de interfaz
- Se aplicó un **diseño uniforme y moderno** en todas las pantallas existentes.
- Uso de **cards** para secciones principales (Perfil, Estadísticas, Configuración, Información de cuenta).
- **Botones y elementos interactivos** con colores destacados y consistentes.
- **Modo de interacción responsive** en móviles y web.
- Eliminación de botones innecesarios:
  - **Botón "Simular progreso"** eliminado por decisión de diseño.

## 4. Configuración y ajustes
- Se mantuvieron las opciones de configuración:
  - **Notificaciones** (placeholder)
  - **Privacidad y seguridad** (placeholder)
- La estructura permite **fácil extensión futura** sin romper la interfaz actual.

## 5. Mejoras generales
- Diseño más **visual y moderno** en todas las pantallas existentes.
- Funcionalidad de edición **totalmente integrada** con cambios visibles en tiempo real.
- Se preservó la estabilidad del flujo de navegación y la integridad de la interfaz.

## 6. Próximos pasos sugeridos
- Integrar backend o persistencia local para que los cambios de nombre, correo y foto sean **permanentes**.
- Extender la configuración de usuario para notificaciones y seguridad.
- Mejorar la personalización de estadísticas y progreso del usuario.
