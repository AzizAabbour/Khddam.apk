import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/enums/enums.dart';
import '../../providers/app_provider.dart';
import '../../providers/auth_provider.dart';

class ProDashboardScreen extends StatelessWidget {
  const ProDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final app = context.watch<AppProvider>();
    final stats = app.professionalStats;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Espace Professionnel'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {
              auth.switchRole(UserRole.customer);
            },
            tooltip: 'Mode Client',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bonjour, Yassine 👋', style: AppTypography.headingLarge),
                    Text('Plombier certifié • Casablanca', style: AppTypography.bodySmall),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.successLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'En ligne',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Stat Cards Grid
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    title: 'Demandes en attente',
                    value: '${stats['pending_requests']}',
                    icon: Icons.pending_actions_rounded,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    title: 'Travaux réalisés',
                    value: '${stats['completed_jobs']}',
                    icon: Icons.verified_rounded,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildStatCard(
              title: 'Revenus ce mois',
              value: '${stats['earnings_month']} DH',
              subtitle: 'Total cumulé: ${stats['earnings_total']} DH',
              icon: Icons.account_balance_wallet_rounded,
              color: AppColors.primaryDark,
              isFullWidth: true,
            ),
            const SizedBox(height: 24),

            // Quick Nav Row
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/pro-availability');
                    },
                    icon: const Icon(Icons.schedule, size: 18),
                    label: const Text('Disponibilité'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/pro-earnings');
                    },
                    icon: const Icon(Icons.bar_chart, size: 18),
                    label: const Text('Voir Revenus'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Recent Incoming Requests List
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Demandes reçues', style: AppTypography.headingMedium),
                Text('${app.requests.length} nouvelles', style: AppTypography.caption),
              ],
            ),
            const SizedBox(height: 12),

            ...app.requests.map((req) {
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 18,
                                backgroundColor: AppColors.primaryLighter,
                                child: Icon(Icons.person, size: 18, color: AppColors.primary),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(req.customerName, style: AppTypography.headingSmall),
                                  Text('${req.city} • ${req.address}', style: AppTypography.caption),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            req.budget != null ? '${req.budget!.toStringAsFixed(0)} DH' : 'Sur devis',
                            style: AppTypography.priceSmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        req.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                      ),
                      const Divider(height: 20),

                      if (req.status == RequestStatus.pending || req.status == RequestStatus.accepted)
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  app.updateRequestStatus(req.id, RequestStatus.rejected);
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.error,
                                  side: const BorderSide(color: AppColors.error),
                                ),
                                child: const Text('Refuser'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  app.updateRequestStatus(req.id, RequestStatus.accepted);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Demande acceptée! Le client a été notifié.'),
                                      backgroundColor: AppColors.success,
                                    ),
                                  );
                                },
                                child: const Text('Accepter'),
                              ),
                            ),
                          ],
                        )
                      else
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Statut: ${req.status.displayNameFr}',
                            textAlign: TextAlign.center,
                            style: AppTypography.labelSmall.copyWith(color: AppColors.primary),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    String? subtitle,
    required IconData icon,
    required Color color,
    bool isFullWidth = false,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppTypography.caption),
                Icon(icon, color: color, size: 22),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: AppTypography.headingLarge.copyWith(color: color, fontSize: isFullWidth ? 26 : 22),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(subtitle, style: AppTypography.caption),
            ],
          ],
        ),
      ),
    );
  }
}
