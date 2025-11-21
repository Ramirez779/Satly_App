import 'package:flutter/material.dart';
import '../utils/colors.dart';


class WalletHistoryPage extends StatelessWidget {
  const WalletHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fakeData = [
      {
        'title': 'Recompensa por quiz',
        'subtitle': 'Básico - Fundamentos',
        'amount': '+20 SATS',
        'isIncome': true,
      },
      {
        'title': 'Retiro a wallet externa',
        'subtitle': 'LNURL withdraw',
        'amount': '-50 SATS',
        'isIncome': false,
      },
      {
        'title': 'Recompensa por racha de 3 días',
        'subtitle': 'Bonus de constancia',
        'amount': '+15 SATS',
        'isIncome': true,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Historial de transacciones'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: fakeData.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final tx = fakeData[index];
          final isIncome = tx['isIncome'] as bool;

          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: isIncome
                      ? AppColors.success.withOpacity(0.15)
                      : AppColors.error.withOpacity(0.12),
                  child: Icon(
                    isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                    color: isIncome ? AppColors.success : AppColors.error,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tx['title'] as String,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        tx['subtitle'] as String,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  tx['amount'] as String,
                  style: TextStyle(
                    color: isIncome ? AppColors.success : AppColors.error,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
