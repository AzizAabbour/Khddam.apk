import 'package:flutter/material.dart';

/// Khddam.ma brand colors
/// Professional blue + white identity for Moroccan services marketplace
class AppColors {
  AppColors._();

  // Primary
  static const Color primary = Color(0xFF2196F3);
  static const Color primaryLight = Color(0xFF42A5F5);
  static const Color primaryLighter = Color(0xFFE3F2FD);
  static const Color primaryDark = Color(0xFF1976D2);
  static const Color primaryDarker = Color(0xFF0D47A1);

  // Gradient
  static const Color gradientStart = Color(0xFF2196F3);
  static const Color gradientEnd = Color(0xFF64B5F6);

  // Neutrals
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderLight = Color(0xFFF1F5F9);
  static const Color divider = Color(0xFFE2E8F0);

  // Text
  static const Color textPrimary = Color(0xFF172033);
  static const Color textSecondary = Color(0xFF667085);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textLink = Color(0xFF2196F3);

  // Status
  static const Color success = Color(0xFF22C55E);
  static const Color successLight = Color(0xFFDCFCE7);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);

  // Rating
  static const Color star = Color(0xFFF59E0B);
  static const Color starEmpty = Color(0xFFE2E8F0);

  // Chat
  static const Color chatBubbleSent = Color(0xFF2196F3);
  static const Color chatBubbleReceived = Color(0xFFF1F5F9);
  static const Color chatBackground = Color(0xFFFFFFFF);

  // Skeleton
  static const Color skeleton = Color(0xFFE2E8F0);
  static const Color skeletonHighlight = Color(0xFFF1F5F9);

  // Dark theme
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkCard = Color(0xFF1E293B);
  static const Color darkBorder = Color(0xFF334155);
  static const Color darkTextPrimary = Color(0xFFF1F5F9);
  static const Color darkTextSecondary = Color(0xFF94A3B8);

  // Gradient
  static LinearGradient get primaryGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [gradientStart, gradientEnd],
      );

  static LinearGradient get subtleGradient => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [primaryLighter, white],
      );

  // Shadows
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.02),
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ];

  static List<BoxShadow> get elevatedShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];
}
