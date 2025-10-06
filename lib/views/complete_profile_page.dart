import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class CompleteProfilePage extends StatefulWidget {
  final String lnurl;
  final String authMethod;

  const CompleteProfilePage({
    super.key,
    required this.lnurl,
    required this.authMethod,
  });

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final _nameCtl = TextEditingController();
  final _emailCtl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _completeProfile() async {
    if (!_formKey.currentState!.validate()) return;
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('¡Perfil completado exitosamente!'),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );

      Navigator.pushReplacementNamed(context, '/home');
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    } finally {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameCtl.dispose();
    _emailCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            final isPortrait = orientation == Orientation.portrait;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isPortrait ? 24.0 : 40.0,
                vertical: isPortrait ? 20.0 : 30.0,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.vertical,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: isPortrait ? 40 : 20),
                    _buildHeader(isPortrait),
                    _buildForm(isPortrait),
                    _buildActions(isPortrait),
                    SizedBox(height: isPortrait ? 40 : 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(bool isPortrait) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          width: isPortrait ? 120 : 100,
          height: isPortrait ? 120 : 100,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFA726), Color(0xFFFF9800)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(0.4),
                blurRadius: 30,
                spreadRadius: 5,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Stack(
            children: [
              Center(
                child: Icon(
                  Icons.person_add_alt_1_rounded,
                  size: isPortrait ? 55 : 45,
                  color: Colors.white,
                ),
              ),
              Positioned(
                top: 15,
                left: 15,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: isPortrait ? 28 : 20),

        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFFFFA726), Color(0xFFFF9800)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.3, 0.7],
          ).createShader(bounds),
          child: Text(
            'Completa tu Perfil',
            style: TextStyle(
              fontSize: isPortrait ? 40 : 32,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.2,
              height: 1.1,
            ),
          ),
        ),
        SizedBox(height: 8),

        Text(
          'Termina de configurar tu cuenta',
          style: TextStyle(
            fontSize: isPortrait ? 17 : 15,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.2,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade50, Colors.orange.shade100],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange.shade200, width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.flash_on_rounded,
                color: Colors.orange.shade800,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'Autenticado con Lightning ✓',
                style: TextStyle(
                  color: Colors.orange.shade800,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildForm(bool isPortrait) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: isPortrait ? 50 : 40),
          _buildTextField(
            controller: _nameCtl,
            label: 'Nombre completo',
            icon: Icons.person_outline_rounded,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            isPortrait: isPortrait,
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return 'Por favor ingresa tu nombre';
              }
              if (v.trim().length < 2) return 'Mínimo 2 caracteres';
              return null;
            },
          ),
          SizedBox(height: isPortrait ? 20 : 16),
          _buildTextField(
            controller: _emailCtl,
            label: 'Correo electrónico (opcional)',
            icon: Icons.email_rounded,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            isPortrait: isPortrait,
            validator: (v) {
              if (v != null && v.trim().isNotEmpty) {
                final emailRegex = RegExp(
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                );
                if (!emailRegex.hasMatch(v.trim())) return 'Email inválido';
              }
              return null;
            },
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildActions(bool isPortrait) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(0.4),
                blurRadius: 25,
                spreadRadius: 2,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: CustomButton(
            text: 'Completar Registro',
            onPressed: _isLoading ? null : _completeProfile,
            isLoading: _isLoading,
            isPrimary: true,
            height: isPortrait ? 60 : 56,
          ),
        ),

        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isPortrait,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      style: TextStyle(
        fontSize: isPortrait ? 16 : 14,
        color: Colors.grey.shade800,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Container(
          margin: const EdgeInsets.all(12),
          child: Icon(icon, color: Colors.orange.shade600, size: 22),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.orange.shade600, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: isPortrait ? 20 : 18,
        ),
      ),
      validator: validator,
    );
  }
}