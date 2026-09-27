import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';

class ProAvailabilityScreen extends StatefulWidget {
  const ProAvailabilityScreen({super.key});

  @override
  State<ProAvailabilityScreen> createState() => _ProAvailabilityScreenState();
}

class _ProAvailabilityScreenState extends State<ProAvailabilityScreen> {
  bool _isAvailable = true;
  bool _vacationMode = false;

  final Map<String, bool> _activeDays = {
    'Lundi': true,
    'Mardi': true,
    'Mercredi': true,
    'Jeudi': true,
    'Vendredi': true,
    'Samedi': true,
    'Dimanche': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Gérer ma Disponibilité'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Switches
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text('Disponible pour de nouvelles demandes'),
                      subtitle: const Text('Les clients proches peuvent vous envoyer des demandes'),
                      value: _isAvailable,
                      activeColor: AppColors.success,
                      onChanged: (val) {
                        setState(() => _isAvailable = val);
                      },
                    ),
                    const Divider(height: 1),
                    SwitchListTile(
                      title: const Text('Mode Congés / Vacances'),
                      subtitle: const Text('Masquer temporairement votre profil des recherches'),
                      value: _vacationMode,
                      activeColor: AppColors.warning,
                      onChanged: (val) {
                        setState(() => _vacationMode = val);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            Text('Horaires de travail par jour', style: AppTypography.headingMedium),
            const SizedBox(height: 8),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: _activeDays.keys.map((day) {
                    final isEnabled = _activeDays[day]!;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(day, style: AppTypography.labelLarge),
                          ),
                          Switch(
                            value: isEnabled,
                            activeColor: AppColors.primary,
                            onChanged: (val) {
                              setState(() => _activeDays[day] = val);
                            },
                          ),
                          const Spacer(),
                          Text(
                            isEnabled ? '08:00 → 18:00' : 'Fermé',
                            style: AppTypography.bodySmall.copyWith(
                              color: isEnabled ? AppColors.textPrimary : AppColors.error,
                              fontWeight: isEnabled ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Disponibilité mise à jour!'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Enregistrer les modifications'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
