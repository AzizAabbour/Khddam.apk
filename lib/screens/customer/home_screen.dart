import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_typography.dart';
import '../../core/enums/enums.dart';
import '../../models/models.dart';
import '../../providers/app_provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/professional_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final app = context.watch<AppProvider>();
    final user = auth.user;

    final categories = [
      {'cat': ServiceCategory.plumber, 'label': 'Plombier', 'icon': Icons.plumbing_rounded},
      {'cat': ServiceCategory.electrician, 'label': 'Électricien', 'icon': Icons.electrical_services_rounded},
      {'cat': ServiceCategory.cleaning, 'label': 'Nettoyage', 'icon': Icons.cleaning_services_rounded},
      {'cat': ServiceCategory.painting, 'label': 'Peinture', 'icon': Icons.format_paint_rounded},
      {'cat': ServiceCategory.mechanic, 'label': 'Mécanicien', 'icon': Icons.build_rounded},
      {'cat': ServiceCategory.carpenter, 'label': 'Menuisier', 'icon': Icons.carpenter_rounded},
      {'cat': ServiceCategory.applianceRepair, 'label': 'Électroménager', 'icon': Icons.kitchen_rounded},
      {'cat': ServiceCategory.moving, 'label': 'Déménagement', 'icon': Icons.local_shipping_rounded},
      {'cat': ServiceCategory.gardening, 'label': 'Jardinage', 'icon': Icons.yard_rounded},
      {'cat': ServiceCategory.other, 'label': 'Autre', 'icon': Icons.more_horiz_rounded},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => app.loadData(),
          child: CustomScrollView(
            slivers: [
              // Header & Search Banner
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top User & Location Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bonjour, ${user?.fullName.split(' ').first ?? 'Aziz'} 👋',
                                style: AppTypography.headingLarge,
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 14, color: AppColors.primary),
                                  const SizedBox(width: 4),
                                  DropdownButton<String>(
                                    value: app.selectedCity,
                                    underline: const SizedBox(),
                                    isDense: true,
                                    style: AppTypography.bodySmall.copyWith(
                                      color: AppColors.textSecondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    items: AppConstants.moroccanCities.map((c) {
                                      return DropdownMenuItem(
                                        value: c,
                                        child: Text('$c, Maroc'),
                                      );
                                    }).toList(),
                                    onChanged: (city) {
                                      if (city != null) app.setSelectedCity(city);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Notification Button
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/notifications');
                            },
                            icon: Badge(
                              isLabelVisible: app.unreadNotifications > 0,
                              label: Text('${app.unreadNotifications}'),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryLighter,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.notifications_none_rounded,
                                  color: AppColors.primary,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Search bar
                      GestureDetector(
                        onTap: () {
                          app.setNavIndex(1); // Go to Search tab
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.search_rounded, color: AppColors.textSecondary, size: 22),
                              const SizedBox(width: 12),
                              Text(
                                'De quel service avez-vous besoin?',
                                style: AppTypography.bodyMedium.copyWith(color: AppColors.textTertiary),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.tune_rounded, color: Colors.white, size: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Hero Banner
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: AppColors.cardShadow,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '🇲🇦 Service 100% Marocain',
                                  style: AppTypography.labelSmall.copyWith(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Un problème à la maison?',
                                style: AppTypography.headingMedium.copyWith(color: Colors.white),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Trouvez un artisan certifié en quelques clics.',
                                style: AppTypography.bodySmall.copyWith(color: Colors.white.withValues(alpha: 0.9)),
                              ),
                              const SizedBox(height: 14),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/create-request');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: AppColors.primary,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Demander un service',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.handyman_rounded,
                          size: 70,
                          color: Colors.white24,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Categories Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Catégories de services', style: AppTypography.headingMedium),
                      TextButton(
                        onPressed: () {
                          app.setNavIndex(1);
                        },
                        child: const Text('Voir tout'),
                      ),
                    ],
                  ),
                ),
              ),

              // Categories Grid
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.78,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = categories[index];
                      final cat = item['cat'] as ServiceCategory;
                      final label = item['label'] as String;
                      final icon = item['icon'] as IconData;

                      return GestureDetector(
                        onTap: () {
                          app.setSelectedCategory(cat);
                          app.setNavIndex(1); // Navigate to search
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: AppColors.border),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.02),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Icon(icon, color: AppColors.primary, size: 24),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              label,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.textPrimary,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: categories.length,
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 20)),

              // Featured Professionals Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Professionnels recommandés', style: AppTypography.headingMedium),
                      TextButton(
                        onPressed: () {
                          app.setNavIndex(1);
                        },
                        child: const Text('Voir tout'),
                      ),
                    ],
                  ),
                ),
              ),

              // Professionals List
              if (app.isLoading)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final pro = app.professionals[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        child: ProfessionalCard(
                          professional: pro,
                          onTap: () {
                            app.selectProfessional(pro);
                            Navigator.pushNamed(context, '/professional-profile');
                          },
                        ),
                      );
                    },
                    childCount: app.professionals.length,
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 30)),
            ],
          ),
        ),
      ),
    );
  }
}
