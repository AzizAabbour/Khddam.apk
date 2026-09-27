import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_constants.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Administration Khddam.ma 🇲🇦'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Admin Banner Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.textPrimary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.admin_panel_settings_rounded, color: Colors.white, size: 36),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Panneau de Contrôle Général',
                          style: AppTypography.headingSmall.copyWith(color: Colors.white),
                        ),
                        Text(
                          'Supervision du marché des services au Maroc',
                          style: AppTypography.bodySmall.copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text('Statistiques Globales', style: AppTypography.headingMedium),
            const SizedBox(height: 10),

            // Statistics Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                _buildAdminStatCard('Clients Inscrits', '14,250', Icons.people_outline, AppColors.primary),
                _buildAdminStatCard('Artisans Vérifiés', '1,840', Icons.badge_outlined, AppColors.success),
                _buildAdminStatCard('Demandes Aujourd\'hui', '342', Icons.assignment_outlined, AppColors.warning),
                _buildAdminStatCard('Revenu Plateforme', '94,500 DH', Icons.payments_outlined, AppColors.primaryDark),
              ],
            ),
            const SizedBox(height: 24),

            Text('Gestion des Modules', style: AppTypography.headingMedium),
            const SizedBox(height: 10),

            Card(
              child: Column(
                children: [
                  _buildAdminMenuTile(
                    title: 'Gestion des Utilisateurs',
                    subtitle: 'Clients et professionnels',
                    icon: Icons.people,
                    trailingText: '16,090 total',
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  _buildAdminMenuTile(
                    title: 'Validation des Artisans (Kyc)',
                    subtitle: 'Documents d\'identité et diplômes',
                    icon: Icons.verified_user,
                    trailingText: '14 en attente',
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  _buildAdminMenuTile(
                    title: 'Catégories de Services',
                    subtitle: 'Plomberie, Électricité, Peinture...',
                    icon: Icons.category,
                    trailingText: '${AppConstants.moroccanCities.length} villes',
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  _buildAdminMenuTile(
                    title: 'Demandes & Interventions',
                    subtitle: 'Suivi des réclamations et litiges',
                    icon: Icons.work_history,
                    trailingText: '3 en cours',
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  _buildAdminMenuTile(
                    title: 'Signalements & Modération',
                    subtitle: 'Avis abusifs et blocages',
                    icon: Icons.report_problem_outlined,
                    trailingText: '0 urgent',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminStatCard(String label, String val, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: AppTypography.caption),
                Icon(icon, color: color, size: 20),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              val,
              style: AppTypography.headingMedium.copyWith(color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminMenuTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required String trailingText,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: AppTypography.labelLarge),
      subtitle: Text(subtitle, style: AppTypography.caption),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.primaryLighter,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              trailingText,
              style: AppTypography.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.chevron_right, size: 20, color: AppColors.textTertiary),
        ],
      ),
      onTap: onTap,
    );
  }
}
