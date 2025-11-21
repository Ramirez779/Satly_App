import 'package:flutter/material.dart';
import '../utils/colors.dart';


class WalletReceivePage extends StatelessWidget {
  const WalletReceivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Recibir SATS'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Muestra este código a tu wallet Lightning\npara recibir sats.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),

            // Placeholder de QR
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Center(
                child: Icon(
                  Icons.qr_code_2,
                  size: 120,
                  color: AppColors.accent,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // LNURL / dirección dummy
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                'lnurl1xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 12),

            ElevatedButton.icon(
              onPressed: () {
                // TODO: copiar al portapapeles
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Dirección copiada (demo).'),
                  ),
                );
              },
              icon: const Icon(Icons.copy),
              label: const Text('Copiar dirección'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
