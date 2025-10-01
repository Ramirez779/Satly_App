// lib/views/landing_page.dart
import 'package:flutter/material.dart';
import 'login_page.dart';
import '../widgets/custom_button.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            final isPortrait = orientation == Orientation.portrait;
            final size = MediaQuery.of(context).size;

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
                    Colors.blue.shade100.withAlpha(80),
                  ],
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isPortrait ? 24 : 60,
                  vertical: isPortrait ? 20 : 40,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: size.height -
                          MediaQuery.of(context).padding.vertical),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: 20),
                        _buildLogoSection(isPortrait),
                        const SizedBox(height: 20),
                        _buildFeaturesSection(isPortrait),
                        const SizedBox(height: 20),
                        _buildCallToActionSection(isPortrait),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLogoSection(bool isPortrait) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          width: isPortrait ? 140 : 120,
          height: isPortrait ? 140 : 120,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withAlpha(102),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bolt_rounded, size: 50, color: Colors.white),
              SizedBox(height: 8),
              Text("⚡🎓", style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ShaderMask(
          shaderCallback: (bounds) {
            return const LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlueAccent],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ).createShader(bounds);
          },
          child: Text(
            "SparkSeed",
            style: TextStyle(
              fontSize: isPortrait ? 48 : 42,
              fontWeight: FontWeight.w900,
              height: 1.1,
              letterSpacing: -1.0,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesSection(bool isPortrait) {
    return Container(
      padding: EdgeInsets.all(isPortrait ? 20 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildFeatureItem(Icons.school_rounded, "Aprendizaje Gamificado",
              "Quizzes interactivos y progresivos", isPortrait),
          SizedBox(height: isPortrait ? 16 : 12),
          _buildFeatureItem(Icons.bolt_rounded, "Recompensas Reales",
              "Gana SATS por cada logro", isPortrait),
          SizedBox(height: isPortrait ? 16 : 12),
          _buildFeatureItem(Icons.trending_up_rounded, "Progreso Continuo",
              "Mejora tus habilidades Bitcoin", isPortrait),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(
      IconData icon, String title, String subtitle, bool isPortrait) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(isPortrait ? 12 : 10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlueAccent],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: isPortrait ? 24 : 20, color: Colors.white),
        ),
        SizedBox(width: isPortrait ? 16 : 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: isPortrait ? 16 : 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87)),
              SizedBox(height: isPortrait ? 4 : 2),
              Text(subtitle,
                  style: TextStyle(
                      fontSize: isPortrait ? 14 : 12,
                      color: Colors.grey.shade600)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCallToActionSection(bool isPortrait) {
    return Column(
      children: [
        CustomButton(
          text: 'Comenzar Ahora →',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
          isPrimary: true,
          height: isPortrait ? 60 : 56,
        ),
        const SizedBox(height: 16),
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          padding: EdgeInsets.all(isPortrait ? 16 : 12),
          decoration: BoxDecoration(
            color: Colors.blueAccent.withAlpha(25),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.blueAccent.withAlpha(51)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.celebration_rounded,
                  size: isPortrait ? 20 : 18, color: Colors.blueAccent),
              SizedBox(width: isPortrait ? 8 : 6),
              Flexible(
                child: Text(
                  "¡Únete a la revolución Bitcoin hoy mismo!",
                  style: TextStyle(
                      fontSize: isPortrait ? 14 : 12,
                      color: Colors.blue[800],
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
