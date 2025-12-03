import 'package:flutter/material.dart';
import '../utils/colors.dart';

class WalletHistoryPage extends StatelessWidget {
  const WalletHistoryPage({super.key});

  // Historial “dummy” solo para UI
  List<Map<String, dynamic>> get _transactions => const [
        {
          'type': 'earned',
          'title': 'Quiz: Fundamentos Esenciales',
          'amount': 20,
          'date': 'Hoy, 2:30 PM',
          'tag': 'Recompensa',
        },
        {
          'type': 'earned',
          'title': 'Quiz: Básico Vol. 2',
          'amount': 20,
          'date': 'Ayer, 5:12 PM',
          'tag': 'Recompensa',
        },
        {
          'type': 'withdraw',
          'title': 'Retiro a Wallet Externa',
          'amount': -50,
          'date': '18 Nov, 3:40 PM',
          'tag': 'Retiro',
        },
        {
          'type': 'earned',
          'title': 'Racha semanal completada',
          'amount': 30,
          'date': '17 Nov, 9:10 AM',
          'tag': 'Bonus',
        },
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Historial de transacciones'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ve cómo tus quizzes se convierten en SATS.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView.separated(
                itemCount: _transactions.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final tx = _transactions[index];
                  final bool isEarned = tx['type'] == 'earned';
                  final int amount = tx['amount'] as int;

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x11000000),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: isEarned
                                ? Colors.green.withOpacity(0.12)
                                : Colors.red.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            isEarned
                                ? Icons.bolt_rounded
                                : Icons.call_made_rounded,
                            color: isEarned
                                ? Colors.green[700]
                                : Colors.red[700],
                            size: 22,
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
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE3F2FD),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      tx['tag'] as String,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    tx['date'] as String,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${amount > 0 ? '+' : ''}$amount SATS',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: isEarned
                                ? Colors.green[700]
                                : Colors.red[700],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
