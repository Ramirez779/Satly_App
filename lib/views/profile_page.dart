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
  double progresoNivel = 0.0;
  String memberSince = "Enero 2024";
  bool emailVerified = true;

  Uint8List? profileImageWeb;
  File? profileImageMobile;

  final ImagePicker picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          profileImageWeb = bytes;
        });
      } else {
        setState(() {
          profileImageMobile = File(pickedFile.path);
        });
      }
    }
  }

  void _editTextField(String title, String currentValue, Function(String) onSave) {
    showDialog(
      context: context,
      builder: (context) {
        String tempValue = currentValue;
        return AlertDialog(
          title: Text("Editar $title"),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(labelText: title),
            onChanged: (value) => tempValue = value,
            controller: TextEditingController(text: currentValue),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                if (tempValue.trim().isNotEmpty) {
                  onSave(tempValue);
                  Navigator.pop(context);
                }
              },
              child: const Text("Guardar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildQuickStats(),
            const SizedBox(height: 24),
            _buildSettingsSection(context),
            const SizedBox(height: 24),
            _buildAccountInfo(),
            const SizedBox(height: 32),
            _buildImportantActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Foto de perfil editable
            Stack(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blueAccent.shade100,
                    backgroundImage: profileImageWeb != null
                        ? MemoryImage(profileImageWeb!)
                        : profileImageMobile != null
                            ? FileImage(profileImageMobile!) as ImageProvider
                            : null,
                    child: profileImageWeb == null && profileImageMobile == null
                        ? const Icon(Icons.person, size: 50, color: Colors.blueAccent)
                        : null,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Nombre editable
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userName,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _editTextField('nombre', userName, (newName) {
                    setState(() => userName = newName);
                  }),
                  child: const Icon(Icons.edit, size: 18, color: Colors.blueAccent),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withAlpha(25),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Nivel $userLevel',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueAccent.shade700,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Email editable
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(userEmail, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _editTextField('email', userEmail, (newEmail) {
                    setState(() => userEmail = newEmail);
                  }),
                  child: const Icon(Icons.edit, size: 16, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Tu Progreso', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nivel $userLevel', style: Theme.of(context).textTheme.bodyMedium),
                Text('${(progresoNivel * 100).toStringAsFixed(0)}% completado',
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progresoNivel,
              backgroundColor: Colors.grey.shade300,
              color: Colors.blueAccent,
              minHeight: 8,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('SATS', totalSats.toString(), Icons.monetization_on),
                _buildStatItem('Quizzes', quizzesCompletados.toString(), Icons.quiz),
                _buildStatItem('Nivel', userLevel.toString(), Icons.star),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blueAccent.withAlpha(25),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.blueAccent, size: 24),
        ),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Configuración de Cuenta',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              _buildSettingsItem(Icons.photo_camera, 'Cambiar Foto de Perfil',
                  'Actualiza tu foto de perfil', onTap: _pickImage),
              _buildSettingsItem(Icons.notifications, 'Notificaciones',
                  'Configura tus preferencias de notificación', onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Configuración de notificaciones (próximamente)')));
              }),
              _buildSettingsItem(Icons.security, 'Privacidad y Seguridad',
                  'Gestiona tu seguridad y privacidad', onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Configuración de seguridad (próximamente)')));
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, String subtitle, {VoidCallback? onTap}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blueAccent.withAlpha(25),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.blueAccent, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildAccountInfo() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Información de la Cuenta',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildInfoRow('Miembro desde', memberSince),
            _buildInfoRow('Email verificado', emailVerified ? 'Sí' : 'No'),
            _buildInfoRow('ID de usuario', 'SPK-${userEmail.hashCode.abs()}'),
            const SizedBox(height: 8),
            const Text('* Los datos de progreso se actualizan automáticamente',
                style: TextStyle(fontSize: 10, color: Colors.grey, fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey))),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildImportantActions(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          text: 'Compartir Mi Progreso',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Compartir progreso (próximamente)')));
          },
          backgroundColor: Colors.green,
        ),
        const SizedBox(height: 12),
        CustomButton(
          text: 'Ayuda y Soporte',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ayuda y soporte (próximamente)')));
          },
          backgroundColor: Colors.blueGrey,
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () => _showLogoutDialog(context),
          child: const Text('Cerrar Sesión', style: TextStyle(color: Colors.red, fontSize: 16)),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
            child: const Text('Cerrar sesión', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
