// views/home_page.dart
import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'quiz_page.dart';
import 'profile_page.dart';
import 'wallet_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [DashboardPage(), QuizPage(), WalletPage(), ProfilePage()];

  final List<String> _pageTitles = ['Dashboard', 'Quizzes',"Wallet", 'Perfil']; //Asi aparecen en la interfaz
  final List<IconData> _pageIcons = [
    Icons.dashboard_rounded,
    Icons.quiz_rounded,
    Icons.account_balance_wallet_rounded,
    Icons.person_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          final isPortrait = orientation == Orientation.portrait;

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Color(0xFFE3F2FD)],
              ),
            ),
            child: Column(
              children: [
                _buildAppBar(isPortrait),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _pages[_currentIndex],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }

  Widget _buildAppBar(bool isPortrait) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueAccent, Colors.lightBlueAccent],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x4D007BFF),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isPortrait ? 16 : 24,
            vertical: isPortrait ? 12 : 8,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0x33FFFFFF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _pageIcons[_currentIndex],
                  size: isPortrait ? 24 : 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.white, Color(0xB3FFFFFF)],
                  ).createShader(bounds),
                  child: Text(
                    _pageTitles[_currentIndex],
                    style: TextStyle(
                      fontSize: isPortrait ? 24 : 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
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

  Widget _buildNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_pageTitles.length, (index) {
              return _buildNavItem(
                index,
                _pageIcons[index],
                _pageTitles[index],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0x1A007BFF) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blueAccent : const Color(0xFFBDBDBD),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20, color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? Colors.blueAccent : const Color(0xFF757575),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0x1AF44336),
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
}
// welcome, register, login, home, landing, lo demás no