import 'package:flutter/material.dart';
import 'login_page.dart';
import '../widgets/custom_button.dart';
import '../utils/colors.dart';
import '../utils/typography.dart';
import '../utils/spacing.dart';

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
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
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
      backgroundColor: AppColors.background,
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
                    AppColors.background,
                    AppColors.card.withOpacity(0.8),
                  ],
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isPortrait ? AppSpacing.lg : AppSpacing.xl * 2,
                  vertical: isPortrait ? AppSpacing.lg : AppSpacing.xl,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight:
                        size.height - MediaQuery.of(context).padding.vertical,
                  ),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: isPortrait ? 20 : 40),
                        _buildLogoSection(isPortrait),
                        SizedBox(height: isPortrait ? 20 : 40),
                        _buildFeaturesSection(isPortrait),
                        SizedBox(height: isPortrait ? 20 : 40),
                        _buildCallToActionSection(isPortrait),
                        SizedBox(height: isPortrait ? 20 : 40),
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
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
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
              Text("⚡🎓", 
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ],
          ),
        ),
        SizedBox(height: isPortrait ? 24 : 32),
        ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [AppColors.primary, AppColors.secondary],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ).createShader(bounds);
          },
          child: Text(
            "SparkSeed",
            style: AppTextStyles.displayLarge.copyWith(
              fontSize: isPortrait ? 48 : 42,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: isPortrait ? 8 : 12),
        Text(
          "Aprende Bitcoin, gana SATS",
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFeaturesSection(bool isPortrait) {
    return Container(
      padding: EdgeInsets.all(isPortrait ? AppSpacing.lg : AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildFeatureItem(
            Icons.school_rounded,
            "Aprendizaje Gamificado",
            "Quizzes interactivos y progresivos",
            isPortrait,
          ),
          SizedBox(height: isPortrait ? AppSpacing.md : AppSpacing.sm),
          _buildFeatureItem(
            Icons.bolt_rounded,
            "Recompensas Reales",
            "Gana SATS por cada logro",
            isPortrait,
          ),
          SizedBox(height: isPortrait ? AppSpacing.md : AppSpacing.sm),
          _buildFeatureItem(
            Icons.trending_up_rounded,
            "Progreso Continuo",
            "Mejora tus habilidades Bitcoin",
            isPortrait,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(
    IconData icon,
    String title,
    String subtitle,
    bool isPortrait,
  ) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(isPortrait ? AppSpacing.md : AppSpacing.sm),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.secondary],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon, 
            size: isPortrait ? 24 : 20, 
            color: Colors.white
          ),
        ),
        SizedBox(width: isPortrait ? AppSpacing.md : AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.titleSmall.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: AppSpacing.xs),
              Text(
                subtitle,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
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
          height: isPortrait ? 56 : 52,
        ),
        SizedBox(height: AppSpacing.md),
        Container(
          padding: EdgeInsets.all(isPortrait ? AppSpacing.md : AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.celebration_rounded,
                size: isPortrait ? 20 : 18,
                color: AppColors.primary,
              ),
              SizedBox(width: isPortrait ? AppSpacing.sm : 6),
              Flexible(
                child: Text(
                  "¡Únete a la revolución Bitcoin hoy mismo!",
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.md),
      ],
    );
  }
}