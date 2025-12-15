# ⚡🎓 Satly –  App Educativa Gamificada con Recompensas en Satoshis

Este proyecto es una plataforma educativa gamificada que entrega **satoshis gratis** a los usuarios como recompensa por aprender. Con esto se rompe la principal barrera de entrada a la **Lightning Network**: la mayoría no sabe cómo conseguir sus primeros sats ni cómo usarlos de manera práctica.  
El sistema combina un **backend modular** con un **frontend en Flutter**, todo conectado a **LNBits** y **Firebase Firestore**. La idea es tener control total del flujo de usuario, sus progresos, quizzes, login y recompensas, todo desde un mismo entorno unificado.

---

## 🧠 Concepto General
El usuario ingresa, responde quizzes, recibe sats, y usa esos sats dentro del propio ecosistema educativo para avanzar o desbloquear nuevas funciones.  
Cada interacción está pensada como una microtransacción educativa que refuerza el aprendizaje y la motivación.

---

## ⚙️ Flujo Técnico General
1. El usuario entra por **login o registro** (correo, Google o LNURL-auth).  
2. El backend (Node.js + Express o Python FastAPI) gestiona:  
   - Usuarios (registro, login, roles, niveles)  
   - Quizzes (creación, asignación, validación)  
   - Recompensas Lightning (vía API de LNBits)  
   - Límite de recompensas diario  
   - Conexión con Firestore para datos del usuario, progreso y estadísticas.  
3. El **frontend en Flutter** muestra:  
   - Pantalla de login  
   - Dashboard con progreso  
   - Vista de quizzes y recompensas  
   - Enlace con LNURL o factura para recibir sats  
   - Sistema de logros y animaciones de avance  

---

## 🏗️ Arquitectura Unificada
El proyecto sigue un esquema de arquitectura **hexagonal (ports & adapters)**, lo que permite conectar distintos servicios (LNBits, Firebase, IA, etc.) sin romper el núcleo de la aplicación.

**Backend (núcleo educativo + pagos):**  
- Capa de dominio → lógica de recompensas y validaciones  
- Capa de aplicación → casos de uso: crear quiz, evaluar respuesta, enviar recompensa  
- Capa de infraestructura → conexiones a LNBits y Firestore  
- Capa de interfaces → API REST principal consumida por Flutter  

**Frontend (Flutter):**  
- Módulo de autenticación  
- Módulo de quizzes  
- Módulo de recompensas  
- Módulo de progreso y estadísticas  
- Módulo de mentor IA (explicaciones dinámicas)  

Ambos (backend y frontend) se comunican mediante **HTTPS** y en tiempo real mediante **WebSockets o Stream API** para mostrar cambios de estado instantáneos (por ejemplo, cuando se acredita una recompensa).

---

## 💡 Flujo Diario del Usuario
1. Usuario inicia sesión → Firestore valida su identidad  
2. Sistema consulta nivel y límite de sats  
3. Usuario elige un quiz → responde  
4. Backend valida → si es correcto, llama al endpoint LNBits `/api/v1/payments`  
5. Se ejecuta pago Lightning → se actualiza saldo interno y progreso  
6. Frontend recibe confirmación → animación de recompensa + actualización de nivel  
7. Firestore guarda historial de aprendizaje y logros desbloqueados

---

## 🤖 Mentor IA
El Mentor IA amplía el backend con generación y evaluación inteligente:
- Genera quizzes dinámicos según el historial del usuario  
- Ofrece retroalimentación cuando falla una respuesta  
- Recomienda nuevos retos o repeticiones según métricas de rendimiento  
- Ajusta la dificultad automáticamente según tiempo y precisión  

El modelo puede conectarse a una API ligera (ej. GPT-4-mini, Llama API). Las preguntas base quedan almacenadas en Firestore.

---

## 🔑 Backend – Planificación Paso a Paso (sin código)
1. **Configuración inicial:**  
   - Crear entorno Node.js o Python  
   - Conectar con LNBits (API key y wallet_id)  
   - Configurar Firebase Firestore  

2. **Endpoints clave:**  
   - `/auth/register` y `/auth/login` → autenticación segura  
   - `/quiz/get` y `/quiz/submit` → gestión de quizzes  
   - `/rewards/send` → integración con LNBits  
   - `/user/progress` → estadísticas y límites diarios  

3. **Usuarios:**  
   Cada usuario tiene un documento Firestore con:  
   `{ uid, nombre, correo, sats_acumulados, nivel, racha, limite_diario, quizzes_completados }`  
   El backend verifica límite y permisos antes de enviar sats.

4. **Gestión de quizzes:**  
   - Firestore almacena quizzes base  
   - Backend selecciona o genera uno según nivel  
   - Al responder, se evalúa y si es correcto, se dispara la recompensa  

5. **Recompensas Lightning:**  
   - Backend comunica con LNBits vía `/api/v1/payments`  
   - Registra transacción (`pendiente` / `completado`)  
   - Devuelve resultado al frontend  

6. **Escalabilidad:**  
   - Posible cola de eventos (Redis)  
   - Servicios independientes para auth, quiz, rewards

---

## 📱 Frontend Flutter – Estructura Interna
App Flutter autónoma, conectada al backend vía HTTPS, usando `provider` para estado global.

1. **Splash / Login:**  
   - Email o LNURL-auth  
   - Token JWT almacenado en `flutter_secure_storage`  

2. **Dashboard:**  
   - Progreso, sats, nivel  
   - Botón “Iniciar Quiz Diario”  

3. **Quiz:**  
   - Pregunta + opciones  
   - Envío al backend  
   - Respuesta correcta → animación + saldo actualizado  

4. **Recompensa:**  
   - Muestra sats ganados  
   - LNURL withdraw o factura opcional  

5. **Perfil:**  
   - Datos personales  
   - Historial y logros  
   - Conectar wallet externa  

6. **Mentor IA:**  
   - Chat integrado con análisis de progreso  
   - Recomendaciones de nuevos retos  

---

## 🧩 Base de Datos (Firestore o Supabase)
Colecciones principales:
- `users` → datos generales  
- `quizzes` → preguntas base y dinámicas  
- `progress` → estadísticas y rachas  
- `transactions` → registro de pagos Lightning  
- `achievements` → logros  

Subcolecciones (`user/quizzes_completados`, `user/rewards`) optimizan consultas y escalabilidad.

---

## 🧠 Lógica de Progresión
- Nivel 1 → 50 sats / día  
- Nivel 5 → 200 sats / día  
- Nivel 10 → misiones patrocinadas  

El backend controla este límite diario y bloquea pagos tras alcanzarlo (reset a medianoche UTC).

---

## 💰 Economía Educativa Interna
Los sats pueden usarse para:
- Desbloquear quizzes premium  
- Comprar pistas  
- Torneos o misiones grupales  
- Donaciones educativas  

Se mantiene así un flujo circular dentro del ecosistema.

---

## 🚀 Herramientas y Dependencias

**Software:**  
- Flutter SDK 3.x.x+  
- Node.js 18+  
- LNBits (API habilitada)  
- Firebase Firestore  o Supabase
- Git / GitHub  
- Android Emulator o Chrome  
- Thunder Client / Postman  

**Dependencias Flutter:**  
- `http` → llamadas API  
- `provider` → estado global  
- `flutter_secure_storage` → datos locales seguros  
- `google_fonts` → fuentes  
- `fl_chart` → gráficas  
- `flutter_spinkit` → animaciones  
- `web_socket_channel` → tiempo real  

---

## 🌍 Impacto Esperado
- Accesibilidad financiera con primeros sats sin riesgo  
- Educación real con recompensas tangibles  
- Impulso a Lightning Network  
- Ecosistema gamificado y escalable  
- Comunidad educativa autosostenible  
