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

  void _sendSats() {
    if (!_formKey.currentState!.validate()) return;

    // Aquí luego va la llamada real a LNBits / backend
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Simulación: se enviarían los SATS a esa invoice.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Enviar SATS'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Paga una invoice Lightning',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Pega una invoice LN o LNURL válida para enviar sats desde tu wallet.',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Monto (en SATS)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Ej: 100',
                  prefixIcon: const Icon(Icons.bolt_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa un monto';
                  }
                  final n = int.tryParse(value);
                  if (n == null || n <= 0) {
                    return 'Monto inválido';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              const Text(
                'Invoice / LNURL de destino',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _invoiceController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Pega aquí la invoice Lightning o LNURL',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'La invoice no puede estar vacía';
                  }
                  if (value.trim().length < 10) {
                    return 'Parece muy corta para ser una invoice válida';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _sendSats,
                  icon: const Icon(Icons.call_made_rounded),
                  label: const Text('Enviar SATS'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Tip: en producción, aquí deberías validar contra el backend\n'
                'y mostrar el estado del pago (pendiente, enviado, fallido, etc.).',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
