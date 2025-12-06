import 'package:flutter/material.dart';
import 'utils/colors.dart';
import 'utils/typography.dart';
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

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Satly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          background: AppColors.background,
          surface: AppColors.card,
          error: AppColors.error,
        ),
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
          titleTextStyle: AppTextStyles.titleLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          selectedLabelStyle: AppTextStyles.labelSmall,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
        cardTheme:  CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.zero,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: AppTextStyles.labelLarge.copyWith(color: Colors.white),
            elevation: 0,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            minimumSize: const Size(double.infinity, 56),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: BorderSide(color: AppColors.primary),
            textStyle: AppTextStyles.labelLarge,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.card,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        textTheme: TextTheme(
          displayLarge: AppTextStyles.displayLarge.copyWith(
            color: AppColors.textPrimary,
          ),
          displayMedium: AppTextStyles.displayMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          titleLarge: AppTextStyles.titleLarge.copyWith(
            color: AppColors.textPrimary,
          ),
          titleMedium: AppTextStyles.titleMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          titleSmall: AppTextStyles.titleSmall.copyWith(
            color: AppColors.textPrimary,
          ),
          bodyLarge: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textPrimary,
          ),
          bodyMedium: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          bodySmall: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
          labelLarge: AppTextStyles.labelLarge,
          labelMedium: AppTextStyles.labelMedium,
          labelSmall: AppTextStyles.labelSmall,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          background: Color(0xFF121212),
          surface: Color(0xFF1E1E1E),
        ),
      ),
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
        '/wallet/receive': (context) =>
            const wallet_receive_view.WalletReceivePage(),
        '/wallet/withdraw': (context) =>
            const wallet_withdraw_view.WalletWithdrawPage(),
        '/wallet/history': (context) =>
            const wallet_history_view.WalletHistoryPage(),
      },
    );
  }
}
