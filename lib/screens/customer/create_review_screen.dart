import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key});

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  double _rating = 5.0;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submit() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Merci pour votre avis! Il a été publié.'),
        backgroundColor: AppColors.success,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Laisser un avis'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Text(
                'Comment s\'est passée votre expérience?',
                textAlign: TextAlign.center,
                style: AppTypography.headingLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Votre avis aide la communauté marocaine à trouver les meilleurs artisans.',
                textAlign: TextAlign.center,
                style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),

              // Star rating selector
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final starVal = index + 1;
                  return IconButton(
                    iconSize: 40,
                    icon: Icon(
                      starVal <= _rating ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: AppColors.star,
                    ),
                    onPressed: () {
                      setState(() => _rating = starVal.toDouble());
                    },
                  );
                }),
              ),
              const SizedBox(height: 24),

              // Comment field
              TextFormField(
                controller: _commentController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Racontez-nous la qualité du travail, la ponctualité, la courtoisie...',
                ),
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Soumettre l\'avis'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
