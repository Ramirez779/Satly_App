// views/profile_page.dart
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/custom_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "Usuario SparkSeed";
  String userEmail = "usuario@sparkseed.com";
  int userLevel = 1;
  int totalSats = 0;
  int quizzesCompletados = 0;
  double progresoNivel = 0.0; // Cambiado a 0%
  String memberSince = "Enero 2024";
  bool emailVerified = true;
  bool notificationsEnabled = true;
  bool biometricAuthEnabled = false;

  // Configuración de privacidad
  bool profilePublic = true;
  bool emailVisible = false;
  bool shareStatistics = true;

  Uint8List? profileImageWeb;
  File? profileImageMobile;
  final ImagePicker picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 512,
        maxHeight: 512,
      );

      if (pickedFile != null) {
        if (kIsWeb) {
          final bytes = await pickedFile.readAsBytes();
          setState(() {
            profileImageWeb = bytes;
          });
          _showSuccessSnackbar('Foto de perfil actualizada');
        } else {
          setState(() {
            profileImageMobile = File(pickedFile.path);
          });
          _showSuccessSnackbar('Foto de perfil actualizada');
        }
      }
    } catch (e) {
      _showErrorSnackbar('Error al seleccionar imagen');
    }
  }

  void _editTextField(
    String title,
    String currentValue,
    Function(String) onSave,
  ) {
    final controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) {
        String tempValue = currentValue;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          title: Text(
            "Editar $title",
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          content: TextField(
            autofocus: true,
            controller: controller,
            decoration: InputDecoration(
              labelText: title,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
            ),
            onChanged: (value) => tempValue = value,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                if (tempValue.trim().isNotEmpty) {
                  onSave(tempValue.trim());
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Guardar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _toggleNotifications(bool value) {
    setState(() {
      notificationsEnabled = value;
    });
    _showSuccessSnackbar(
      value ? 'Notificaciones activadas' : 'Notificaciones desactivadas',
    );
  }

  void _toggleBiometricAuth(bool value) {
    setState(() {
      biometricAuthEnabled = value;
    });
    _showSuccessSnackbar(
      value
          ? 'Autenticación biométrica activada'
          : 'Autenticación biométrica desactivada',
    );
  }

  void _showPrivacySettings() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.security_rounded, color: Colors.blueAccent),
                  SizedBox(width: 12),
                  Text(
                    "Privacidad y Seguridad",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildPrivacyOption(
                'Perfil público',
                'Otros usuarios pueden ver tu progreso',
                profilePublic,
                (value) {
                  setState(() => profilePublic = value);
                  _showSuccessSnackbar(
                    value
                        ? 'Perfil público activado'
                        : 'Perfil público desactivado',
                  );
                },
              ),
              _buildPrivacyOption(
                'Email visible',
                'Mostrar email en tu perfil',
                emailVisible,
                (value) {
                  setState(() => emailVisible = value);
                  _showSuccessSnackbar(
                    value
                        ? 'Email visible activado'
                        : 'Email visible desactivado',
                  );
                },
              ),
              _buildPrivacyOption(
                'Estadísticas compartidas',
                'Compartir datos anónimos para mejorar la app',
                shareStatistics,
                (value) {
                  setState(() => shareStatistics = value);
                  _showSuccessSnackbar(
                    value
                        ? 'Estadísticas compartidas'
                        : 'Estadísticas privadas',
                  );
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Aplicar Cambios',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrivacyOption(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blueAccent,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 600;
          final bool isTablet =
              constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
          final bool isDesktop = constraints.maxWidth >= 1024;

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
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile
                      ? 16.0
                      : isTablet
                      ? 24.0
                      : 32.0,
                  vertical: isMobile
                      ? 16.0
                      : isTablet
                      ? 20.0
                      : 24.0,
                ),
                child: Column(
                  children: [
                    _buildProfileHeader(isMobile, isTablet, isDesktop),
                    SizedBox(
                      height: isMobile
                          ? 24
                          : isTablet
                          ? 20
                          : 24,
                    ),
                    _buildQuickStats(
                      isMobile,
                      isTablet,
                      isDesktop,
                      constraints.maxWidth,
                    ),
                    SizedBox(
                      height: isMobile
                          ? 24
                          : isTablet
                          ? 20
                          : 24,
                    ),
                    _buildSettingsSection(
                      context,
                      isMobile,
                      isTablet,
                      isDesktop,
                    ),
                    SizedBox(
                      height: isMobile
                          ? 24
                          : isTablet
                          ? 20
                          : 24,
                    ),
                    _buildAccountInfo(isMobile, isTablet, isDesktop),
                    SizedBox(
                      height: isMobile
                          ? 24
                          : isTablet
                          ? 20
                          : 24,
                    ),
                    _buildImportantActions(
                      context,
                      isMobile,
                      isTablet,
                      isDesktop,
                    ),
                    SizedBox(
                      height: isMobile
                          ? 32
                          : isTablet
                          ? 24
                          : 32,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(bool isMobile, bool isTablet, bool isDesktop) {
    final double padding = isMobile
        ? 24
        : isTablet
        ? 20
        : 24;
    final double avatarSize = isMobile
        ? 100
        : isTablet
        ? 90
        : 120;
    final double titleSize = isMobile
        ? 24
        : isTablet
        ? 20
        : 28;
    final double subtitleSize = isMobile
        ? 16
        : isTablet
        ? 14
        : 18;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.blueAccent, Colors.lightBlueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: avatarSize / 2 - 2,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: avatarSize / 2 - 6,
                    backgroundImage: profileImageWeb != null
                        ? MemoryImage(profileImageWeb!)
                        : profileImageMobile != null
                        ? FileImage(profileImageMobile!) as ImageProvider
                        : null,
                    child: profileImageWeb == null && profileImageMobile == null
                        ? Icon(
                            Icons.person_rounded,
                            size: avatarSize * 0.4,
                            color: Colors.blueAccent,
                          )
                        : null,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.blueAccent, Colors.lightBlueAccent],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.camera_alt_rounded,
                      size: isMobile
                          ? 18
                          : isTablet
                          ? 16
                          : 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: isMobile ? 16 : 12),

          // Nombre editable
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Colors.blueAccent, Colors.lightBlueAccent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(bounds),
                child: Text(
                  userName,
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: isMobile ? 8 : 6),
              GestureDetector(
                onTap: () => _editTextField('nombre', userName, (newName) {
                  setState(() => userName = newName);
                  _showSuccessSnackbar('Nombre actualizado');
                }),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.blueAccent.withOpacity(0.5),
                    ),
                  ),
                  child: Icon(
                    Icons.edit_rounded,
                    size: isMobile
                        ? 16
                        : isTablet
                        ? 14
                        : 18,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: isMobile ? 8 : 6),

          // Badge de nivel
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 12,
              vertical: isMobile ? 6 : 4,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.orangeAccent, Colors.amberAccent],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Nivel $userLevel • ${(progresoNivel * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                fontSize: isMobile
                    ? 14
                    : isTablet
                    ? 12
                    : 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),

          SizedBox(height: isMobile ? 8 : 6),

          // Email editable
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userEmail,
                style: TextStyle(
                  fontSize: subtitleSize,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(width: isMobile ? 8 : 6),
              GestureDetector(
                onTap: () => _editTextField('email', userEmail, (newEmail) {
                  setState(() => userEmail = newEmail);
                  _showSuccessSnackbar('Email actualizado');
                }),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.edit_rounded,
                    size: isMobile
                        ? 16
                        : isTablet
                        ? 14
                        : 18,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(
    bool isMobile,
    bool isTablet,
    bool isDesktop,
    double maxWidth,
  ) {
    final int crossAxisCount = isMobile ? 3 : (isTablet ? 4 : 3);
    final double childAspectRatio = isMobile ? 0.8 : (isTablet ? 0.9 : 1.0);
    final double spacing = isMobile ? 16 : (isTablet ? 12 : 20);

    return Container(
      padding: EdgeInsets.all(
        isMobile
            ? 20
            : isTablet
            ? 16
            : 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlueAccent],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ).createShader(bounds),
            child: Text(
              'Tu Progreso',
              style: TextStyle(
                fontSize: isMobile
                    ? 20
                    : isTablet
                    ? 18
                    : 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),

          SizedBox(height: isMobile ? 16 : 12),

          // Barra de progreso mejorada
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nivel $userLevel',
                style: TextStyle(
                  fontSize: isMobile
                      ? 14
                      : isTablet
                      ? 12
                      : 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${(progresoNivel * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: isMobile
                      ? 14
                      : isTablet
                      ? 12
                      : 16,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          SizedBox(height: isMobile ? 8 : 6),

          Container(
            height: isMobile
                ? 12
                : isTablet
                ? 10
                : 14,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.grey.shade200,
            ),
            child: Stack(
              children: [
                FractionallySizedBox(
                  widthFactor: progresoNivel,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: const LinearGradient(
                        colors: [Colors.blueAccent, Colors.lightBlueAccent],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: isMobile ? 20 : 16),

          // Stats en grid responsive
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: childAspectRatio,
            children: [
              _buildStatItem(
                'SATS',
                totalSats.toString(),
                Icons.bolt_rounded,
                Colors.amber.shade600,
                isMobile,
                isTablet,
              ),
              _buildStatItem(
                'Quizzes',
                quizzesCompletados.toString(),
                Icons.quiz_rounded,
                Colors.green.shade600,
                isMobile,
                isTablet,
              ),
              _buildStatItem(
                'Nivel',
                userLevel.toString(),
                Icons.star_rounded,
                Colors.purple.shade600,
                isMobile,
                isTablet,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    IconData icon,
    Color color,
    bool isMobile,
    bool isTablet,
  ) {
    final double padding = isMobile ? 12 : (isTablet ? 8 : 16);
    final double iconSize = isMobile ? 20 : (isTablet ? 16 : 24);
    final double valueSize = isMobile ? 18 : (isTablet ? 16 : 22);
    final double labelSize = isMobile ? 12 : (isTablet ? 10 : 14);

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(isMobile ? 8 : 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: iconSize),
          ),
          SizedBox(height: isMobile ? 8 : 6),
          Text(
            value,
            style: TextStyle(
              fontSize: valueSize,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(fontSize: labelSize, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(
    BuildContext context,
    bool isMobile,
    bool isTablet,
    bool isDesktop,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(
              isMobile
                  ? 20
                  : isTablet
                  ? 16
                  : 20,
            ),
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlueAccent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds),
              child: Text(
                'Configuración',
                style: TextStyle(
                  fontSize: isMobile
                      ? 20
                      : isTablet
                      ? 18
                      : 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          _buildSettingsItemWithSwitch(
            Icons.notifications_rounded,
            'Notificaciones',
            'Recibir notificaciones de progreso',
            notificationsEnabled,
            _toggleNotifications,
            isMobile,
            isTablet,
          ),
          _buildSettingsItemWithSwitch(
            Icons.fingerprint_rounded,
            'Autenticación biométrica',
            'Usar huella dactilar o Face ID',
            biometricAuthEnabled,
            _toggleBiometricAuth,
            isMobile,
            isTablet,
          ),
          _buildSettingsItem(
            Icons.photo_camera_rounded,
            'Cambiar Foto de Perfil',
            'Actualiza tu foto de perfil',
            onTap: _pickImage,
            isMobile: isMobile,
            isTablet: isTablet,
          ),
          _buildSettingsItem(
            Icons.security_rounded,
            'Privacidad y Seguridad',
            'Gestiona tu seguridad y privacidad',
            onTap: _showPrivacySettings,
            isMobile: isMobile,
            isTablet: isTablet,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    IconData icon,
    String title,
    String subtitle, {
    VoidCallback? onTap,
    required bool isMobile,
    required bool isTablet,
  }) {
    // Esta llave debe estar aquí
    final double iconSize = isMobile ? 20 : (isTablet ? 18 : 22);
    final double titleSize = isMobile ? 16 : (isTablet ? 14 : 18);
    final double subtitleSize = isMobile ? 12 : (isTablet ? 11 : 14);

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white, size: iconSize),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: titleSize),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: subtitleSize, color: Colors.grey.shade600),
      ),
      trailing: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          size: isMobile
              ? 14
              : isTablet
              ? 12
              : 16,
          color: Colors.grey.shade600,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildSettingsItemWithSwitch(
    IconData icon,
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
    bool isMobile,
    bool isTablet,
  ) {
    final double iconSize = isMobile ? 20 : (isTablet ? 18 : 22);
    final double titleSize = isMobile ? 16 : (isTablet ? 14 : 18);
    final double subtitleSize = isMobile ? 12 : (isTablet ? 11 : 14);

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white, size: iconSize),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: titleSize),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: subtitleSize, color: Colors.grey.shade600),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.blueAccent,
      ),
    );
  }

  Widget _buildAccountInfo(bool isMobile, bool isTablet, bool isDesktop) {
    final double padding = isMobile
        ? 20
        : isTablet
        ? 16
        : 20;
    final double titleSize = isMobile
        ? 18
        : isTablet
        ? 16
        : 20;
    final double textSize = isMobile
        ? 14
        : isTablet
        ? 12
        : 16;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlueAccent],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ).createShader(bounds),
            child: Text(
              'Información de la Cuenta',
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),

          SizedBox(height: isMobile ? 16 : 12),

          _buildInfoRow('Miembro desde', memberSince, textSize),
          _buildInfoRow(
            'Email verificado',
            emailVerified ? 'Sí ✅' : 'No ❌',
            textSize,
          ),
          _buildInfoRow(
            'ID de usuario',
            'SPK-${userEmail.hashCode.abs()}',
            textSize,
          ),
          _buildInfoRow(
            'Perfil público',
            profilePublic ? 'Activado' : 'Desactivado',
            textSize,
          ),
          _buildInfoRow(
            'Estadísticas compartidas',
            shareStatistics ? 'Activado' : 'Desactivado',
            textSize,
          ),

          SizedBox(height: isMobile ? 12 : 8),

          Text(
            '* Los datos de progreso se actualizan automáticamente',
            style: TextStyle(
              fontSize: isMobile
                  ? 10
                  : isTablet
                  ? 9
                  : 12,
              color: Colors.grey.shade500,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, double textSize) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: textSize, color: Colors.grey.shade600),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: textSize,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImportantActions(
    BuildContext context,
    bool isMobile,
    bool isTablet,
    bool isDesktop,
  ) {
    final double buttonHeight = isMobile ? 56 : (isTablet ? 52 : 60);
    final double spacing = isMobile ? 12 : (isTablet ? 10 : 16);

    if (isDesktop) {
      return Row(
        children: [
          Expanded(
            child: CustomButton(
              text: 'Compartir Mi Progreso',
              onPressed: () {
                _showComingSoonSnackbar(context, 'Compartir progreso');
              },
              isPrimary: true,
              height: buttonHeight,
            ),
          ),
          SizedBox(width: spacing),
          Expanded(
            child: CustomButton(
              text: 'Cerrar Sesión',
              onPressed: () => _showLogoutDialog(context),
              isPrimary: false,
              height: buttonHeight,
              backgroundColor: Colors.red,
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          CustomButton(
            text: 'Compartir Mi Progreso',
            onPressed: () {
              _showComingSoonSnackbar(context, 'Compartir progreso');
            },
            isPrimary: true,
            height: buttonHeight,
          ),
          SizedBox(height: spacing),
          CustomButton(
            text: 'Cerrar Sesión',
            onPressed: () => _showLogoutDialog(context),
            isPrimary: false,
            height: buttonHeight,
            backgroundColor: Colors.red,
          ),
        ],
      );
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.logout_rounded, size: 48, color: Colors.red.shade600),
              const SizedBox(height: 16),
              Text(
                'Cerrar sesión',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.red.shade600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '¿Estás seguro de que quieres cerrar sesión?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Cancelar',
                      onPressed: () => Navigator.pop(context),
                      isPrimary: false,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: 'Cerrar Sesión',
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/',
                          (route) => false,
                        );
                      },
                      isPrimary: true,
                      backgroundColor: Colors.red,
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

  void _showComingSoonSnackbar(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature (próximamente)'),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
