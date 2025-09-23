# ⚡🎓  - Plataforma Educativa Gamificada con Recompensas en Satoshis

Este proyecto es una plataforma educativa gamificada que entrega **satoshis gratis** a los usuarios como recompensa por aprender. Con esto se rompe la principal barrera de entrada a la **Lightning Network**: la mayoría no sabe cómo conseguir sus primeros sats ni cómo usarlos de manera práctica.

---

## 🎯 Dinámica Principal
- 👤 **Ingreso del usuario**: ve tareas/preguntas  
- ✅ **Respuestas correctas**: ingresa su factura Lightning  
- ⚡ **Recompensas automáticas**: sats enviados usando **LNBits**  
- 🏆 **Progresión diaria**: límites progresivos de recompensas  

✨ **Innovación clave:** los sats funcionan como **moneda educativa** para desbloquear retos, comprar pistas o participar en torneos.

---

## 🏗️ Arquitectura Técnica
**Arquitectura hexagonal (ports & adapters)** para modularidad y escalabilidad:  
- 📌 **Dominio** → reglas de negocio puras  
- 📌 **Aplicación** → casos de uso  
- 📌 **Infraestructura** → LNBits, base de datos, adapters  
- 📌 **Interfaces** → API REST  

**Frontend (React ⚛️ o Flutter Web)**:  
- Login, dashboard, progreso, recompensas y economía interna de sats  

**Mentor IA 🤖**:  
- Genera preguntas dinámicas adaptadas al nivel  
- Explica respuestas incorrectas  
- Recomienda retos y ajusta dificultad  

---

## 🚀 Roadmap de Desarrollo
1. 🔑 **Backend con LNBits**: corazón del sistema  
2. 🌐 **Frontend sencillo**: login, tareas, recompensas y límite diario  
3. 🏆 **Iterar** con gamificación avanzada, economía de sats e IA  

---

## 🛠️ Idea Detallada

### 1️⃣ Problema que resuelve
- ❌ No saber obtener los primeros sats  
- ❌ Temor a perder dinero  
- ❌ Falta de comprensión de transacciones instantáneas  

### 2️⃣ Concepto central
- 📖 Aprender Bitcoin y Lightning  
- ⚡ Recibir sats como recompensa real  
- 🎮 Aprender gamificado y progresivo  
- 💰 Usar sats como moneda educativa interna  

**Clave:** “Aprendes jugando, ganas sats reales y los usas para seguir aprendiendo”.

### 3️⃣ Experiencia del usuario
1. **Login**: email, LNURL-auth o mini-wallet  
2. **Retos/Quizzes**: niveles Principiante, Intermedio, Avanzado  
   - 5–25 sats por reto según nivel  
3. **Resolución**: texto, múltiple opción o invoice LN  
4. **Verificación**: automática o manual según reto  
5. **Recompensas inmediatas**: sats + estadísticas  
6. **Límite diario progresivo**:  
   - Nivel 1 → 50 sats/día  
   - Nivel 5 → 200 sats/día  
   - Nivel 10 → misiones patrocinadas  
7. **Gamificación y logros**: rachas, retos diarios, coleccionables  
8. **Uso de sats**: desbloquear pistas, retos premium, torneos  

### 4️⃣ Beneficios para el usuario
- 💰 Primeros sats reales  
- 📚 Aprendizaje práctico  
- 🎯 Gamificación motivadora  
- 🔒 Entorno seguro  
- ♻️ Economía interna de sats  

### 5️⃣ Innovación
- ⚡ Recompensas reales  
- 🎮 Micro-aprendizaje con límite progresivo  
- 📈 Economía interna  
- 🤖 Mentor IA adaptativo  

### 6️⃣ Beneficios para terceros
- 🏢 Patrocinio educativo  
- 📢 Promoción Lightning  
- 💼 Monetización sostenible  

---

## 🏗️ Estructura de Páginas / Site Map

**Landing Page**  
- 🎨 Animación interactiva  
- 🔘 Botón “Comienza ahora”  

**Registro / Login**  
- ✉️ Email o LNURL-auth  
- 💳 Mini-wallet opcional  

**Dashboard**  
- 📊 Progreso diario  
- 🏅 Nivel y logros  
- 📈 Gráfica educativa  

**Retos / Quizzes**  
- 📅 Quizzes diarios  
- ⚡ Retos con invoices LN  
- 🤖 IA ajusta dificultad y recompensa  

**Guías Interactivas 📚**  
- Crear wallet Lightning  
- Enviar/Recibir sats  
- Seguridad básica  

**Comunidad / Ranking 👥**  
- 🌐 Ranking global  
- 🏆 Logros especiales  
- 🤝 Retos grupales y foro  

---

## 🤖 Mentor IA
- Genera preguntas dinámicas  
- Explica errores  
- Recomienda retos  
- Ajusta dificultad automáticamente  

---

## 📊 Sistema de Progresión
- Nivel 1 → 50 sats/día  
- Nivel 5 → 200 sats/día  
- Nivel 10 → misiones patrocinadas  

**Logros:**  
- Primeros Pasos, Maestro del Quiz, Racha Diaria, Coleccionista de Sats  

---

## 💡 Beneficios Clave
**Usuarios:**  
- 💰 Primeros sats reales  
- 📚 Aprendizaje divertido  
- 🎯 Gamificación motivadora  
- 🔒 Entorno seguro  

**Comunidad:**  
- 🏢 Patrocinios educativos  
- 📢 Adopción Lightning  
- 💼 Monetización sostenible  

---

## 🌍 Impacto Esperado
- Microlearning con recompensas tangibles  
- Experiencia directa con Lightning Network  
- Ecosistema escalable y gamificado  
- Comunidad activa  

---

## 🚀 Lo necesario - Software y dependencias

### 🖥️ Software
- Flutter SDK 3.x.x+ (Dart incluido) ✅
- Visual Studio Code o Android Studio (con extensiones Flutter/Dart) ✅ 
- Node.js v18+  ✅
- Git  ✅
- Github ✅
- LNbits (servidor nube o local)  
- Android Emulator o dispositivo Android  
- Navegador moderno (Chrome recomendado)  ✅
- Firebase Firestore (Cloud)
- **Opcional:** Thunder Client / Insomnia para probar APIs  

### 📦 Dependencias Flutter
- `http` → consumir APIs  
- `provider` → manejo de estado  
- `flutter_secure_storage` → almacenamiento seguro  
- `google_fonts` → fuentes modernas  
- `flutter_spinkit` → animaciones de carga  
- `web_socket_channel` → WebSockets (opcional)  
- `fl_chart` → gráficas de progreso  


