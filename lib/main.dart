import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_theme.dart';
import 'providers/auth_provider.dart';
import 'providers/app_provider.dart';
import 'providers/locale_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/otp_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/customer/main_navigation_screen.dart';
import 'screens/customer/search_screen.dart';
import 'screens/customer/service_request_screen.dart';
import 'screens/customer/request_details_screen.dart';
import 'screens/customer/professional_profile_screen.dart';
import 'screens/customer/create_review_screen.dart';
import 'screens/customer/favorites_screen.dart';
import 'screens/chat/chat_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/profile/settings_screen.dart';
import 'screens/professional/pro_availability_screen.dart';
import 'screens/professional/pro_earnings_screen.dart';
import 'screens/admin/admin_dashboard_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const KhddamApp());
}

class KhddamApp extends StatelessWidget {
  const KhddamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, localeProv, child) {
          return MaterialApp(
            title: 'Khddam.ma - Service Marketplace Morocco',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.light,
            locale: localeProv.locale,
            routes: {
              '/': (context) => const SplashScreen(),
              '/onboarding': (context) => const OnboardingScreen(),
              '/login': (context) => const LoginScreen(),
              '/register': (context) => const RegisterScreen(),
              '/otp': (context) => const OtpScreen(),
              '/forgot-password': (context) => const ForgotPasswordScreen(),
              '/home': (context) => const MainNavigationScreen(),
              '/search': (context) => const SearchScreen(),
              '/create-request': (context) => const ServiceRequestScreen(),
              '/request-details': (context) => const RequestDetailsScreen(),
              '/professional-profile': (context) => const ProfessionalProfileScreen(),
              '/chat': (context) => const ChatScreen(),
              '/notifications': (context) => const NotificationsScreen(),
              '/create-review': (context) => const CreateReviewScreen(),
              '/favorites': (context) => const FavoritesScreen(),
              '/settings': (context) => const SettingsScreen(),
              '/pro-availability': (context) => const ProAvailabilityScreen(),
              '/pro-earnings': (context) => const ProEarningsScreen(),
              '/admin': (context) => const AdminDashboardScreen(),
            },
          );
        },
      ),
    );
  }
}
