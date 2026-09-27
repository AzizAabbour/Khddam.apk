import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/enums/enums.dart';
import '../../models/models.dart';
import '../../providers/app_provider.dart';

class ProfessionalProfileScreen extends StatelessWidget {
  const ProfessionalProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final pro = app.selectedProfessional ?? app.professionals.first;
    final reviews = app.getReviewsForProfessional(pro.id);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Custom Silver App Bar
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.gradientStart, AppColors.gradientEnd],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.white,
                        child: Text(
                          pro.fullName.substring(0, 2).toUpperCase(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            pro.fullName,
                            style: AppTypography.headingMedium.copyWith(color: Colors.white),
                          ),
                          if (pro.isVerified) ...[
                            const SizedBox(width: 4),
                            const Icon(Icons.verified, color: Colors.white, size: 18),
                          ],
                        ],
                      ),
                      Text(
                        '${pro.primaryService} • ${pro.city}',
                        style: AppTypography.bodySmall.copyWith(color: Colors.white.withValues(alpha: 0.9)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats card (Rating, Completed jobs, Experience)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem('⭐ ${pro.rating}', '${pro.reviewCount} avis'),
                          const SizedBox(
                            height: 30,
                            child: VerticalDivider(),
                          ),
                          _buildStatItem('${pro.completedJobs}', 'Travaux réalisés'),
                          const SizedBox(
                            height: 30,
                            child: VerticalDivider(),
                          ),
                          _buildStatItem('${pro.yearsExperience} ans', 'Expérience'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Call & Chat buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, '/create-request');
                          },
                          icon: const Icon(Icons.assignment_add),
                          label: const Text('Demander un service'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton.outlined(
                        onPressed: () {
                          Navigator.pushNamed(context, '/chat');
                        },
                        icon: const Icon(Icons.chat_bubble_outline, color: AppColors.primary),
                      ),
                      IconButton.outlined(
                        onPressed: () {},
                        icon: const Icon(Icons.phone_outlined, color: AppColors.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // About Bio
                  if (pro.bio != null) ...[
                    Text('À propos', style: AppTypography.headingMedium),
                    const SizedBox(height: 8),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Text(
                          pro.bio!,
                          style: AppTypography.bodyMedium.copyWith(height: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Services & Prices
                  Text('Services & Tarifs', style: AppTypography.headingMedium),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        children: pro.services.map((cat) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.check_circle, color: AppColors.primary, size: 18),
                                    const SizedBox(width: 8),
                                    Text(cat.displayNameFr, style: AppTypography.labelLarge),
                                  ],
                                ),
                                Text(
                                  pro.formattedPrice.isNotEmpty ? pro.formattedPrice : 'Sur devis',
                                  style: AppTypography.priceSmall,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Working Hours
                  Text('Horaires de travail', style: AppTypography.headingMedium),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        children: [
                          _buildHourRow('Lundi - Jeudi', '08:00 - 18:00'),
                          _buildHourRow('Vendredi', '08:00 - 12:00, 14:00 - 18:00'),
                          _buildHourRow('Samedi', '09:00 - 14:00'),
                          _buildHourRow('Dimanche', 'Fermé', isOff: true),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Customer Reviews
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Avis clients (${reviews.length})', style: AppTypography.headingMedium),
                    ],
                  ),
                  const SizedBox(height: 8),

                  if (reviews.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Aucun avis pour le moment.'),
                    )
                  else
                    ...reviews.map((rev) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(rev.customerName, style: AppTypography.labelLarge),
                                  Row(
                                    children: [
                                      const Icon(Icons.star, color: AppColors.star, size: 16),
                                      const SizedBox(width: 4),
                                      Text('${rev.rating}', style: AppTypography.labelMedium),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              if (rev.comment != null)
                                Text(
                                  rev.comment!,
                                  style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                                ),
                            ],
                          ),
                        ),
                      );
                    }),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String val, String label) {
    return Column(
      children: [
        Text(val, style: AppTypography.headingMedium.copyWith(color: AppColors.primary)),
        const SizedBox(height: 2),
        Text(label, style: AppTypography.caption),
      ],
    );
  }

  Widget _buildHourRow(String day, String hours, {bool isOff = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day, style: AppTypography.bodySmall),
          Text(
            hours,
            style: AppTypography.labelMedium.copyWith(
              color: isOff ? AppColors.error : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
