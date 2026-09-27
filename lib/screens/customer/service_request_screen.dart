import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_typography.dart';
import '../../core/enums/enums.dart';
import '../../providers/app_provider.dart';

class ServiceRequestScreen extends StatefulWidget {
  const ServiceRequestScreen({super.key});

  @override
  State<ServiceRequestScreen> createState() => _ServiceRequestScreenState();
}

class _ServiceRequestScreenState extends State<ServiceRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  late ServiceCategory _selectedCategory;
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();
  final _budgetController = TextEditingController();
  String _selectedCity = 'Casablanca';
  DateTime _preferredDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _preferredTime = const TimeOfDay(hour: 10, minute: 0);
  PaymentMethod _paymentMethod = PaymentMethod.cash;
  final List<String> _selectedPhotos = [];

  @override
  void initState() {
    super.initState();
    _selectedCategory = ServiceCategory.plumber;
    _addressController.text = '45 Rue Mohamed V, Maarif';
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _addressController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final app = context.read<AppProvider>();
      final pro = app.selectedProfessional;

      final success = await app.createRequest(
        category: _selectedCategory,
        description: _descriptionController.text.trim(),
        address: _addressController.text.trim(),
        city: _selectedCity,
        latitude: 33.5731,
        longitude: -7.5898,
        preferredDate: _preferredDate,
        preferredTime: '${_preferredTime.hour.toString().padLeft(2, '0')}:${_preferredTime.minute.toString().padLeft(2, '0')}',
        budget: _budgetController.text.isNotEmpty ? double.tryParse(_budgetController.text) : null,
        paymentMethod: _paymentMethod,
        professionalId: pro?.id,
      );

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Demande envoyée avec succès!'),
            backgroundColor: AppColors.success,
          ),
        );
        app.setNavIndex(2); // Go to Requests tab
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final pro = app.selectedProfessional;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(pro != null ? 'Demander à ${pro.fullName}' : 'Nouvelle demande'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pro Summary if selected
              if (pro != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLighter,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: Text(
                          pro.fullName.substring(0, 2).toUpperCase(),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(pro.fullName, style: AppTypography.headingSmall),
                            Text(pro.primaryService, style: AppTypography.bodySmall),
                          ],
                        ),
                      ),
                      Text(pro.formattedPrice, style: AppTypography.priceSmall),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // Category Picker
              Text('Catégorie de service', style: AppTypography.labelLarge),
              const SizedBox(height: 8),
              DropdownButtonFormField<ServiceCategory>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.category_outlined, color: AppColors.textSecondary),
                ),
                items: ServiceCategory.values.map((cat) {
                  return DropdownMenuItem(
                    value: cat,
                    child: Text(cat.displayNameFr),
                  );
                }).toList(),
                onChanged: (cat) {
                  if (cat != null) setState(() => _selectedCategory = cat);
                },
              ),
              const SizedBox(height: 20),

              // Problem Description
              Text('Description du problème', style: AppTypography.labelLarge),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Décrivez le problème en détail (ex: fuite d\'eau sous l\'évier, robinet qui goutte, prise cassée...)',
                  alignLabelWithHint: true,
                ),
                validator: (val) {
                  if (val == null || val.trim().length < 10) {
                    return 'Veuillez saisir une description d\'au moins 10 caractères';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Photos upload
              Text('Photos du problème (optionnel)', style: AppTypography.labelLarge),
              const SizedBox(height: 8),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedPhotos.add('photo_${_selectedPhotos.length + 1}.jpg');
                      });
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.border, style: BorderStyle.solid),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo_outlined, color: AppColors.primary),
                          SizedBox(height: 4),
                          Text('Ajouter', style: TextStyle(fontSize: 11, color: AppColors.primary)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _selectedPhotos.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryLighter,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Icon(Icons.image, color: AppColors.primary),
                                ),
                              ),
                              Positioned(
                                top: 2,
                                right: 10,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() => _selectedPhotos.removeAt(index));
                                  },
                                  child: const CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.close, size: 12, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Address & City
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ville', style: AppTypography.labelLarge),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _selectedCity,
                          items: AppConstants.moroccanCities.map((c) {
                            return DropdownMenuItem(value: c, child: Text(c));
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) setState(() => _selectedCity = val);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Text('Adresse complète', style: AppTypography.labelLarge),
              const SizedBox(height: 8),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_on_outlined, color: AppColors.textSecondary),
                  hintText: 'Rue, Quartier, Numéro d\'appartement...',
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Veuillez renseigner votre adresse';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Preferred Date & Time
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date souhaitée', style: AppTypography.labelLarge),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: _preferredDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(const Duration(days: 30)),
                            );
                            if (picked != null) {
                              setState(() => _preferredDate = picked);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.border),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.primary),
                                const SizedBox(width: 8),
                                Text(
                                  DateFormat('dd/MM/yyyy').format(_preferredDate),
                                  style: AppTypography.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Heure souhaitée', style: AppTypography.labelLarge),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () async {
                            final picked = await showTimePicker(
                              context: context,
                              initialTime: _preferredTime,
                            );
                            if (picked != null) {
                              setState(() => _preferredTime = picked);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.border),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.access_time_outlined, size: 18, color: AppColors.primary),
                                const SizedBox(width: 8),
                                Text(
                                  _preferredTime.format(context),
                                  style: AppTypography.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Budget
              Text('Budget estimé (DH) - Optionnel', style: AppTypography.labelLarge),
              const SizedBox(height: 8),
              TextFormField(
                controller: _budgetController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.payments_outlined, color: AppColors.textSecondary),
                  suffixText: 'DH',
                  hintText: 'Ex. 150',
                ),
              ),
              const SizedBox(height: 20),

              // Payment Method Picker
              Text('Mode de paiement', style: AppTypography.labelLarge),
              const SizedBox(height: 8),
              RadioListTile<PaymentMethod>(
                title: const Text('Espèces (Cash au professionnel)'),
                value: PaymentMethod.cash,
                groupValue: _paymentMethod,
                activeColor: AppColors.primary,
                contentPadding: EdgeInsets.zero,
                onChanged: (val) {
                  if (val != null) setState(() => _paymentMethod = val);
                },
              ),
              RadioListTile<PaymentMethod>(
                title: const Text('Paiement après service accompli'),
                value: PaymentMethod.afterService,
                groupValue: _paymentMethod,
                activeColor: AppColors.primary,
                contentPadding: EdgeInsets.zero,
                onChanged: (val) {
                  if (val != null) setState(() => _paymentMethod = val);
                },
              ),
              RadioListTile<PaymentMethod>(
                title: const Text('Paiement en ligne (Carte Bancaire Marocaine / CMI)'),
                value: PaymentMethod.online,
                groupValue: _paymentMethod,
                activeColor: AppColors.primary,
                contentPadding: EdgeInsets.zero,
                onChanged: (val) {
                  if (val != null) setState(() => _paymentMethod = val);
                },
              ),
              const SizedBox(height: 32),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: app.isLoading ? null : _submit,
                  child: app.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Envoyer la demande'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
