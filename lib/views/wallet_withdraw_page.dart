import 'package:flutter/material.dart';
import '../utils/colors.dart';

class WalletWithdrawPage extends StatefulWidget {
  const WalletWithdrawPage({super.key});

  @override
  State<WalletWithdrawPage> createState() => _WalletWithdrawPageState();
}

class _WalletWithdrawPageState extends State<WalletWithdrawPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _invoiceController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _invoiceController.dispose();
    super.dispose();
  }

  void _simulateWithdraw() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Retiro simulado. Aquí iría el llamado a LNBits.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Retirar SATS'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Ingresa el monto a retirar y la invoice o LNURL de tu wallet externa.',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Monto (en SATS)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Ingresa un monto.';
                  final n = int.tryParse(value);
                  if (n == null || n <= 0) {
                    return 'Ingresa un monto válido.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _invoiceController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Invoice / LNURL',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa una invoice o LNURL.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _simulateWithdraw,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Confirmar retiro (demo)',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
