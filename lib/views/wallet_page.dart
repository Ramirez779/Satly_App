// wallet_page.dart - VERSIÓN COMPLETA MEJORADA
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../utils/colors.dart';
import '../utils/typography.dart';
import '../utils/spacing.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  int _walletBalance = 120; // saldo "de ejemplo", en sats
  int _lifetimeEarned = 340; // sats ganados históricamente

  // 👇 Historial simple de balance para la gráfica (últimos 7 días)
  final List<double> _balanceHistory = [40, 60, 80, 100, 90, 110, 120];
  final List<String> _balanceLabels = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];

  // Historial "dummy" para UI
  final List<Map<String, dynamic>> _transactions = [
    {
      'type': 'earned',
      'title': 'Quiz: Fundamentos Esenciales',
      'amount': 20,
      'date': 'Hoy, 2:30 PM',
      'icon': Icons.bolt_rounded,
    },
    {
      'type': 'earned',
      'title': 'Quiz: Básico Vol. 2',
      'amount': 20,
      'date': 'Ayer, 5:12 PM',
      'icon': Icons.quiz_rounded,
    },
    {
      'type': 'withdraw',
      'title': 'Retiro a Wallet Externa',
      'amount': -50,
      'date': '18 Nov, 3:40 PM',
      'icon': Icons.call_made_rounded,
    },
    {
      'type': 'earned',
      'title': 'Quiz: Lightning Network',
      'amount': 30,
      'date': '17 Nov, 10:15 AM',
      'icon': Icons.bolt_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Mi Wallet',
          style: AppTextStyles.titleLarge,
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(24),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // CARD DE BALANCE PRINCIPAL
            _buildBalanceCard(),
            SizedBox(height: AppSpacing.xl),

            // BOTONES DE ACCIÓN
            _buildActionButtons(),
            SizedBox(height: AppSpacing.xl),

            // GRÁFICA DE EVOLUCIÓN
            _buildBalanceChartCard(),
            SizedBox(height: AppSpacing.xl),

            // HISTORIAL RECIENTE
            _buildRecentHistory(),
            SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      padding: EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Balance Lightning disponible',
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          SizedBox(height: AppSpacing.sm),

          // Número animado del balance
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
            tween: Tween<double>(
              begin: 0,
              end: _walletBalance.toDouble(),
            ),
            builder: (context, value, child) {
              return Text(
                '${value.toInt()} SATS',
                style: AppTextStyles.displayLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              );
            },
          ),

          SizedBox(height: AppSpacing.md),

          // Divisor
          Divider(
            color: Colors.white.withOpacity(0.2),
            height: 1,
          ),

          SizedBox(height: AppSpacing.md),

          // Información adicional
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  color: Colors.yellow.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.bolt_rounded,
                  color: Colors.yellow[300],
                  size: 16,
                ),
              ),
              SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'Has ganado un total de $_lifetimeEarned SATS en quizzes',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            icon: Icons.call_received_rounded,
            label: 'Recibir',
            subtitle: 'Generar invoice',
            color: AppColors.success,
            onTap: () {
              Navigator.pushNamed(context, '/wallet/receive');
            },
          ),
        ),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: _ActionButton(
            icon: Icons.call_made_rounded,
            label: 'Enviar',
            subtitle: 'Pagar invoice',
            color: AppColors.error,
            onTap: () {
              Navigator.pushNamed(context, '/wallet/withdraw');
            },
          ),
        ),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: _ActionButton(
            icon: Icons.history_rounded,
            label: 'Historial',
            subtitle: 'Movimientos',
            color: AppColors.accent,
            onTap: () {
              Navigator.pushNamed(context, '/wallet/history');
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceChartCard() {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
              Icon(
                Icons.trending_up_rounded,
                color: AppColors.primary,
                size: 20,
              ),
              SizedBox(width: AppSpacing.sm),
              Text(
                'Evolución de tu saldo',
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            'Últimos 7 días',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: AppSpacing.lg),

          // GRÁFICO
          SizedBox(
            height: 150,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: (_balanceHistory.length - 1).toDouble(),
                minY: 0,
                maxY: _balanceHistory.reduce((a, b) => a > b ? a : b) + 20,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: AppColors.card,
                    width: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            '${value.toInt()}',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 24,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= _balanceLabels.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            _balanceLabels[index],
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    color: AppColors.primary,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withOpacity(0.3),
                          AppColors.primary.withOpacity(0.1),
                        ],
                        stops: const [0.5, 1.0],
                      ),
                    ),
                    spots: List.generate(
                      _balanceHistory.length,
                      (i) => FlSpot(
                        i.toDouble(),
                        _balanceHistory[i],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Historial reciente',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/wallet/history');
              },
              child: Text(
                'Ver todo',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.xs),
        Text(
          'Ve cómo tus quizzes se convierten en SATS',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: AppSpacing.md),

        // LISTA DE TRANSACCIONES
        ..._transactions.map((tx) {
          final bool isEarned = tx['type'] == 'earned';
          final int amount = tx['amount'] as int;
          final IconData icon = tx['icon'] as IconData;

          return Container(
            margin: EdgeInsets.only(bottom: AppSpacing.sm),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              elevation: 2,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      // Icono
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isEarned
                              ? AppColors.success.withOpacity(0.1)
                              : AppColors.error.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          icon,
                          color: isEarned ? AppColors.success : AppColors.error,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: AppSpacing.md),

                      // Información
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tx['title'] as String,
                              style: AppTextStyles.bodyLarge.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: AppSpacing.xs),
                            Text(
                              tx['date'] as String,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: AppSpacing.sm),

                      // Monto
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${amount > 0 ? '+' : ''}$amount SATS',
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.w700,
                              color: isEarned ? AppColors.success : AppColors.error,
                            ),
                          ),
                          SizedBox(height: AppSpacing.xs),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: isEarned
                                  ? AppColors.success.withOpacity(0.1)
                                  : AppColors.error.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              isEarned ? 'Ganado' : 'Retirado',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: isEarned ? AppColors.success : AppColors.error,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                label,
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: AppSpacing.xs),
              Text(
                subtitle,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}