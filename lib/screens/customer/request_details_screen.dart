import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/enums/enums.dart';
import '../../models/models.dart';
import '../../providers/app_provider.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final request = app.selectedRequest ?? app.requests.first;

    final timelineSteps = [
      {'status': RequestStatus.pending, 'label': 'Demande créée', 'desc': 'Votre demande a été envoyée'},
      {'status': RequestStatus.reviewing, 'label': 'Examen du professionnel', 'desc': 'Le professionnel consulte les détails'},
      {'status': RequestStatus.accepted, 'label': 'Demande acceptée', 'desc': 'Rendez-vous confirmé'},
      {'status': RequestStatus.onTheWay, 'label': 'Professionnel en route', 'desc': 'En déplacement vers votre adresse'},
      {'status': RequestStatus.inProgress, 'label': 'Intervention en cours', 'desc': 'Le service est en cours d\'exécution'},
      {'status': RequestStatus.completed, 'label': 'Service terminé', 'desc': 'Intervention clôturée avec succès'},
    ];

    int currentStepIndex = timelineSteps.indexWhere((step) => step['status'] == request.status);
    if (currentStepIndex == -1) currentStepIndex = 2; // Default for accepted state

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Demande #${request.id.substring(0, 7)}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Request Status Timeline Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Statut de la demande', style: AppTypography.headingSmall),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLighter,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            request.status.displayNameFr,
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),

                    // Timeline items
                    ...List.generate(timelineSteps.length, (index) {
                      final isDone = index <= currentStepIndex;
                      final isCurrent = index == currentStepIndex;
                      final item = timelineSteps[index];

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isDone ? AppColors.primary : AppColors.border,
                                  border: isCurrent
                                      ? Border.all(color: AppColors.primaryLight, width: 3)
                                      : null,
                                ),
                                child: isDone
                                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                                    : null,
                              ),
                              if (index < timelineSteps.length - 1)
                                Container(
                                  width: 2,
                                  height: 32,
                                  color: index < currentStepIndex ? AppColors.primary : AppColors.border,
                                ),
                            ],
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['label'] as String,
                                    style: AppTypography.labelMedium.copyWith(
                                      color: isDone ? AppColors.textPrimary : AppColors.textTertiary,
                                      fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    item['desc'] as String,
                                    style: AppTypography.caption.copyWith(
                                      color: isDone ? AppColors.textSecondary : AppColors.textTertiary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Assigned Professional Card
            if (request.professionalName != null) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Artisan assigné', style: AppTypography.headingSmall),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColors.primaryLighter,
                            child: Icon(Icons.person, color: AppColors.primary),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(request.professionalName!, style: AppTypography.labelLarge),
                                Text(request.category.displayNameFr, style: AppTypography.bodySmall),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.pushNamed(context, '/chat');
                              },
                              icon: const Icon(Icons.chat_bubble_outline, size: 18),
                              label: const Text('Discuter'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.phone, size: 18),
                              label: const Text('Appeler'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Request Info Details
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Détails de l\'intervention', style: AppTypography.headingSmall),
                    const Divider(height: 20),

                    _buildInfoRow('Service', request.category.displayNameFr),
                    _buildInfoRow('Adresse', '${request.address}, ${request.city}'),
                    _buildInfoRow(
                      'Date & Heure',
                      '${DateFormat('dd/MM/yyyy').format(request.preferredDate)} à ${request.preferredTime}',
                    ),
                    if (request.budget != null) _buildInfoRow('Budget', '${request.budget!.toStringAsFixed(0)} DH'),
                    if (request.finalPrice != null)
                      _buildInfoRow('Prix final', '${request.finalPrice!.toStringAsFixed(0)} DH'),
                    _buildInfoRow('Mode de paiement', request.paymentMethod.name.toUpperCase()),

                    const SizedBox(height: 12),
                    Text('Description', style: AppTypography.labelMedium),
                    const SizedBox(height: 4),
                    Text(
                      request.description,
                      style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            if (request.status == RequestStatus.completed)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/create-review');
                  },
                  icon: const Icon(Icons.star_outline),
                  label: const Text('Évaluer le professionnel'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
          Flexible(
            child: Text(
              value,
              style: AppTypography.labelMedium,
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
