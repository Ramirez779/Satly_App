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
  final double progresoNivel = 0.0;
  final int totalPreguntasCorrectas = 0;
  final int totalPreguntasRespondidas = 0;

  @override
  Widget build(BuildContext context) {
    final double porcentajeExito = totalPreguntasRespondidas > 0 
        ? (totalPreguntasCorrectas / totalPreguntasRespondidas * 100) 
        : 0.0;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header de bienvenida
            _buildWelcomeHeader(),
            const SizedBox(height: 24),
            
            // Estadísticas rápidas
            _buildQuickStats(),
            const SizedBox(height: 24),
            
            // Progreso del nivel
            _buildLevelProgress(),
            const SizedBox(height: 24),
            
            // Métricas de aprendizaje
            _buildLearningMetrics(porcentajeExito),
            const SizedBox(height: 24),
            
            // Quizzes recientes/recomendados
            _buildQuizSection(context),
            const SizedBox(height: 24),
            
            // Acciones rápidas
            _buildQuickActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Card(
      elevation: 2,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueAccent.shade400, Colors.blueAccent.shade700],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '¡Bienvenido de vuelta!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Nivel $nivelActual • $totalSats SATS',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progresoNivel,
              backgroundColor: Colors.white.withOpacity(0.3),
              color: Colors.white,
              minHeight: 6,
            ),
            const SizedBox(height: 8),
            Text(
              '${(progresoNivel * 100).toStringAsFixed(0)}% hacia el siguiente nivel',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tu Progreso',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.3,
          children: [
            _buildStatCard(
              'SATS Acumulados',
              totalSats.toString(),
              Icons.monetization_on,
              Colors.amber.shade600,
            ),
            _buildStatCard(
              'Quizzes Completados',
              quizzesCompletados.toString(),
              Icons.quiz,
              Colors.green.shade600,
            ),
            _buildStatCard(
              'Días de Racha',
              rachaActual.toString(),
              Icons.local_fire_department,
              Colors.orange.shade600,
            ),
            _buildStatCard(
              'Nivel Actual',
              nivelActual.toString(),
              Icons.star,
              Colors.purple.shade600,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelProgress() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Progreso del Nivel',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Nivel $nivelActual',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Text(
                  'Nivel ${nivelActual + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progresoNivel,
              backgroundColor: Colors.grey.shade300,
              color: Colors.blueAccent,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 8),
            Text(
              'Necesitas ${(100 - (progresoNivel * 100)).toStringAsFixed(0)}% más para subir de nivel',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLearningMetrics(double porcentajeExito) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Métricas de Aprendizaje',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMetricItem(
                  'Preguntas Respondidas',
                  totalPreguntasRespondidas.toString(),
                  Icons.question_answer,
                ),
                _buildMetricItem(
                  'Tasa de Éxito',
                  '${porcentajeExito.toStringAsFixed(0)}%',
                  Icons.flag,
                ),
                _buildMetricItem(
                  'Preguntas Correctas',
                  totalPreguntasCorrectas.toString(),
                  Icons.check_circle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildQuizSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Continúa Aprendiendo',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildQuizCard(
          context,
          'Bitcoin Básico',
          'Conceptos fundamentales',
          Icons.currency_bitcoin,
          Colors.orange,
          '10 SATS',
        ),
        const SizedBox(height: 12),
        _buildQuizCard(
          context,
          'Lightning Network',
          'Pagos instantáneos',
          Icons.bolt,
          Colors.blue,
          '15 SATS',
        ),
        const SizedBox(height: 12),
        _buildQuizCard(
          context,
          'Seguridad',
          'Protege tus fondos',
          Icons.security,
          Colors.green,
          '20 SATS',
        ),
      ],
    );
  }

  Widget _buildQuizCard(BuildContext context, String title, String subtitle, IconData icon, Color color, String reward) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: Chip(
          label: Text(reward, style: const TextStyle(fontSize: 12)),
          backgroundColor: color.withOpacity(0.1),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/quiz');
        },
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomButton(
          text: 'Explorar Todos los Quizzes',
          onPressed: () {
            Navigator.pushNamed(context, '/quiz');
          },
          backgroundColor: Colors.blueAccent,
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () {
            // Navegar a página de perfil
            Navigator.pushNamed(context, '/profile');
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text('Ver Perfil Completo'),
        ),
      ],
    );
  }
}