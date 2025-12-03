// views/dashboard_page.dart
import 'package:flutter/material.dart';

// Modelos de datos dentro del mismo archivo
class UserData {
  final String userName;
  final int userLevel;
  final int totalSats;
  final int quizzesCompletados;
  final int rachaActual;
  final double progresoNivel;
  final int totalPreguntasCorrectas;
  final int totalPreguntasRespondidas;

  const UserData({
    required this.userName,
    required this.userLevel,
    required this.totalSats,
    required this.quizzesCompletados,
    required this.rachaActual,
    required this.progresoNivel,
    required this.totalPreguntasCorrectas,
    required this.totalPreguntasRespondidas,
  });

  double get porcentajeExito => totalPreguntasRespondidas > 0
      ? (totalPreguntasCorrectas / totalPreguntasRespondidas * 100)
      : 0.0;
}

// Widgets principales refactorizados
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  // Datos de ejemplo
  final UserData userData = const UserData(
    userName: "Usuario",
    userLevel: 1,
    totalSats: 0,
    quizzesCompletados: 0,
    rachaActual: 0,
    progresoNivel: 0.0,
    totalPreguntasCorrectas: 0,
    totalPreguntasRespondidas: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 600;
          final bool isTablet =
              constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
          final bool isDesktop = constraints.maxWidth >= 1024;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile
                  ? 16.0
                  : isTablet
                  ? 24.0
                  : 32.0,
              vertical: isMobile
                  ? 16.0
                  : isTablet
                  ? 20.0
                  : 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header principal
                _MainHeader(
                  userData: userData,
                  isMobile: isMobile,
                  isTablet: isTablet,
                  isDesktop: isDesktop,
                ),
                SizedBox(
                  height: isMobile
                      ? 24
                      : isTablet
                      ? 20
                      : 24,
                ),

                SizedBox(
                  height: isMobile
                      ? 24
                      : isTablet
                      ? 20
                      : 24,
                ),

                // Métricas clave
                _KeyMetrics(
                  userData: userData,
                  isMobile: isMobile,
                  isTablet: isTablet,
                  isDesktop: isDesktop,
                ),

                // Espacio final
                SizedBox(
                  height: isMobile
                      ? 20
                      : isTablet
                      ? 16
                      : 20,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Header principal
class _MainHeader extends StatelessWidget {
  final UserData userData;
  final bool isMobile;
  final bool isTablet;
  final bool isDesktop;

  const _MainHeader({
    required this.userData,
    required this.isMobile,
    required this.isTablet,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile
            ? 24
            : isTablet
            ? 20
            : 24,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0066FF), Color(0xFF00BFFF)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fila de bienvenida
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.celebration_rounded,
                  size: isMobile
                      ? 24
                      : isTablet
                      ? 20
                      : 24,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: isMobile ? 12 : 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '¡Hola, ${userData.userName}!',
                      style: TextStyle(
                        fontSize: isMobile
                            ? 22
                            : isTablet
                            ? 20
                            : 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Sigue aprendiendo y gana más SATS',
                      style: TextStyle(
                        fontSize: isMobile
                            ? 16
                            : isTablet
                            ? 14
                            : 16,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 16 : 12),

          // Barra de progreso
          _ProgressStats(
            userData: userData,
            isMobile: isMobile,
            isTablet: isTablet,
          ),
        ],
      ),
    );
  }
}

// Estadísticas de progreso
class _ProgressStats extends StatelessWidget {
  final UserData userData;
  final bool isMobile;
  final bool isTablet;

  const _ProgressStats({
    required this.userData,
    required this.isMobile,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Nivel ${userData.userLevel} • ${userData.totalSats} SATS',
              style: TextStyle(
                fontSize: isMobile ? 14 : 12,
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${(userData.progresoNivel * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                fontSize: isMobile ? 14 : 12,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: isMobile ? 8 : 6),
        Container(
          height: isMobile ? 10 : 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white.withOpacity(0.3),
          ),
          child: Stack(
            children: [
              AnimatedFractionallySizedBox(
                duration: const Duration(milliseconds: 800),
                widthFactor: userData.progresoNivel,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: const LinearGradient(
                      colors: [Colors.white, Colors.white70],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: isMobile ? 4 : 2),
        Text(
          '${(100 - (userData.progresoNivel * 100)).toStringAsFixed(0)}% para el siguiente nivel',
          style: TextStyle(
            fontSize: isMobile ? 11 : 10,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}

// Métricas clave en grid
class _KeyMetrics extends StatelessWidget {
  final UserData userData;
  final bool isMobile;
  final bool isTablet;
  final bool isDesktop;

  const _KeyMetrics({
    required this.userData,
    required this.isMobile,
    required this.isTablet,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    final int crossAxisCount = isMobile ? 2 : 4;
    final double childAspectRatio = isMobile ? 1.2 : (isTablet ? 1.1 : 1.0);
    final double spacing = isMobile ? 12 : (isTablet ? 16 : 20);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tu Progreso',
          style: TextStyle(
            fontSize: isMobile
                ? 20
                : isTablet
                ? 18
                : 22,
            fontWeight: FontWeight.w700,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: isMobile ? 16 : 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          childAspectRatio: childAspectRatio,
          children: [
            _MetricCard(
              title: 'SATS Acumulados',
              value: userData.totalSats.toString(),
              icon: Icons.bolt_rounded,
              color: Colors.amber.shade600,
              isMobile: isMobile,
              isTablet: isTablet,
            ),
            _MetricCard(
              title: 'Quizzes Completados',
              value: userData.quizzesCompletados.toString(),
              icon: Icons.quiz_rounded,
              color: Colors.green.shade600,
              isMobile: isMobile,
              isTablet: isTablet,
            ),
            _MetricCard(
              title: 'Días de Racha',
              value: '${userData.rachaActual} días',
              icon: Icons.local_fire_department_rounded,
              color: Colors.orange.shade600,
              isMobile: isMobile,
              isTablet: isTablet,
            ),
            _MetricCard(
              title: 'Tasa de Éxito',
              value: '${userData.porcentajeExito.toStringAsFixed(0)}%',
              icon: Icons.flag_rounded,
              color: Colors.purple.shade600,
              isMobile: isMobile,
              isTablet: isTablet,
            ),
          ],
        ),
      ],
    );
  }
}

// Tarjeta de métrica individual
class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final bool isMobile;
  final bool isTablet;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.isMobile,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : (isTablet ? 12 : 16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(isMobile ? 12 : 10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: isMobile ? 24 : (isTablet ? 20 : 28),
              ),
            ),
            SizedBox(height: isMobile ? 12 : 8),
            Text(
              value,
              style: TextStyle(
                fontSize: isMobile ? 20 : (isTablet ? 18 : 24),
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            SizedBox(height: isMobile ? 4 : 2),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 12 : (isTablet ? 10 : 14),
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
