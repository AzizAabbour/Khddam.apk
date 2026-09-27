import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/app_provider.dart';
import '../../providers/auth_provider.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'requests_list_screen.dart';
import '../chat/conversations_screen.dart';
import '../profile/profile_screen.dart';
import '../professional/pro_dashboard_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppProvider>().loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final app = context.watch<AppProvider>();

    // If professional mode is active, render Pro Dashboard Shell
    if (auth.isProfessionalMode) {
      return const ProDashboardScreen();
    }

    final List<Widget> pages = [
      const HomeScreen(),
      const SearchScreen(),
      const RequestsListScreen(),
      const ConversationsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: app.currentNavIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          border: const Border(top: BorderSide(color: AppColors.border, width: 1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: app.currentNavIndex,
          onTap: (index) {
            app.setNavIndex(index);
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 0,
          backgroundColor: AppColors.white,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded, color: AppColors.primary),
              label: 'Accueil',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.search_rounded, color: AppColors.primary),
              label: 'Recherche',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                isLabelVisible: app.activeRequests.isNotEmpty,
                label: Text('${app.activeRequests.length}'),
                child: const Icon(Icons.assignment_outlined),
              ),
              activeIcon: Badge(
                isLabelVisible: app.activeRequests.isNotEmpty,
                label: Text('${app.activeRequests.length}'),
                child: const Icon(Icons.assignment_rounded, color: AppColors.primary),
              ),
              label: 'Demandes',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                isLabelVisible: app.unreadMessages > 0,
                label: Text('${app.unreadMessages}'),
                child: const Icon(Icons.chat_bubble_outline_rounded),
              ),
              activeIcon: Badge(
                isLabelVisible: app.unreadMessages > 0,
                label: Text('${app.unreadMessages}'),
                child: const Icon(Icons.chat_bubble_rounded, color: AppColors.primary),
              ),
              label: 'Messages',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded, color: AppColors.primary),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
