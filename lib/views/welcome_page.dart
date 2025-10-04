// lib/views/welcome_page.dart

import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait = size.height > size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet =
                constraints.maxWidth >= 600 && constraints.maxWidth < 1000;
            final isDesktop = constraints.maxWidth >= 1000;

            // Escala adaptable según dispositivo
            double baseFont = isDesktop ? 24 : (isTablet ? 20 : 18);
            double titleFont = isDesktop ? 62 : (isTablet ? 48 : 40);
            double logoSize = isDesktop ? 180 : (isTablet ? 140 : 110);

            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.blue.shade50,
                    Colors.blue.shade100,
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 120 : (isTablet ? 60 : 24),
                  vertical: isPortrait ? 32 : 20,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Espacio superior
                      SizedBox(height: isPortrait ? 60 : 30),

                      // Contenido principal
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Logo con mejor efecto visual
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(0.4),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                  offset: const Offset(0, 15),
                                ),
                              ],
                            ),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 600),
                              width: logoSize,
                              height: logoSize,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF0066FF),
                                    Color(0xFF00BFFF),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.bolt_rounded,
                                size: logoSize * 0.5,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          SizedBox(height: isPortrait ? 40 : 30),

                          // Título con mejor jerarquía
                          Column(
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) => const LinearGradient(
                                  colors: [
                                    Color(0xFF0066FF),
                                    Color(0xFF00BFFF),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ).createShader(bounds),
                                child: Text(
                                  "EduSats",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: titleFont,
                                    fontWeight: FontWeight.w900,
                                    height: 1.0,
                                    letterSpacing: -1.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              
                              const SizedBox(height: 12),
                              
                              // Subtítulo
                              Text(
                                "Aprende • Gana • Domina",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: baseFont * 0.8,
                                  color: Colors.blue.shade700,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Emojis decorativos con animación sutil
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            child: Text(
                              "⚡ 🎓 💰",
                              style: TextStyle(
                                fontSize: baseFont + 4,
                              ),
                            ),
                          ),

                          SizedBox(height: isPortrait ? 32 : 24),

                          // Descripción con mejor tipografía
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "Domina Bitcoin y Lightning Network mientras ganas sats reales en cada lección.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: baseFont,
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: isPortrait ? 80 : 50),

                      // Botones con mejor diseño
                      Column(
                        children: [
                          // Botón principal con sombra
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: CustomButton(
                              text: 'Iniciar Sesión',
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/login'),
                              isPrimary: true,
                              height: isPortrait ? 60 : 54,
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Botón secundario con borde
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.blueAccent,
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CustomButton(
                                text: 'Crear Cuenta',
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/register'),
                                isPrimary: false,
                                height: isPortrait ? 60 : 54,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: isPortrait ? 50 : 30),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}