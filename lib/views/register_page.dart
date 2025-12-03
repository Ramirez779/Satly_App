import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import 'complete_profile_page.dart';

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

  // Servicio de autenticación integrado
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email.trim());
  }

  bool _isValidLNURL(String lnurl) {
    if (lnurl.isEmpty) return false;
    final lnurlRegex = RegExp(
      r'^(lnurl1[02-9ac-hj-np-z]+|https?://.+|LNURL[A-Za-z0-9]+)$',
      caseSensitive: false,
    );
    return lnurlRegex.hasMatch(lnurl.trim());
  }

  Future<Map<String, dynamic>> _registerWithEmail() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!_isValidEmail(_emailCtl.text.trim())) {
      throw Exception('Formato de email inválido');
    }

    if (_passCtl.text.length < 6) {
      throw Exception('La contraseña debe tener al menos 6 caracteres');
    }

    // Simulación de registro exitoso
    return {
      'success': true,
      'message': 'Registro exitoso',
      'user': {
        'name': _nameCtl.text.trim(),
        'email': _emailCtl.text.trim(),
        'authMethod': 'email',
      },
    };
  }

  Future<Map<String, dynamic>> _registerWithLNURL(String lnurl) async {
    await Future.delayed(const Duration(seconds: 3));

    if (!_isValidLNURL(lnurl)) {
      throw Exception(
        'Formato LNURL inválido. Use lnurl1..., https://... o código LNURL',
      );
    }

    // Simulación de autenticación LNURL exitosa
    return {
      'success': true,
      'message': 'Autenticación Lightning exitosa',
      'user': {'lnurl': lnurl, 'authMethod': 'lightning'},
    };
  }

  void _submitEmailRegister() async {
    if (!_formKey.currentState!.validate()) return;
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final result = await _registerWithEmail();

      if (!mounted) return;

      if (result['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message']),
            backgroundColor: Colors.green.shade600,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        Navigator.pushReplacementNamed(context, '/home');
      }
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

  void _showLNURLRegistration() {
    final lnurlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header del diálogo
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFA726), Color(0xFFFF9800)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.flash_on,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Registro con Lightning',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Autentícate con tu billetera y luego completa tu perfil',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: lnurlController,
                decoration: InputDecoration(
                  labelText: 'LNURL',
                  labelStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Container(
                    margin: const EdgeInsets.all(12),
                    child: Icon(Icons.qr_code, color: Colors.orange.shade600),
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
                    borderSide: BorderSide(
                      color: Colors.orange.shade600,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  hintText: 'lnurl',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey.shade700,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      child: const Text('Cancelar'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFA726), Color(0xFFFF9800)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          final lnurl = lnurlController.text.trim();
                          if (lnurl.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Ingresa un LNURL válido'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          Navigator.pop(context);
                          _processLNURLRegistration(lnurl);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Continuar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _processLNURLRegistration(String lnurl) async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final result = await _registerWithLNURL(lnurl);

      if (!mounted) return;

      if (result['success'] == true) {
        // Navegar a completar perfil después de LNURL exitoso
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CompleteProfilePage(lnurl: lnurl, authMethod: 'lightning'),
          ),
        );
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error Lightning: $error'),
          backgroundColor: Colors.red.shade600,
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
              colors: [Color(0xFF0066FF), Color(0xFF00BFFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.4),
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
            colors: [Color(0xFF0066FF), Color(0xFF00BFFF)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.3, 0.7],
          ).createShader(bounds),
          child: Text(
            'Crear Cuenta',
            style: TextStyle(
              fontSize: isPortrait ? 40 : 32,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.2,
              height: 1.1,
            ),
          ),
        ),
        SizedBox(height: 8),

        SizedBox(height: isPortrait ? 20 : 16),
      ],
    );
  }

  Widget _buildForm(bool isPortrait) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: isPortrait ? 30 : 24),
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
            label: 'Correo electrónico',
            icon: Icons.email_rounded,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            isPortrait: isPortrait,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Ingresa tu email';
              final emailRegex = RegExp(
                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
              );
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
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildActions(bool isPortrait) {
    return Column(
      children: [
        // Botón de registro tradicional
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.4),
                blurRadius: 25,
                spreadRadius: 2,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: CustomButton(
            text: 'Crear Cuenta con Email',
            onPressed: _isLoading ? null : _submitEmailRegister,
            isLoading: _isLoading,
            isPrimary: true,
            height: isPortrait ? 60 : 56,
          ),
        ),

        SizedBox(height: 24),

        // Separador
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade300)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'O regístrate con',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey.shade300)),
          ],
        ),

        SizedBox(height: 24),

        // Botón Lightning
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.orange.shade300, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(0.2),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Material(
              color: Colors.orange.shade50,
              child: InkWell(
                onTap: _isLoading ? null : _showLNURLRegistration,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: isPortrait ? 56 : 52,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.flash_on_rounded,
                        color: Colors.orange.shade800,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Lightning Wallet',
                        style: TextStyle(
                          color: Colors.orange.shade800,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 32),

        // Footer - Diseño similar al login
        Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '¿Ya tienes cuenta?',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: _isLoading
                    ? null
                    : () => Navigator.pushReplacementNamed(context, '/login'),
                child: Text(
                  'Iniciar sesión',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue.shade600,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue.shade400,
                  ),
                ),
              ),
            ],
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
          child: Icon(icon, color: Colors.blueAccent, size: 22),
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
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
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
          child: const Icon(
            Icons.lock_rounded,
            color: Colors.blueAccent,
            size: 22,
          ),
        ),
        suffixIcon: Container(
          margin: const EdgeInsets.all(8),
          child: IconButton(
            icon: Icon(
              obscureText
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_rounded,
              color: Colors.grey.shade600,
              size: 22,
            ),
            onPressed: onToggle,
          ),
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
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
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
