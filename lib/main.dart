import 'package:flutter/material.dart';
import 'utils/colors.dart';
import 'views/welcome_page.dart';
import 'views/login_page.dart';
import 'views/register_page.dart';
import 'views/home_page.dart' as home_view;
import 'views/quiz_page.dart' as quiz_view;
import 'views/dashboard_page.dart' as dashboard_view;
import 'views/profile_page.dart' as profile_view;
import 'views/wallet_page.dart' as wallet_view;
import 'views/wallet_receive_page.dart' as wallet_receive_view;
import 'views/wallet_withdraw_page.dart' as wallet_withdraw_view;
import 'views/wallet_history_page.dart' as wallet_history_view;

// Colores personalizados
class AppColors {
  static const Color primary = Colors.blue;
  static const Color primaryAccent = Colors.blueAccent;
  static const Color background = Colors.white;
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Colors.black54;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SparkSeed',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryAccent,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.background,
          selectedItemColor: AppColors.primaryAccent,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: AppColors.textPrimary),
          bodyMedium: TextStyle(color: AppColors.textSecondary),
        ),
      ),
      // AÑADE ESTO - darkTheme básico para evitar el error
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      // Fuerza el tema claro siempre
      themeMode: ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const home_view.HomePage(),
        '/quiz': (context) => const quiz_view.QuizPage(),
        '/dashboard': (context) => const dashboard_view.DashboardPage(),
        '/profile': (context) => const profile_view.ProfilePage(),

        '/wallet': (context) => const wallet_view.WalletPage(),
        '/wallet/receive': (context) => const wallet_receive_view.WalletReceivePage(),
        '/wallet/withdraw': (context) => const wallet_withdraw_view.WalletWithdrawPage(),
        '/wallet/history': (context) => const wallet_history_view.WalletHistoryPage(),
      },
    );
  }
}
