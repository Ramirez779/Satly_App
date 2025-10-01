// views/login_page.dart
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCtl = TextEditingController();
  final _passCtl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;

  void _submitLogin() async {
    if (!_formKey.currentState!.validate()) return;
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Inicio de sesión exitoso'),
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

  void _togglePasswordVisibility() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  @override
  void dispose() {
    _emailCtl.dispose();
    _passCtl.dispose();
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
            Icons.lock_rounded,
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
            'Bienvenido',
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
          'Inicia sesión en tu cuenta SparkSeed',
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
            controller: _emailCtl,
            label: 'Correo electrónico',
            icon: Icons.email_rounded,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
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
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      Navigator.pushNamed(context, '/forgot-password');
                    },
              child: Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(
                  fontSize: isPortrait ? 14 : 12,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(bool isPortrait) {
    return Column(
      children: [
        CustomButton(
          text: 'Iniciar Sesión',
          onPressed: _isLoading ? null : _submitLogin,
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
                'O',
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
          text: 'Crear Cuenta Nueva',
          onPressed: _isLoading
              ? null
              : () {
                  Navigator.pushNamed(context, '/register');
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
    TextInputAction? textInputAction,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
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
