import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameCtl = TextEditingController();
  final _emailCtl = TextEditingController();
  final _passCtl = TextEditingController();
  final _confirmPassCtl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _submitRegister() async {
    if (!_formKey.currentState!.validate()) return;
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('¡Registro exitoso! Bienvenido/a'),
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
          content: Text('Error en el registro: $error'),
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

  void _togglePasswordVisibility() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor confirma tu contraseña';
    }
    if (value != _passCtl.text) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  @override
  void dispose() {
    _nameCtl.dispose();
    _emailCtl.dispose();
    _passCtl.dispose();
    _confirmPassCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            final isPortrait = orientation == Orientation.portrait;

            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.blue.shade50],
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isPortrait ? 24.0 : 40.0,
                  vertical: isPortrait ? 20.0 : 30.0,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.vertical,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: isPortrait ? 20 : 10),
                      _buildHeader(isPortrait),
                      _buildForm(isPortrait),
                      _buildActions(isPortrait),
                      SizedBox(height: isPortrait ? 20 : 10),
                    ],
                  ),
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
          duration: const Duration(milliseconds: 500),
          width: isPortrait ? 100 : 80,
          height: isPortrait ? 100 : 80,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.person_add_alt_1_rounded,
            size: 50,
            color: Colors.white,
          ),
        ),
        SizedBox(height: isPortrait ? 20 : 12),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(bounds),
          child: Text(
            'Crear Cuenta',
            style: TextStyle(
              fontSize: isPortrait ? 36 : 28,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Únete a la comunidad Bitcoin',
          style: TextStyle(
            fontSize: isPortrait ? 16 : 14,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildForm(bool isPortrait) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField(
            controller: _nameCtl,
            label: 'Nombre completo',
            icon: Icons.person_outline_rounded,
            keyboardType: TextInputType.text,
            isPortrait: isPortrait,
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return 'Por favor ingresa tu nombre';
              }
              if (v.trim().length < 2) return 'Mínimo 2 caracteres';
              return null;
            },
          ),
          SizedBox(height: isPortrait ? 16 : 12),
          _buildTextField(
            controller: _emailCtl,
            label: 'Correo electrónico',
            icon: Icons.email_rounded,
            keyboardType: TextInputType.emailAddress,
            isPortrait: isPortrait,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Ingresa tu email';
              final emailRegex = RegExp(
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
              if (!emailRegex.hasMatch(v.trim())) return 'Email inválido';
              return null;
            },
          ),
          SizedBox(height: isPortrait ? 16 : 12),
          _buildPasswordField(
            controller: _passCtl,
            label: 'Contraseña',
            obscureText: _obscurePassword,
            onToggle: _togglePasswordVisibility,
            isPortrait: isPortrait,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Ingresa tu contraseña';
              if (v.trim().length < 6) return 'Mínimo 6 caracteres';
              return null;
            },
          ),
          SizedBox(height: isPortrait ? 16 : 12),
          _buildPasswordField(
            controller: _confirmPassCtl,
            label: 'Confirmar contraseña',
            obscureText: _obscureConfirmPassword,
            onToggle: _toggleConfirmPasswordVisibility,
            isPortrait: isPortrait,
            validator: _validateConfirmPassword,
          ),
        ],
      ),
    );
  }

  Widget _buildActions(bool isPortrait) {
    return Column(
      children: [
        CustomButton(
          text: 'Crear Cuenta',
          onPressed: _isLoading ? null : _submitRegister,
          isLoading: _isLoading,
          isPrimary: true,
          height: isPortrait ? 56 : 52,
        ),
        SizedBox(height: isPortrait ? 20 : 16),
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade300)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isPortrait ? 16 : 12),
              child: Text(
                '¿Ya tienes cuenta?',
                style: TextStyle(
                  fontSize: isPortrait ? 14 : 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey.shade300)),
          ],
        ),
        SizedBox(height: isPortrait ? 20 : 16),
        CustomButton(
          text: 'Iniciar Sesión',
          onPressed: _isLoading
              ? null
              : () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
          isPrimary: false,
          height: isPortrait ? 56 : 52,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isPortrait,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: isPortrait ? 16 : 14),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: validator,
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback onToggle,
    required bool isPortrait,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(fontSize: isPortrait ? 16 : 14),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock_rounded, color: Colors.blueAccent),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off_rounded : Icons.visibility_rounded,
            color: Colors.grey.shade600,
          ),
          onPressed: onToggle,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: validator,
    );
  }
}
