# ⚡🎓 Satly – Plataforma Educativa Gamificada con Recompensas en Satoshis

Satly es una plataforma educativa gamificada que entrega **satoshis gratis** a los usuarios como recompensa por aprender. Rompe la principal barrera de entrada a la Lightning Network: la mayoría no sabe cómo conseguir sus primeros sats ni cómo usarlos de manera práctica.

La plataforma combina un **backend modular en Node.js + TypeScript + Firebase** con un **frontend web en React + Vite**, todo conectado a LNBits para pagos Lightning. Integra progresos, quizzes, login, recompensas y estadísticas en un entorno web accesible y escalable.

---

## 🧠 Concepto General

Cada interacción es una **microtransacción educativa**:

1. El usuario inicia sesión y responde quizzes.  
2. Recibe sats por respuestas correctas.  
3. Usa los sats dentro del ecosistema educativo para avanzar o desbloquear funciones.

---

## ⚙️ Flujo Técnico General

- Login o registro: correo o LNURL-auth.  
- Backend (Node.js + Express + TypeScript): gestiona usuarios, quizzes y recompensas Lightning vía LNBits, límite diario y conexión con Firebase Firestore para datos del usuario.  
- Frontend web (React + Vite): muestra login, dashboard, quizzes, recompensas, animaciones y logros.  
- Seguridad y tiempo real: HTTPS y WebSockets para actualizaciones instantáneas.

---

## 🏗️ Arquitectura Recomendada

**Backend (hexagonal)**  
- Dominio: lógica de recompensas y validaciones  
- Aplicación: casos de uso (crear quiz, evaluar respuesta, enviar recompensa)  
- Infraestructura: conexiones a LNBits y Firebase Firestore  
- Interfaces: API REST consumida por frontend  

**Frontend**  
- Módulos: autenticación, quizzes, recompensas, progreso y estadísticas  
- Comunicación: HTTPS + WebSockets para cambios instantáneos

---

## 💡 Flujo Diario del Usuario

1. Usuario inicia sesión; Firestore valida identidad.  
2. Sistema consulta nivel y límite de sats.  
3. Usuario elige un quiz y responde.  
4. Backend valida la respuesta; si es correcta, llama al endpoint de LNBits `/api/v1/payments`.  
5. Pago Lightning ejecutado → saldo interno y progreso actualizado.  
6. Frontend recibe confirmación → animación de recompensa y actualización de nivel.  
7. Firestore guarda historial y logros desbloqueados.

---

## 🔑 Backend – Planificación Paso a Paso

- Configuración: Node.js + Express + TypeScript, LNBits (API Key + wallet_id), Firebase Firestore  
- Endpoints clave:  
  - `/auth/register`  
  - `/auth/login`  
  - `/quiz/get`  
  - `/quiz/submit`  
  - `/rewards/send`  
  - `/user/progress`  
- Usuarios: uid, nombre, correo, sats_acumulados, nivel, racha, limite_diario, quizzes_completados  
- Gestión de quizzes: selección o generación según nivel, evaluación y disparo de recompensa  
- Recompensas Lightning: comunicación con LNBits, registro de transacción y resultado al frontend  
- Escalabilidad futura: posible cola de eventos (Redis) y servicios independientes para auth, quiz y rewards

---

## 🧩 Base de Datos (Firebase Firestore) o Supabase

- Colecciones principales: `users`, `quizzes`, `progress`, `transactions`, `achievements`  
- Subcolecciones: `user/quizzes_completados`, `user/rewards`  

---

## 🧠 Lógica de Progresión

- Nivel 1: 50 sats/día  
- Nivel 5: 200 sats/día  
- Nivel 10: misiones especiales o patrocinadas  

---

## 💰 Economía Educativa Interna

- Desbloquear quizzes premium, comprar pistas, torneos o misiones grupales  
- Donaciones educativas (opcional para futuras versiones)

---

## 🚀 Herramientas y Dependencias

- **Backend:** Node.js 18+, TypeScript, Express, Firebase Admin SDK, LNBits, dotenv, axios, jsonwebtoken  
- **Frontend:** React + Vite, axios, react-router-dom, Framer Motion (animaciones), CSS Modules / Vanilla CSS  
- Git/GitHub, Postman o Thunder Client para pruebas

---

## ☁️ Despliegue (Deploy)

- **Frontend:** Vercel o Netlify, `npm run build`, conectar repositorio GitHub  
- **Backend:** Render, Railway o Cloud Run, variables de entorno, `npm start`  
- Integración: URL correcta del backend, pruebas con LNBits testnet y Firebase sandbox

---

## 🌍 Impacto Esperado

Satly permite accesibilidad financiera con los primeros sats sin riesgo, educación real con recompensas tangibles, impulso a Lightning Network y un ecosistema gamificado y escalable. Convierte el aprendizaje en una experiencia productiva, divertida y con recompensas en satoshis.
