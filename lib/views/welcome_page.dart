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
            double baseFont = isDesktop ? 22 : (isTablet ? 18 : 16);
            double titleFont = isDesktop ? 56 : (isTablet ? 44 : 36);
            double logoSize = isDesktop ? 160 : (isTablet ? 130 : 100);

            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.blue.shade50],
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
                      SizedBox(height: isPortrait ? 40 : 20),

                      // Contenido principal
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Logo animado
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            width: logoSize,
                            height: logoSize,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.blueAccent,
                                  Colors.lightBlueAccent,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.bolt_rounded,
                              size: logoSize * 0.5,
                              color: Colors.white,
                            ),
                          ),

                          SizedBox(height: isPortrait ? 32 : 24),

                          // Título con gradiente
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [
                                Colors.blueAccent,
                                Colors.lightBlueAccent,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds),
                            child: Text(
                              "SparkSeed",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: titleFont,
                                fontWeight: FontWeight.w900,
                                height: 1.1,
                                letterSpacing: -0.5,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Emoji decorativo
                          Text("⚡🎓", style: TextStyle(fontSize: baseFont + 6)),

                          SizedBox(height: isPortrait ? 24 : 16),

                          // Descripción
                          Text(
                            "Domina Bitcoin y Lightning Network mientras ganas sats reales en cada lección.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: baseFont,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: isPortrait ? 60 : 40),

                      // Botones
                      Column(
                        children: [
                          CustomButton(
                            text: 'Iniciar Sesión',
                            onPressed: () =>
                                Navigator.pushNamed(context, '/login'),
                            isPrimary: true,
                            height: isPortrait ? 56 : 52,
                          ),
                          const SizedBox(height: 16),
                          CustomButton(
                            text: 'Crear Cuenta',
                            onPressed: () =>
                                Navigator.pushNamed(context, '/register'),
                            isPrimary: false,
                            height: isPortrait ? 56 : 52,
                          ),
                        ],
                      ),

                      SizedBox(height: isPortrait ? 40 : 20),
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
