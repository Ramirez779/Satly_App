// views/dashboard_page.dart
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  // Métricas en cero (se integrarán después)
  final int totalSats = 0;
  final int quizzesCompletados = 0;
  final int rachaActual = 0;
  final int nivelActual = 1;
  final double progresoNivel = 0.0; // 25% para nivel 1
  final int totalPreguntasCorrectas = 0;
  final int totalPreguntasRespondidas = 0;

  @override
  Widget build(BuildContext context) {
    final double porcentajeExito = totalPreguntasRespondidas > 0
        ? (totalPreguntasCorrectas / totalPreguntasRespondidas * 100)
        : 0.0;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 600;
          final bool isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
          final bool isDesktop = constraints.maxWidth >= 1024;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16.0 : isTablet ? 24.0 : 32.0,
              vertical: isMobile ? 16.0 : isTablet ? 20.0 : 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header de bienvenida
                _buildWelcomeHeader(isMobile, isTablet, isDesktop),
                SizedBox(height: isMobile ? 24 : isTablet ? 20 : 24),

                // Estadísticas rápidas
                _buildQuickStats(isMobile, isTablet, isDesktop, constraints.maxWidth),
                SizedBox(height: isMobile ? 24 : isTablet ? 20 : 24),

                // Progreso del nivel y métricas
                _buildProgressAndMetrics(isMobile, isTablet, isDesktop, porcentajeExito),
                SizedBox(height: isMobile ? 24 : isTablet ? 20 : 24),

                // Quizzes recomendados - MEJORADO
                _buildQuizSection(context, isMobile, isTablet, isDesktop),
                SizedBox(height: isMobile ? 24 : isTablet ? 20 : 24),

                // Acciones rápidas
                _buildQuickActions(context, isMobile, isTablet, isDesktop),
                SizedBox(height: isMobile ? 20 : isTablet ? 16 : 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildWelcomeHeader(bool isMobile, bool isTablet, bool isDesktop) {
    final double padding = isMobile ? 24 : isTablet ? 20 : 24;
    final double iconSize = isMobile ? 24 : isTablet ? 20 : 24;
    final double titleSize = isMobile ? 22 : isTablet ? 20 : 24;
    final double subtitleSize = isMobile ? 16 : isTablet ? 14 : 16;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blueAccent, Colors.lightBlueAccent],
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
                  size: iconSize,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: isMobile ? 12 : 8),
              Expanded(
                child: Text(
                  '¡Bienvenido de vuelta!',
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 16 : 12),
          Text(
            'Nivel $nivelActual • $totalSats SATS acumulados',
            style: TextStyle(
              fontSize: subtitleSize,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: isMobile ? 16 : 12),
          // Barra de progreso mejorada
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Progreso del nivel',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 12,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  Text(
                    '${(progresoNivel * 100).toStringAsFixed(0)}%',
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
                    FractionallySizedBox(
                      widthFactor: progresoNivel,
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
                '${(100 - (progresoNivel * 100)).toStringAsFixed(0)}% para el siguiente nivel',
                style: TextStyle(
                  fontSize: isMobile ? 11 : 10,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(bool isMobile, bool isTablet, bool isDesktop, double maxWidth) {
    final int crossAxisCount = isMobile ? 2 : (isTablet ? 4 : 4);
    final double childAspectRatio = isMobile ? 1.2 : (isTablet ? 1.1 : 1.0);
    final double spacing = isMobile ? 12 : (isTablet ? 16 : 20);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tu Progreso',
          style: TextStyle(
            fontSize: isMobile ? 20 : isTablet ? 18 : 22,
            fontWeight: FontWeight.w700,
            color: Colors.white,
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
            _buildStatCard(
              'SATS Acumulados',
              totalSats.toString(),
              Icons.bolt_rounded,
              Colors.amber.shade600,
              isMobile,
              isTablet,
            ),
            _buildStatCard(
              'Quizzes Completados',
              quizzesCompletados.toString(),
              Icons.quiz_rounded,
              Colors.green.shade600,
              isMobile,
              isTablet,
            ),
            _buildStatCard(
              'Días de Racha',
              '$rachaActual días',
              Icons.local_fire_department_rounded,
              Colors.orange.shade600,
              isMobile,
              isTablet,
            ),
            _buildStatCard(
              'Nivel Actual',
              nivelActual.toString(),
              Icons.star_rounded,
              Colors.purple.shade600,
              isMobile,
              isTablet,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    bool isMobile,
    bool isTablet,
  ) {
    final double padding = isMobile ? 16 : (isTablet ? 12 : 16);
    final double iconSize = isMobile ? 24 : (isTablet ? 20 : 28);
    final double valueSize = isMobile ? 20 : (isTablet ? 18 : 24);
    final double titleSize = isMobile ? 12 : (isTablet ? 10 : 14);

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
        padding: EdgeInsets.all(padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(isMobile ? 12 : 10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: iconSize),
            ),
            SizedBox(height: isMobile ? 12 : 8),
            Text(
              value,
              style: TextStyle(
                fontSize: valueSize,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            SizedBox(height: isMobile ? 4 : 2),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: titleSize,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressAndMetrics(bool isMobile, bool isTablet, bool isDesktop, double porcentajeExito) {
    if (isMobile) {
      return Column(
        children: [
          _buildLevelProgress(isMobile, isTablet),
          SizedBox(height: 16),
          _buildLearningMetrics(isMobile, isTablet, porcentajeExito),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(child: _buildLevelProgress(isMobile, isTablet)),
          SizedBox(width: isTablet ? 16 : 20),
          Expanded(child: _buildLearningMetrics(isMobile, isTablet, porcentajeExito)),
        ],
      );
    }
  }

  Widget _buildLevelProgress(bool isMobile, bool isTablet) {
    final double padding = isMobile ? 20 : (isTablet ? 16 : 20);
    final double iconSize = isMobile ? 20 : (isTablet ? 18 : 22);
    final double textSize = isMobile ? 16 : (isTablet ? 14 : 18);

    return Container(
      padding: EdgeInsets.all(padding),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_up_rounded,
                size: iconSize,
                color: Colors.blueAccent,
              ),
              SizedBox(width: isMobile ? 8 : 6),
              Text(
                'Progreso del Nivel',
                style: TextStyle(
                  fontSize: textSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 12 : 8),
          LinearProgressIndicator(
            value: progresoNivel,
            backgroundColor: Colors.grey.shade200,
            color: Colors.blueAccent,
            minHeight: isMobile ? 8 : 6,
            borderRadius: BorderRadius.circular(4),
          ),
          SizedBox(height: isMobile ? 8 : 6),
          Row(
            children: [
              Text(
                'Nivel $nivelActual',
                style: TextStyle(
                  fontSize: isMobile ? 12 : 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                'Nivel ${nivelActual + 1}',
                style: TextStyle(
                  fontSize: isMobile ? 12 : 10,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLearningMetrics(bool isMobile, bool isTablet, double porcentajeExito) {
    final double padding = isMobile ? 20 : (isTablet ? 16 : 20);
    final double iconSize = isMobile ? 20 : (isTablet ? 18 : 22);
    final double textSize = isMobile ? 16 : (isTablet ? 14 : 18);

    return Container(
      padding: EdgeInsets.all(padding),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.analytics_rounded,
                size: iconSize,
                color: Colors.green,
              ),
              SizedBox(width: isMobile ? 8 : 6),
              Text(
                'Métricas de Aprendizaje',
                style: TextStyle(
                  fontSize: textSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 12 : 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetricItem(
                'Éxito',
                '${porcentajeExito.toStringAsFixed(0)}%',
                Icons.flag_rounded,
                isMobile,
                isTablet,
              ),
              _buildMetricItem(
                'Correctas',
                totalPreguntasCorrectas.toString(),
                Icons.check_circle_rounded,
                isMobile,
                isTablet,
              ),
              _buildMetricItem(
                'Total',
                totalPreguntasRespondidas.toString(),
                Icons.question_answer_rounded,
                isMobile,
                isTablet,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(
    String title,
    String value,
    IconData icon,
    bool isMobile,
    bool isTablet,
  ) {
    final double iconContainerSize = isMobile ? 18 : (isTablet ? 16 : 20);
    final double valueSize = isMobile ? 16 : (isTablet ? 14 : 18);
    final double titleSize = isMobile ? 10 : (isTablet ? 9 : 12);

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(isMobile ? 6 : 5),
          decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.blueAccent,
            size: iconContainerSize,
          ),
        ),
        SizedBox(height: isMobile ? 4 : 2),
        Text(
          value,
          style: TextStyle(
            fontSize: valueSize,
            fontWeight: FontWeight.w700,
            color: Colors.blueAccent,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: titleSize,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildQuizSection(BuildContext context, bool isMobile, bool isTablet, bool isDesktop) {
    final List<Map<String, dynamic>> recommendedQuizzes = [
      {
        'title': 'Bitcoin Básico',
        'subtitle': 'Conceptos fundamentales para empezar',
        'icon': Icons.currency_bitcoin_rounded,
        'color': Colors.orange,
        'reward': '10 SATS',
        'progress': 0.3,
        'difficulty': 'Fácil',
      },
      {
        'title': 'Lightning Network',
        'subtitle': 'Pagos instantáneos y de bajo costo',
        'icon': Icons.bolt_rounded,
        'color': Colors.blue,
        'reward': '15 SATS',
        'progress': 0.0,
        'difficulty': 'Intermedio',
      },
      {
        'title': 'Seguridad Avanzada',
        'subtitle': 'Protege tus fondos y privacidad',
        'icon': Icons.security_rounded,
        'color': Colors.green,
        'reward': '20 SATS',
        'progress': 0.0,
        'difficulty': 'Avanzado',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Continúa Aprendiendo',
              style: TextStyle(
                fontSize: isMobile ? 20 : isTablet ? 18 : 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            if (!isMobile)
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/quiz');
                },
                child: Text(
                  'Ver todos',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: isTablet ? 14 : 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: isMobile ? 16 : 12),
        
        if (isMobile || isTablet)
          Column(
            children: recommendedQuizzes.map((quiz) => 
              Padding(
                padding: EdgeInsets.only(bottom: isMobile ? 12 : 8),
                child: _buildQuizCard(
                  context,
                  quiz['title'] as String,
                  quiz['subtitle'] as String,
                  quiz['icon'] as IconData,
                  quiz['color'] as Color,
                  quiz['reward'] as String,
                  quiz['progress'] as double,
                  quiz['difficulty'] as String,
                  isMobile,
                  isTablet,
                ),
              )
            ).toList(),
          )
        else
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1,
            children: recommendedQuizzes.map((quiz) => 
              _buildQuizCard(
                context,
                quiz['title'] as String,
                quiz['subtitle'] as String,
                quiz['icon'] as IconData,
                quiz['color'] as Color,
                quiz['reward'] as String,
                quiz['progress'] as double,
                quiz['difficulty'] as String,
                isMobile,
                isTablet,
              )
            ).toList(),
          ),
      ],
    );
  }

  Widget _buildQuizCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    String reward,
    double progress,
    String difficulty,
    bool isMobile,
    bool isTablet,
  ) {
    final bool isDesktop = !isMobile && !isTablet;
    
    if (isDesktop) {
      return _buildDesktopQuizCard(
        context, title, subtitle, icon, color, reward, progress, difficulty, isMobile, isTablet
      );
    } else {
      return _buildMobileQuizCard(
        context, title, subtitle, icon, color, reward, progress, difficulty, isMobile, isTablet
      );
    }
  }

  Widget _buildMobileQuizCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    String reward,
    double progress,
    String difficulty,
    bool isMobile,
    bool isTablet,
  ) {
    final double padding = isMobile ? 16 : (isTablet ? 12 : 16);
    final double iconSize = isMobile ? 24 : (isTablet ? 20 : 28);
    final double titleSize = isMobile ? 16 : (isTablet ? 14 : 18);
    final double subtitleSize = isMobile ? 12 : (isTablet ? 11 : 14);

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
      child: ListTile(
        contentPadding: EdgeInsets.all(padding),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [color, color.withOpacity(0.8)]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: iconSize),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: titleSize,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subtitle,
              style: TextStyle(fontSize: subtitleSize),
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getDifficultyColor(difficulty).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    difficulty,
                    style: TextStyle(
                      fontSize: 10,
                      color: _getDifficultyColor(difficulty),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                if (progress > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${(progress * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            reward,
            style: TextStyle(
              fontSize: isMobile ? 12 : 10,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/quiz');
        },
      ),
    );
  }

  Widget _buildDesktopQuizCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    String reward,
    double progress,
    String difficulty,
    bool isMobile,
    bool isTablet,
  ) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con icono y recompensa
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [color, color.withOpacity(0.8)]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Colors.white, size: 28),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    reward,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Contenido
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 12),
                
                // Etiquetas de dificultad y progreso
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getDifficultyColor(difficulty).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        difficulty,
                        style: TextStyle(
                          fontSize: 11,
                          color: _getDifficultyColor(difficulty),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    if (progress > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${(progress * 100).toInt()}% completado',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          
          // Botón de acción
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/quiz');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: color.withOpacity(0.1),
                  foregroundColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  progress > 0 ? 'Continuar' : 'Comenzar',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'fácil':
        return Colors.green;
      case 'intermedio':
        return Colors.orange;
      case 'avanzado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildQuickActions(BuildContext context, bool isMobile, bool isTablet, bool isDesktop) {
    final double buttonHeight = isMobile ? 56 : (isTablet ? 52 : 60);
    final double spacing = isMobile ? 12 : (isTablet ? 10 : 16);

    if (isDesktop) {
      return Row(
        children: [
          Expanded(
            child: CustomButton(
              text: 'Explorar Todos los Quizzes',
              onPressed: () {
                Navigator.pushNamed(context, '/quiz');
              },
              isPrimary: true,
              height: buttonHeight,
            ),
          ),
          SizedBox(width: spacing),
          Expanded(
            child: CustomButton(
              text: 'Ver Mi Perfil',
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              isPrimary: false,
              height: buttonHeight,
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomButton(
            text: 'Explorar Todos los Quizzes',
            onPressed: () {
              Navigator.pushNamed(context, '/quiz');
            },
            isPrimary: true,
            height: buttonHeight,
          ),
          SizedBox(height: spacing),
          CustomButton(
            text: 'Ver Mi Perfil',
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            isPrimary: false,
            height: buttonHeight,
          ),
        ],
      );
    }
  }
}