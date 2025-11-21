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

            double baseFont = isDesktop ? 24 : (isTablet ? 20 : 18);
            double titleFont = isDesktop ? 62 : (isTablet ? 48 : 40);
            double logoSize = isDesktop ? 180 : (isTablet ? 140 : 110);

            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFF8FBFF),
                    Color(0xFFE3F2FD),
                    Color(0xFFD6E4FF),
                  ],
                  stops: [0.0, 0.5, 1.0],
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
                      SizedBox(height: isPortrait ? size.height * 0.07 : 30),

                      /// Contenido principal
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Logo con mejor estilo visual
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.25),
                                  blurRadius: 25,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 600),
                              width: logoSize,
                              height: logoSize,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF007BFF),
                                    Color(0xFF00C2FF),
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

                          // Título con degradado sutil
                          Column(
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                      colors: [
                                        Color(0xFF007BFF),
                                        Color(0xFF00A6FF),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ).createShader(bounds),
                                child: Text(
                                  "Satly",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: titleFont,
                                    fontWeight: FontWeight.w800,
                                    height: 1.1,
                                    letterSpacing: -0.5,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 8),

                              // Subtítulo
                              Text(
                                "Aprende • Gana • Domina",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: baseFont * 0.85,
                                  color: Colors.blueGrey.shade700,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.1,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Emojis decorativos
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            child: Text(
                              "⚡ 🎓 💰",
                              style: TextStyle(fontSize: baseFont + 4),
                            ),
                          ),

                          SizedBox(height: isPortrait ? 32 : 24),

                          // Descripción más legible
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "Domina Bitcoin y Lightning Network mientras ganas sats reales en cada lección.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: baseFont,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w400,
                                height: 1.6,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: isPortrait ? size.height * 0.1 : 50),

                      // Botones
                      Column(
                        children: [
                          // Botón principal
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.25),
                                  blurRadius: 18,
                                  offset: const Offset(0, 6),
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

                          // Botón secundario
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.blue.shade400,
                                width: 1.8,
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

                      SizedBox(height: isPortrait ? size.height * 0.08 : 30),
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
