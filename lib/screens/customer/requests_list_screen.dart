import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/enums/enums.dart';
import '../../models/models.dart';
import '../../providers/app_provider.dart';

class RequestsListScreen extends StatelessWidget {
  const RequestsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Mes Demandes'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'En cours'),
              Tab(text: 'Historique'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Active requests
            _buildRequestList(context, app.activeRequests, isHistory: false),
            // History requests
            _buildRequestList(context, app.completedRequests, isHistory: true),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/create-request');
          },
          icon: const Icon(Icons.add),
          label: const Text('Nouvelle demande'),
        ),
      ),
    );
  }

  Widget _buildRequestList(BuildContext context, List<ServiceRequest> requests, {required bool isHistory}) {
    if (requests.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.assignment_late_outlined, size: 64, color: AppColors.textTertiary),
            const SizedBox(height: 16),
            Text(
              isHistory ? 'Aucun historique' : 'Aucune demande en cours',
              style: AppTypography.headingMedium,
            ),
            const SizedBox(height: 8),
            Text(
              isHistory
                  ? 'Vos interventions terminées apparaîtront ici.'
                  : 'Vos demandes de service apparaîtront ici.',
              style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<AppProvider>().setNavIndex(0);
              },
              child: const Text('Trouver un professionnel'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final req = requests[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () {
              context.read<AppProvider>().selectRequest(req);
              Navigator.pushNamed(context, '/request-details');
            },
            borderRadius: BorderRadius.circular(12),
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
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLighter,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.handyman, color: AppColors.primary, size: 18),
                          ),
                          const SizedBox(width: 10),
                          Text(req.category.displayNameFr, style: AppTypography.headingSmall),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: req.isCompleted ? AppColors.successLight : AppColors.primaryLighter,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          req.status.displayNameFr,
                          style: AppTypography.labelSmall.copyWith(
                            color: req.isCompleted ? AppColors.success : AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    req.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_month, size: 14, color: AppColors.textTertiary),
                          const SizedBox(width: 4),
                          Text(
                            DateFormat('dd/MM/yyyy').format(req.preferredDate),
                            style: AppTypography.caption,
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textTertiary),
                          const SizedBox(width: 4),
                          Text(req.city, style: AppTypography.caption),
                        ],
                      ),
                      if (req.budget != null)
                        Text(
                          '${req.budget!.toStringAsFixed(0)} DH',
                          style: AppTypography.priceSmall,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
