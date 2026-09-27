import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/enums/enums.dart';
import '../../providers/app_provider.dart';
import '../../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final app = context.watch<AppProvider>();
    final user = auth.user;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Mon Profil'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Card Header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: AppColors.primaryLighter,
                      child: Text(
                        user?.fullName.substring(0, 2).toUpperCase() ?? 'AZ',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user?.fullName ?? 'Aziz Bennani', style: AppTypography.headingMedium),
                          const SizedBox(height: 2),
                          Text(user?.phone ?? '+212 6 12 34 56 78', style: AppTypography.bodySmall),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 14, color: AppColors.primary),
                              const SizedBox(width: 2),
                              Text(user?.city ?? 'Casablanca', style: AppTypography.caption),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Mode Switch Banner (Customer <-> Professional)
            Card(
              color: AppColors.primaryLighter,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: AppColors.primary, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    const Icon(Icons.work_outline, color: AppColors.primary, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Espace Professionnel / Artisan', style: AppTypography.headingSmall),
                          Text(
                            'Basculez vers l\'interface professionnel pour gérer vos services.',
                            style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: auth.isProfessionalMode,
                      activeColor: AppColors.primary,
                      onChanged: (value) {
                        auth.switchRole(value ? UserRole.professional : UserRole.customer);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Menu Section
            Card(
              child: Column(
                children: [
                  _buildMenuItem(
                    context,
                    icon: Icons.assignment_outlined,
                    title: 'Mes Demandes',
                    onTap: () => app.setNavIndex(2),
                  ),
                  const Divider(height: 1),
                  _buildMenuItem(
                    context,
                    icon: Icons.favorite_border_rounded,
                    title: 'Mes Favoris',
                    onTap: () => Navigator.pushNamed(context, '/favorites'),
                  ),
                  const Divider(height: 1),
                  _buildMenuItem(
                    context,
                    icon: Icons.location_city_outlined,
                    title: 'Adresses Enregistrées',
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  _buildMenuItem(
                    context,
                    icon: Icons.settings_outlined,
                    title: 'Paramètres & Langue',
                    onTap: () => Navigator.pushNamed(context, '/settings'),
                  ),
                  const Divider(height: 1),
                  _buildMenuItem(
                    context,
                    icon: Icons.admin_panel_settings_outlined,
                    title: 'Tableau de bord Admin',
                    subtitle: 'Gestion globale de la plateforme',
                    onTap: () => Navigator.pushNamed(context, '/admin'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Logout Button
            Card(
              child: ListTile(
                leading: const Icon(Icons.logout, color: AppColors.error),
                title: const Text(
                  'Déconnexion',
                  style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  auth.logout();
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ),
            const SizedBox(height: 24),
            Text('Khddam.ma v1.0.0 • Maroc 🇲🇦', style: AppTypography.caption),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: AppTypography.labelLarge),
      subtitle: subtitle != null ? Text(subtitle, style: AppTypography.caption) : null,
      trailing: const Icon(Icons.chevron_right, size: 20, color: AppColors.textTertiary),
      onTap: onTap,
    );
  }
}
