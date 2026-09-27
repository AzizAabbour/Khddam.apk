import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/enums/enums.dart';
import '../../providers/locale_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    final localeProv = context.watch<LocaleProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Langue de l\'application', style: AppTypography.headingSmall),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  RadioListTile<AppLanguage>(
                    title: const Text('Français 🇫🇷'),
                    subtitle: const Text('Interface en français'),
                    value: AppLanguage.fr,
                    groupValue: localeProv.language,
                    activeColor: AppColors.primary,
                    onChanged: (lang) {
                      if (lang != null) localeProv.setLanguage(lang);
                    },
                  ),
                  const Divider(height: 1),
                  RadioListTile<AppLanguage>(
                    title: const Text('العربية 🇲🇦 (RTL)'),
                    subtitle: const Text('واجهة باللغة العربية'),
                    value: AppLanguage.ar,
                    groupValue: localeProv.language,
                    activeColor: AppColors.primary,
                    onChanged: (lang) {
                      if (lang != null) localeProv.setLanguage(lang);
                    },
                  ),
                  const Divider(height: 1),
                  RadioListTile<AppLanguage>(
                    title: const Text('الدارجة المغربية 🇲🇦'),
                    subtitle: const Text('Lqa chi professionnel qrib lik'),
                    value: AppLanguage.darija,
                    groupValue: localeProv.language,
                    activeColor: AppColors.primary,
                    onChanged: (lang) {
                      if (lang != null) localeProv.setLanguage(lang);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text('Préférences', style: AppTypography.headingSmall),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  SwitchListTile(
                    secondary: const Icon(Icons.notifications_outlined, color: AppColors.primary),
                    title: const Text('Notifications Push'),
                    subtitle: const Text('Recevoir les alertes de demandes et messages'),
                    value: _notificationsEnabled,
                    activeColor: AppColors.primary,
                    onChanged: (val) {
                      setState(() => _notificationsEnabled = val);
                    },
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    secondary: const Icon(Icons.dark_mode_outlined, color: AppColors.primary),
                    title: const Text('Mode sombre'),
                    subtitle: const Text('Thème sombre pour une meilleure visibilité nocturne'),
                    value: _darkModeEnabled,
                    activeColor: AppColors.primary,
                    onChanged: (val) {
                      setState(() => _darkModeEnabled = val);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text('Informations & Légal', style: AppTypography.headingSmall),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.help_outline, color: AppColors.primary),
                    title: const Text('Centre d\'aide & Support'),
                    trailing: const Icon(Icons.chevron_right, size: 20),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip_outlined, color: AppColors.primary),
                    title: const Text('Politique de confidentialité'),
                    trailing: const Icon(Icons.chevron_right, size: 20),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.info_outline, color: AppColors.primary),
                    title: const Text('À propos de Khddam.ma'),
                    trailing: const Icon(Icons.chevron_right, size: 20),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
