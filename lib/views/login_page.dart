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
                  colors: [
                    Colors.white,
                    Colors.blue.shade50,
                    Colors.blue.shade100,
                  ],
                  stops: const [0.0, 0.6, 1.0],
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
                      SizedBox(height: isPortrait ? 40 : 20),

                      _buildHeader(isPortrait),
                      _buildForm(isPortrait),
                      _buildActions(isPortrait),
                      SizedBox(height: isPortrait ? 40 : 20),
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
        // Logo mejorado
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.3),
                blurRadius: 25,
                spreadRadius: 3,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            width: isPortrait ? 110 : 90,
            height: isPortrait ? 110 : 90,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0066FF),
                  Color(0xFF00BFFF),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.bolt_rounded,
              size: 50,
              color: Colors.white,
            ),
          ),
        ),
        
        SizedBox(height: isPortrait ? 24 : 16),
        
        // Título con mejor jerarquía
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Color(0xFF0066FF),
              Color(0xFF00BFFF),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(bounds),
          child: Text(
            'Bienvenido',
            style: TextStyle(
              fontSize: isPortrait ? 38 : 30,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.8,
              color: Colors.white,
            ),
          ),
        ),
        
        SizedBox(height: 8),
        
        Text(
          'Inicia sesión en tu cuenta',
          style: TextStyle(
            fontSize: isPortrait ? 16 : 14,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        
        SizedBox(height: 4),
        
        Text(
          'SparkSeed',
          style: TextStyle(
            fontSize: isPortrait ? 18 : 16,
            color: Colors.blue.shade700,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
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
          SizedBox(height: isPortrait ? 40 : 30),
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
          SizedBox(height: isPortrait ? 20 : 16),
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
          SizedBox(height: isPortrait ? 10 : 8),
        ],
      ),
    );
  }

  Widget _buildActions(bool isPortrait) {
    return Column(
      children: [
        // Botón de login con sombra
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: CustomButton(
            text: 'Iniciar Sesión',
            onPressed: _isLoading ? null : _submitLogin,
            isLoading: _isLoading,
            isPrimary: true,
            height: isPortrait ? 58 : 54,
          ),
        ),
        
        SizedBox(height: isPortrait ? 24 : 20),
        
        // Separador mejorado
        Row(
          children: [
            Expanded(
              child: Divider(
                color: Colors.grey.shade400,
                thickness: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isPortrait ? 16 : 12),
              child: Text(
                '¿No tienes cuenta?',
                style: TextStyle(
                  fontSize: isPortrait ? 14 : 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: Colors.grey.shade400,
                thickness: 1,
              ),
            ),
          ],
        ),
        
        SizedBox(height: isPortrait ? 24 : 20),
        
        // Botón de registro con borde
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.blueAccent,
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: CustomButton(
              text: 'Crear Cuenta Nueva',
              onPressed: _isLoading
                  ? null
                  : () {
                      Navigator.pushNamed(context, '/register');
                    },
              isPrimary: false,
              height: isPortrait ? 58 : 54,
            ),
          ),
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
      style: TextStyle(
        fontSize: isPortrait ? 16 : 14,
        color: Colors.grey.shade800,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade600),
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: isPortrait ? 18 : 16,
        ),
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
      style: TextStyle(
        fontSize: isPortrait ? 16 : 14,
        color: Colors.grey.shade800,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade600),
        prefixIcon: const Icon(Icons.lock_rounded, color: Colors.blueAccent),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off_rounded : Icons.visibility_rounded,
            color: Colors.grey.shade600,
          ),
          onPressed: onToggle,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: isPortrait ? 18 : 16,
        ),
      ),
      validator: validator,
    );
  }
}