import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../providers/app_provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/professional_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final app = context.watch<AppProvider>();

    final favoriteIds = auth.user?.favoriteProIds ?? ['pro_001', 'pro_003'];
    final favorites = app.getFavorites(favoriteIds);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Mes Favoris'),
      ),
      body: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.favorite_border_rounded, size: 64, color: AppColors.textTertiary),
                  const SizedBox(height: 16),
                  Text('Aucun favori enregistré', style: AppTypography.headingMedium),
                  const SizedBox(height: 8),
                  Text(
                    'Enregistrez vos artisans préférés pour les retrouver rapidement.',
                    style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final pro = favorites[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ProfessionalCard(
                    professional: pro,
                    onTap: () {
                      app.selectProfessional(pro);
                      Navigator.pushNamed(context, '/professional-profile');
                    },
                  ),
                );
              },
            ),
    );
  }
}
