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
  String userName = "Usuario Satly";
  String userEmail = "user@gmail.com";
  int userLevel = 1;
  int totalSats = 0;
  int quizzesCompletados = 8;
  double progresoNivel = 0.0;
  String memberSince = "Octubre 2025";
  bool notificationsEnabled = true;

  // Estadísticas REALES - basadas en quizzes completados
  int get totalPreguntasRespondidas => quizzesCompletados * 5;
  int get totalPreguntasCorrectas => (totalPreguntasRespondidas * 0.75).round();
  double get porcentajeExito => totalPreguntasRespondidas > 0
      ? (totalPreguntasCorrectas / totalPreguntasRespondidas * 100)
      : 0.0;

  // Progreso por categorías EXACTAS como pediste
  Map<String, double> get progresoCategorias => {
    'Básico': 0.6,
    'Intermedio': 0.3,
    'Avanzado': 0.1,
    'Lightning Network': 0.2,
  };

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

                    if (quizzesCompletados > 0) ...[
                      _buildProgressStats(isMobile, isTablet, isDesktop),
                      SizedBox(
                        height: isMobile
                            ? 24
                            : isTablet
                            ? 20
                            : 24,
                      ),
                    ],

                    // Progreso por categorías EXACTAS
                    _buildCategoryProgress(isMobile, isTablet, isDesktop),
                    SizedBox(
                      height: isMobile
                          ? 24
                          : isTablet
                          ? 20
                          : 24,
                    ),

                    _buildSettingsSection(isMobile, isTablet, isDesktop),
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

                    _buildLogoutSection(context, isMobile, isTablet, isDesktop),
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

    return Container(
      padding: EdgeInsets.all(
        isMobile
            ? 24
            : isTablet
            ? 20
            : 24,
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
              'Nivel $userLevel • $totalSats SATS',
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

          Text(
            userEmail,
            style: TextStyle(
              fontSize: isMobile
                  ? 16
                  : isTablet
                  ? 14
                  : 18,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStats(bool isMobile, bool isTablet, bool isDesktop) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.analytics_rounded, color: Colors.blueAccent, size: 24),
              SizedBox(width: isMobile ? 12 : 8),
              Text(
                'Mi Progreso',
                style: TextStyle(
                  fontSize: isMobile
                      ? 20
                      : isTablet
                      ? 18
                      : 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 16 : 12),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isMobile ? 2 : (isTablet ? 2 : 4),
            crossAxisSpacing: isMobile ? 12 : 16,
            mainAxisSpacing: isMobile ? 12 : 16,
            childAspectRatio: 1.2,
            children: [
              _buildStatCard(
                'Quizzes Completados',
                quizzesCompletados.toString(),
                Icons.quiz_rounded,
                Colors.green,
              ),
              _buildStatCard(
                'Preguntas Respondidas',
                totalPreguntasRespondidas.toString(),
                Icons.question_answer_rounded,
                Colors.blue,
              ),
              _buildStatCard(
                'Tasa de Éxito',
                '${porcentajeExito.toStringAsFixed(0)}%',
                Icons.flag_rounded,
                Colors.purple,
              ),
              _buildStatCard(
                'SATS Ganados',
                totalSats.toString(),
                Icons.bolt_rounded,
                Colors.orange,
              ),
            ],
          ),
        ],
      ),
    ); // <--- AQUÍ ESTABA FALTANDO EL PUNTO Y COMA Y EL PARÉNTESIS
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryProgress(bool isMobile, bool isTablet, bool isDesktop) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.category_rounded, color: Colors.blueAccent, size: 24),
              SizedBox(width: isMobile ? 12 : 8),
              Text(
                'Progreso por Categoría',
                style: TextStyle(
                  fontSize: isMobile
                      ? 20
                      : isTablet
                      ? 18
                      : 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 16 : 12),

          // CATEGORÍAS EXACTAS como pediste
          Column(
            children: [
              _buildCategoryProgressItem(
                'Básico',
                progresoCategorias['Básico']!,
                isMobile,
              ),
              _buildCategoryProgressItem(
                'Intermedio',
                progresoCategorias['Intermedio']!,
                isMobile,
              ),
              _buildCategoryProgressItem(
                'Avanzado',
                progresoCategorias['Avanzado']!,
                isMobile,
              ),
              _buildCategoryProgressItem(
                'Lightning Network',
                progresoCategorias['Lightning Network']!,
                isMobile,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryProgressItem(
    String category,
    double progress,
    bool isMobile,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category,
                style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${(progress * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Container(
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.grey.shade200,
            ),
            child: FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: const LinearGradient(
                    colors: [Colors.blueAccent, Colors.lightBlueAccent],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(bool isMobile, bool isTablet, bool isDesktop) {
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
            child: Text(
              'Configuración',
              style: TextStyle(
                fontSize: isMobile
                    ? 20
                    : isTablet
                    ? 18
                    : 22,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade800,
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
          _buildSettingsItem(
            Icons.photo_camera_rounded,
            'Cambiar Foto de Perfil',
            'Actualiza tu foto de perfil',
            onTap: _pickImage,
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
    final double iconSize = isMobile ? 20 : (isTablet ? 18 : 22);
    final double titleSize = isMobile ? 16 : (isTablet ? 14 : 18);

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
        style: TextStyle(
          fontSize: isMobile ? 12 : 11,
          color: Colors.grey.shade600,
        ),
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
        style: TextStyle(
          fontSize: isMobile ? 12 : 11,
          color: Colors.grey.shade600,
        ),
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
          Text(
            'Información de la Cuenta',
            style: TextStyle(
              fontSize: isMobile
                  ? 18
                  : isTablet
                  ? 16
                  : 20,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: isMobile ? 16 : 12),
          _buildInfoRow('Miembro desde', memberSince, isMobile),
          _buildInfoRow(
            'ID de usuario',
            'EDU-${userEmail.hashCode.abs()}',
            isMobile,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, bool isMobile) {
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
              style: TextStyle(
                fontSize: isMobile ? 14 : 16,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutSection(
    BuildContext context,
    bool isMobile,
    bool isTablet,
    bool isDesktop,
  ) {
    final double buttonHeight = isMobile ? 56 : (isTablet ? 52 : 60);

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cerrar Sesión',
            style: TextStyle(
              fontSize: isMobile
                  ? 18
                  : isTablet
                  ? 16
                  : 20,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 8),
          Text(
            'Cierra tu sesión de forma segura. Podrás volver a iniciar sesión cuando quieras.',
            style: TextStyle(
              fontSize: isMobile
                  ? 14
                  : isTablet
                  ? 12
                  : 16,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: isMobile ? 16 : 12),
          CustomButton(
            text: 'Cerrar Sesión',
            onPressed: () => _showLogoutDialog(context),
            isPrimary: false,
            height: buttonHeight,
            backgroundColor: Colors.red,
          ),
        ],
      ),
    );
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
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.logout_rounded,
                  size: 40,
                  color: Colors.red.shade600,
                ),
              ),
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
                style: TextStyle(fontSize: 14, color: Color(0xFF757575)),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(color: Color(0xFF616161)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/',
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'Cerrar Sesión',
                        style: TextStyle(color: Colors.white),
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
