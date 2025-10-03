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
              Icons.person_add_alt_1_rounded,
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
            'Crear Cuenta',
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
          'Únete a la comunidad',
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
          SizedBox(height: isPortrait ? 20 : 16),
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
          SizedBox(height: isPortrait ? 20 : 16),
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
        // Botón de registro con sombra
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
            text: 'Crear Cuenta',
            onPressed: _isLoading ? null : _submitRegister,
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
                '¿Ya tienes cuenta?',
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
        
        // Botón de login con borde
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
              text: 'Iniciar Sesión',
              onPressed: _isLoading
                  ? null
                  : () {
                      Navigator.pushReplacementNamed(context, '/login');
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
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
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