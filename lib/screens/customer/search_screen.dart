import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_typography.dart';
import '../../core/enums/enums.dart';
import '../../providers/app_provider.dart';
import '../../widgets/professional_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _verifiedOnly = false;
  double _maxDistance = 25.0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final app = context.watch<AppProvider>();
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Filtres de recherche', style: AppTypography.headingMedium),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 12),

                  // City filter
                  Text('Ville', style: AppTypography.labelLarge),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: app.selectedCity,
                    items: AppConstants.moroccanCities.map((c) {
                      return DropdownMenuItem(value: c, child: Text(c));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) app.setSelectedCity(val);
                    },
                  ),
                  const SizedBox(height: 20),

                  // Distance Filter Slider
                  Text('Distance maximale: ${_maxDistance.round()} km', style: AppTypography.labelLarge),
                  Slider(
                    value: _maxDistance,
                    min: 1.0,
                    max: 50.0,
                    activeColor: AppColors.primary,
                    onChanged: (val) {
                      setModalState(() => _maxDistance = val);
                    },
                  ),
                  const SizedBox(height: 12),

                  // Verified Switch
                  SwitchListTile(
                    title: const Text('Professionnels vérifiés uniquement'),
                    value: _verifiedOnly,
                    activeColor: AppColors.primary,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (val) {
                      setModalState(() => _verifiedOnly = val);
                    },
                  ),
                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            app.setSelectedCategory(null);
                            app.setSearchQuery('');
                            Navigator.pop(context);
                          },
                          child: const Text('Réinitialiser'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Appliquer'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Rechercher un professionnel'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search & Filter header
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (query) => app.setSearchQuery(query),
                        decoration: InputDecoration(
                          hintText: 'Rechercher plombier, électricien...',
                          prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textSecondary),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                    app.setSearchQuery('');
                                  },
                                )
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton.filled(
                      onPressed: () => _showFilterBottomSheet(context),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: const Icon(Icons.tune_rounded, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Category Filter Pills
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ChoiceChip(
                        label: const Text('Tous'),
                        selected: app.selectedCategory == null,
                        onSelected: (selected) {
                          if (selected) app.setSelectedCategory(null);
                        },
                      ),
                      const SizedBox(width: 8),
                      ...ServiceCategory.values.map((cat) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(cat.displayNameFr),
                            selected: app.selectedCategory == cat,
                            selectedColor: AppColors.primary,
                            labelStyle: TextStyle(
                              color: app.selectedCategory == cat ? Colors.white : AppColors.textPrimary,
                              fontSize: 13,
                            ),
                            onSelected: (selected) {
                              app.setSelectedCategory(selected ? cat : null);
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Search Results
          Expanded(
            child: app.professionals.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.search_off_rounded, size: 64, color: AppColors.textTertiary),
                        const SizedBox(height: 16),
                        Text('Aucun résultat trouvé', style: AppTypography.headingMedium),
                        const SizedBox(height: 8),
                        Text(
                          'Essayez de modifier vos termes de recherche ou filtres.',
                          style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: app.professionals.length,
                    itemBuilder: (context, index) {
                      final pro = app.professionals[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
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
          ),
        ],
      ),
    );
  }
}
